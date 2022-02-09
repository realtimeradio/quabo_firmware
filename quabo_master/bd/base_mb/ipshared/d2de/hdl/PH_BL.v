`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 02:14:57 PM
// Design Name: 
// Module Name: PH_BL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PH_BL(
    input clk,
    input rst,
    //axi interface for reading/writing BL BRAM
    input axi_bl_ena,
    input axi_bl_wea,
    input [7:0] axi_bl_addr,
    input [15:0] axi_bl_data_in,
    output [15:0] axi_bl_data_out,
    input axi_bl_enable,
    //axi interface for reading/writing Remapping BRAM
    input axi_remap_ena,
    input axi_remap_wea,
    input [7:0] axi_remap_addr,
    input [7:0] axi_remap_data_in,
    output [7:0] axi_remap_data_out,
    //interface connected to PH_Cache
    input ph_cache_valid,
    output ph_cache_enb,
    output [7:0] ph_cache_raddr,
    input [15:0] ph_cache_data,
    //interface connected to HS-PH core
    input start_to_read,
    output [31:0] rdata_to_user,
    output ready_to_read,
    // rst for ph_fifo
    input arst_for_phfifo
    );

reg ph_cache_valid_d1;
always @(posedge clk)
begin
    if(rst)
        ph_cache_valid_d1 <= 0;
    else
        ph_cache_valid_d1 <= ph_cache_valid;
end

reg ph_remap_enb;
reg [7:0] ph_remap_addr;
always @(posedge clk)
begin
    if(rst)
        ph_remap_enb <= 0;
    else if((ph_cache_valid == 1) && (ph_cache_valid_d1 ==0))
        ph_remap_enb <= 1;
    else if(ph_remap_addr == 255)
        ph_remap_enb <= 0;
    else
        ph_remap_enb <= ph_remap_enb;
end

always @(posedge clk)
begin
    if(rst)
        ph_remap_addr <= 0;
    else if(ph_remap_enb == 1)
        ph_remap_addr <= ph_remap_addr + 1;
    else 
        ph_remap_addr <= 0;
end

wire [7:0] ph_remap_data;
remap_bram ph_remap (
  .clka(clk),                   // input wire clka
  .rsta(rst),                   // input wire rsta
  .ena(axi_remap_ena),          // input wire ena
  .wea(axi_remap_wea),          // input wire [0 : 0] wea
  .addra(axi_remap_addr),       // input wire [7 : 0] addra
  .dina(axi_remap_data_in),     // input wire [7 : 0] dina
  .douta(axi_remap_data_out),   // output wire [7 : 0] douta
  .clkb(clk),                   // input wire clkb
  .rstb(rst),                   // input wire rstb
  .enb(ph_remap_enb),           // input wire enb
  .web(1'b0),                   // input wire [0 : 0] web
  .addrb(ph_remap_addr),        // input wire [7 : 0] addrb
  .dinb(8'h05),                 // input wire [7 : 0] dinb
  .doutb(ph_remap_data)         // output wire [7 : 0] doutb
);
//ph_bl_enb is 2-clk delay of ph_remap_enb
//reg ph_bl_enb, ph_remap_enb_d1;
//try to delay 1-clk
reg ph_bl_enb;
always @(posedge clk)
begin
    if(rst)
        begin
            //ph_remap_enb_d1 <= 0;
            ph_bl_enb       <= 0;
        end
    else
        begin
            /*
            ph_remap_enb_d1 <= ph_remap_enb;
            ph_bl_enb       <= ph_remap_enb_d1;
            */
            ph_bl_enb       <= ph_remap_enb;
        end
end
//the data stored in the pl_bl is complement code
wire [15:0] ph_bl_data;
bl_bram ph_bl (
  .clka(clk),                   // input wire clka
  .rsta(rst),                   // input wire rsta
  .ena(axi_bl_ena),             // input wire ena
  .wea(axi_bl_wea),             // input wire [0 : 0] wea
  .addra(axi_bl_addr),          // input wire [7 : 0] addra
  .dina(axi_bl_data_in),        // input wire [15 : 0] dina
  .douta(axi_bl_data_out),      // output wire [15 : 0] douta
  .clkb(clk),                   // input wire clkb
  .rstb(rst),                   // input wire rstb
  .enb(ph_bl_enb),              // input wire enb
  .web(1'b0),                   // input wire [0 : 0] web
  .addrb(ph_remap_data),        // input wire [7 : 0] addrb
  .dinb(16'h0505),              // input wire [15 : 0] dinb
  .doutb(ph_bl_data)            // output wire [15 : 0] doutb
);

// the enb and addr of ph_cache and ph_bl are the same
assign ph_cache_enb     = ph_bl_enb;
assign ph_cache_raddr   = ph_remap_data;

//next we need to subtract the baseline, and then put the result into a fifo
reg [15:0] pl_sub_data;
always @(posedge clk)
begin
    if(rst)
        pl_sub_data <= 0;
    else if(axi_bl_enable)
        pl_sub_data <= ph_cache_data + ph_bl_data; //ph_bl_data is in complement code here, so the highest bit of ph_bl_data should always be 1.
    else
        pl_sub_data <= ph_cache_data;
end

wire [31:0] rdata_to_user_tmp;
reg phfifo_wr_en; //it's three clk delay of ph_bl_enb.
wire phfifo_full;

//phfifo_wr_en is 3-clk delay
//reg ph_bl_enb_d1, ph_bl_enb_d2;
//try to delay 2-clk: 1clk is for reading data from ram, another is for adding
reg ph_bl_enb_d1;
always @(posedge clk)
begin
    if(rst)
        begin
            ph_bl_enb_d1    <= 0;
            //ph_bl_enb_d2    <= 0;
            phfifo_wr_en    <= 0;
        end
    else
        begin
            ph_bl_enb_d1    <= ph_bl_enb;
            /*
            ph_bl_enb_d2    <= ph_bl_enb_d1;
            phfifo_wr_en    <= ph_bl_enb_d2;
            */
            phfifo_wr_en    <= ph_bl_enb_d1;
        end
end

phfifo phfifo0 (
  .clk(clk),                    // input wire clk
  .srst(rst | arst_for_phfifo), // input wire srst
  .din(pl_sub_data),            // input wire [31 : 0] din
  .wr_en(phfifo_wr_en),         // input wire wr_en
  .rd_en(start_to_read),        // input wire rd_en
  .dout(rdata_to_user_tmp),     // output wire [31 : 0] dout
  .full(phfifo_full),           // output wire full
  .empty()                      // output wire empty
);
assign ready_to_read = phfifo_full;

assign rdata_to_user = {rdata_to_user_tmp[15:15],    //bit31
                        rdata_to_user_tmp[15:15],    //bit30
                        rdata_to_user_tmp[15:15],    //bit29
                        rdata_to_user_tmp[15:15],    //bit28
                        rdata_to_user_tmp[15:15],    //bit27
                        rdata_to_user_tmp[15:15],    //bit26
                        rdata_to_user_tmp[15:15],    //bit25
                        rdata_to_user_tmp[15:15],    //bit24
                        rdata_to_user_tmp[15:15],    //bit23
                        rdata_to_user_tmp[15:15],    //bit22
                        rdata_to_user_tmp[15:15],    //bit21
                        rdata_to_user_tmp[15:15],    //bit20
                        rdata_to_user_tmp[15:15],    //bit19
                        rdata_to_user_tmp[15:15],    //bit18
                        rdata_to_user_tmp[15:15],    //bit17
                        rdata_to_user_tmp[15:15],    //bit16
                        rdata_to_user_tmp};

endmodule
