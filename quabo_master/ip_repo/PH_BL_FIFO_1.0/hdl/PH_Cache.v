`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2021 07:04:37 PM
// Design Name: 
// Module Name: PH_Cache
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


module PH_Cache(
    input clk,
    input rst,
    // ports connected to maroc_dc core
	input wire[31:0]axi_str_rxd_tdata,
    input wire axi_str_rxd_tlast,
    input wire axi_str_rxd_tvalid,
    output wire axi_str_rxd_tready,
    // control sigianl for writing ph data into the bram 
    input axi_wr,
    input [7:0] axi_ph_raddr,
    output [31:0] axi_ph_data_cache,
    input axi_buf_sel,
    //BL ram related signals
    input [7:0] axi_bl_addr,
    input [31:0] axi_bl_data_in,
    input axi_bl_wea,
    output [31:0] axi_bl_data_out
    );
    
// write logic
// waddr is related to the valid
reg [7:0] waddr;
always @(posedge clk)
begin
    if(rst)
        waddr <= 0;
    else if(axi_str_rxd_tvalid==1)
        waddr <= waddr + 1;
    else
        waddr <= 0;
end
//ena_is related to axi control and valid 
reg pingpong_sel;
always @(posedge clk)
begin
    if(rst)
        pingpong_sel <= 1;
    else if(axi_str_rxd_tlast == 1)
        pingpong_sel <= ~pingpong_sel; //valid means this is the end of data frame
    else
        pingpong_sel <= pingpong_sel;
    
end

//bram related signal
wire bram_ena0;
assign bram_ena0 = axi_wr & axi_str_rxd_tvalid & pingpong_sel;
//addr is from waddr or axi bus
wire [7:0] ph_cache0_addr;
assign ph_cache0_addr = (axi_wr)?waddr:axi_ph_raddr;
wire [31:0] ph_cache0_data;
wire [31:0] ph_data_out0;
ph_bram ph_cache0 (
  .clka(clk),               // input wire clka
  .rsta(rst),               // input wire rsta
  .ena(bram_ena0),          // input wire ena
  .wea(axi_wr),             // input wire [0 : 0] wea
  .addra(ph_cache0_addr),   // input wire [7 : 0] addra
  .dina(axi_str_rxd_tdata), // input wire [31 : 0] dina
  .douta(ph_cache0_data),   // output wire [31 : 0] douta
  .clkb(clk),               // input wire clkb
  .rstb(rst),               // input wire rstb
  .enb(~bram_ena0),         // input wire enb
  .web(1'b0),               // input wire [0 : 0] web 1: w; 0: r
  .addrb(waddr),            // input wire [7 : 0] addrb
  .dinb(32'b0),             // input wire [31 : 0] dinb
  .doutb(ph_data_out0)      // output wire [31 : 0] doutb
);

//bram related signal
wire bram_ena1;
assign bram_ena1 = axi_wr & axi_str_rxd_tvalid & (~pingpong_sel);
//addr is from waddr or axi bus
wire [7:0] ph_cache1_addr;
assign ph_cache1_addr = (axi_wr)?waddr:axi_ph_raddr;
wire [31:0] ph_cache1_data;
wire [31:0] ph_data_out1;
ph_bram ph_cache1 (
  .clka(clk),               // input wire clka
  .rsta(rst),               // input wire rsta
  .ena(bram_ena1),          // input wire ena
  .wea(axi_wr),             // input wire [0 : 0] wea
  .addra(ph_cache1_addr),   // input wire [7 : 0] addra
  .dina(axi_str_rxd_tdata), // input wire [31 : 0] dina
  .douta(ph_cache1_data),   // output wire [31 : 0] douta
  .clkb(clk),               // input wire clkb
  .rstb(rst),               // input wire rstb
  .enb(~bram_ena1),         // input wire enb
  .web(1'b0),               // input wire [0 : 0] web
  .addrb(waddr),            // input wire [7 : 0] addrb
  .dinb(32'b0),             // input wire [31 : 0] dinb
  .doutb(ph_data_out1)      // output wire [31 : 0] doutb
);

//bl bram
wire [31:0] bl_data;
ph_bram bl_bram (
  .clka(clk),               // input wire clka
  .rsta(rst),               // input wire rsta
  .ena(1'b1),               // input wire ena
  .wea(axi_bl_wea),         // input wire [0 : 0] wea
  .addra(axi_bl_addr),      // input wire [7 : 0] addra
  .dina(axi_bl_data_in),    // input wire [31 : 0] dina
  .douta(axi_bl_data_out),  // output wire [31 : 0] douta
  .clkb(clk),               // input wire clkb
  .rstb(rst),               // input wire rstb
  .enb(1'b1),               // input wire enb
  .web(1'b0),               // input wire [0 : 0] web
  .addrb(waddr),            // input wire [7 : 0] addrb
  .dinb(32'b0),             // input wire [31 : 0] dinb
  .doutb(bl_data)           // output wire [31 : 0] doutb
);

endmodule
