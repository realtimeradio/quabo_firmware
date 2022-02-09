`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PANOSETI Team
// Engineer: Wei Liu
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
    input axi_cache_read,
    input axi_cache_sel,
    input [7:0] axi_cache_raddr,
    output [15:0] axi_cache_data,
    //signal between ph_cache and ph_bl
    output reg ph_cache_valid,    //it means the last seriel ph_data is stored in the ph_cache
    input ph_cache_enb,
    input [7:0] ph_cache_raddr,
    output [15:0] ph_cache_data,
    //elapsed_time
    output reg [31:0] ph_elapsed_time
    );
    
//reg ph_ready;
wire ph_valid;
wire ph_last;
wire [31:0] ph_data;
assign ph_valid = axi_str_rxd_tvalid;
assign ph_last = axi_str_rxd_tlast;
assign ph_data = axi_str_rxd_tdata;
assign axi_str_rxd_tready = 1; //always ready to receive data!

reg ph_valid_d1, ph_valid_d2, ph_valid_d3;
reg ph_last_d1, ph_last_d2, ph_last_d3;
reg [31:0] ph_data_d1, ph_data_d2, ph_data_d3;
always @(posedge clk)
begin
    if(rst)
        begin
            ph_valid_d1 <= 0;
            ph_last_d1  <= 0;
            ph_data_d1  <= 0;
            
            ph_valid_d2 <= 0;
            ph_last_d2  <= 0;
            ph_data_d2  <= 0;
            
            ph_last_d3  <= 0;
            ph_data_d3  <= 0;
            ph_data_d3  <= 0;
        end
    else
        begin
            ph_valid_d1 <= ph_valid;
            ph_last_d1  <= ph_last;
            ph_data_d1  <= ph_data;
            
            ph_valid_d2 <= ph_valid_d1;
            ph_last_d2  <= ph_last_d1;
            ph_data_d2  <= ph_data_d1;
            
            ph_valid_d3 <= ph_valid_d2;
            ph_last_d3  <= ph_last_d2;
            ph_data_d3  <= ph_data_d2;
        end
end

//when microbalze core is reading data from ph_cache, PH_BL shouldn't be able to get ph data from ph_cache
//assign ph_cache_valid = ~axi_cache_read & ph_valid_d3;
reg ph_valid_reset;
always @(posedge clk)
begin
    if(rst)
        ph_cache_valid  <= 0;
    else if((ph_cache0_addr == 254) || (ph_cache1_addr == 254))
        ph_cache_valid  <= 1;
    else if((ph_cache_raddr == 255) || (ph_valid_reset == 1))
        ph_cache_valid  <= 0;
    else
        ph_cache_valid  <= ph_cache_valid;
end

parameter integer ADC_LATENCE_VAL = 20;
parameter [4:0] IDLE            = 5'b00000,
                ADC_LATENCE     = 5'b00001,
                GET_PH_DATA     = 5'b00010,
                GET_TIME_INFO   = 5'b00100,
                WEIRD_LEN       = 5'b01000,
                AXI_CTL         = 5'b10000;
                
reg [4:0] ph_state;
reg [4:0] next_state;

reg [5:0]ph_cnt; //This is a counter for ph_data
reg [1:0] ph_data_index;
reg ph_cache0_ena;
reg ph_cache0_wea;
reg [7:0] ph_cache0_addr;
reg ph_cache1_ena;
reg ph_cache1_wea;
reg [7:0] ph_cache1_addr;
reg ph_cache_sel;

always @(posedge clk)
begin
    if(rst)
        ph_state <= IDLE;
    else
        ph_state <= next_state;
end

always @(ph_state or ph_valid or ph_valid_d1 or ph_cnt or ph_cache0_addr or ph_cache1_addr or axi_cache_read or ph_last_d2)
begin
    if(rst)
        next_state <= IDLE;
    else
        begin
            case(ph_state)
                IDLE:
                    begin
                        if(axi_cache_read == 1)
                            next_state = AXI_CTL;
                        else if((ph_valid == 1) && (ph_valid_d1 == 0)) // valid signal is the trigger for the state machine
                            next_state = ADC_LATENCE;
                        else
                            next_state = IDLE;
                     end
                ADC_LATENCE:
                    begin
                        if(ph_cnt == ADC_LATENCE_VAL - 1)
                            next_state = GET_PH_DATA;
                        else
                            next_state = ADC_LATENCE;
                    end
                GET_PH_DATA:
                    begin
                        if((ph_cache0_addr == 254) || (ph_cache1_addr == 254)) 
                            next_state = GET_TIME_INFO;
                        else if(ph_last_d2) // this is for some weird packets, the length of which is not correct.
                            next_state = WEIRD_LEN;
                        else
                            next_state = GET_PH_DATA;
                    end
                GET_TIME_INFO:
                    begin
                        if(ph_last_d2)
                            next_state = IDLE;
                        else
                            next_state = GET_TIME_INFO;
                    end
                WEIRD_LEN:
                    begin
                        next_state = IDLE;
                    end
                AXI_CTL:
                    begin
                        if(axi_cache_read == 1)
                            next_state = AXI_CTL;
                        else
                            next_state = GET_TIME_INFO;
                    end
                default:
                    next_state = IDLE;
              endcase
        end
end

always @(posedge clk)
begin
    if(rst)
        begin
            ph_cnt          <= 0;
            ph_data_index   <= 0;
            ph_cache0_ena   <= 0;
            ph_cache0_wea   <= 0;
            ph_cache0_addr  <= 0;
            ph_cache1_ena   <= 0;
            ph_cache1_wea   <= 0;
            ph_cache1_addr  <= 0;
            ph_cache_sel    <= 0;
            //ph_ready        <= 0;
            ph_valid_reset  <= 0;
            ph_elapsed_time <= 0;
        end
     else 
        begin
            case(ph_state)
                IDLE:
                    begin
                        ph_cnt          <= 0;
                        ph_data_index   <= 0;
                        ph_cache0_ena   <= 0;
                        ph_cache0_wea   <= 0;
                        ph_cache0_addr  <= 0;
                        ph_cache1_ena   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache1_addr  <= 0;
                        ph_cache_sel    <= ph_cache_sel;
                        ph_valid_reset  <= 0;
                        //ph_ready        <= 0;
                        ph_elapsed_time <= ph_elapsed_time;
                    end
                ADC_LATENCE:
                    begin
                        if(ph_valid_d1 == 1)
                            ph_cnt      <= ph_cnt + 1;
                        else
                            ph_cnt      <= ph_cnt;
                        ph_data_index   <= 0;
                        ph_cache0_ena   <= 0;
                        ph_cache0_wea   <= 0;
                        ph_cache0_addr  <= 0;
                        ph_cache1_ena   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache1_addr  <= 0;
                        /*
                        if(ph_cnt == ADC_LATENCE_VAL - 1)
                            ph_cache_sel    <= ~ph_cache_sel;
                        else
                            ph_cache_sel    <= ph_cache_sel;
                        */
                        ph_cache_sel    <= ph_cache_sel;
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 0;
                        ph_elapsed_time <= ph_elapsed_time;
                    end
                GET_PH_DATA:
                    begin
                        ph_cnt  <= 0;
                        if(ph_valid_d1 ==1)
                            ph_data_index   <= ph_data_index + 1;
                        else
                            ph_data_index   <= 0;
                        if(ph_cache_sel == 1)
                            begin
                                ph_cache0_ena   <= ~ph_data_index[1] & ph_valid_d1;
                                ph_cache1_ena   <= 0;
                            end
                        else
                            begin
                                ph_cache0_ena   <= 0;
                                ph_cache1_ena   <= ~ph_data_index[1] & ph_valid_d1;
                            end
                        if(ph_cache0_ena == 1)
                             ph_cache0_addr     <= ph_cache0_addr + 2;
                        else
                             ph_cache0_addr     <= ph_cache0_addr;
                        if(ph_cache1_ena == 1)
                             ph_cache1_addr     <= ph_cache1_addr + 2;
                        else
                             ph_cache1_addr     <= ph_cache1_addr;
                        ph_cache0_wea   <= 1;           //1 = W; 0 = R.
                        ph_cache1_wea   <= 1;
                        ph_cache_sel    <= ph_cache_sel;
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 0;
                        ph_elapsed_time <= ph_elapsed_time;
                        
                    end
                 WEIRD_LEN:
                    begin
                        ph_cnt          <= 0;
                        ph_data_index   <= 0;
                        ph_cache0_ena   <= 0;
                        ph_cache0_wea   <= 0;
                        ph_cache0_addr  <= 0;
                        ph_cache1_ena   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache1_addr  <= 0;
                        ph_cache_sel    <= ph_cache_sel;
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 0;
                        ph_elapsed_time <= ph_elapsed_time;
                    end
                 GET_TIME_INFO:// this time info is not useful here, so we just get it from fifo, and throw it.
                    begin
                        ph_cnt          <= 0;
                        ph_data_index   <= 0;
                        ph_cache0_ena   <= 0;
                        ph_cache0_wea   <= 0;
                        ph_cache0_addr  <= 0;
                        ph_cache1_ena   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache1_addr  <= 0;
                        ph_cache_sel    <= ~ph_cache_sel;
                        /*
                        if((ph_cache0_addr == 254) || (ph_cache1_addr == 254))
                            ph_cache_sel    <= ~ph_cache_sel;
                        else
                            ph_cache_sel    <= ph_cache_sel;
                        */
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 0;
                        ph_elapsed_time <= ph_data_d2;
                    end
                 AXI_CTL:
                    begin
                        ph_cnt          <= 0;
                        ph_data_index   <= 0;
                        ph_cache_sel    <= ph_cache_sel;
                        ph_cache0_ena   <= 1;           // Both of the BRAMs are enable for reading, axi_cache_sel will be used for the selection of output data
                        ph_cache1_ena   <= 1;
                        ph_cache0_wea   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache0_addr  <= axi_cache_raddr;
                        ph_cache1_addr  <= axi_cache_raddr;
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 1;
                        ph_elapsed_time <= 0;
                    end
                 default:
                    begin
                        ph_cnt          <= 0;
                        ph_data_index   <= 0;
                        ph_cache0_ena   <= 0;
                        ph_cache0_wea   <= 0;
                        ph_cache0_addr  <= 0;
                        ph_cache1_ena   <= 0;
                        ph_cache1_wea   <= 0;
                        ph_cache1_addr  <= 0;
                        ph_cache_sel    <= 0;
                        //ph_ready        <= 1;
                        ph_valid_reset  <= 0;
                        ph_elapsed_time <= 0;
                    end
            endcase
        end
end

wire [31:0] ph_data_d2_tmp;
assign ph_data_d2_tmp = ph_data_d2 & 32'h0fff0fff;

wire [15:0] ph_cache0_data, ph_cache1_data;
wire [15:0] axi_cache0_data;
ph_bram ph_cache0 (
  .clka(clk),                       // input wire clka
  .rsta(rst),                       // input wire rsta
  .ena(ph_cache0_ena),              // input wire ena
  .wea(ph_cache0_wea),              // input wire [0 : 0] wea
  .addra(ph_cache0_addr),           // input wire [7 : 0] addra
  .dina(ph_data_d2_tmp),            // input wire [15 : 0] dina
  .douta(axi_cache0_data),          // output wire [15 : 0] douta
  .clkb(clk),                       // input wire clkb
  .rstb(rst),                       // input wire rstb
  .enb(ph_cache_enb),               // input wire enb
  .web(1'b0),                       // input wire [0 : 0] web 1: w; 0: r
  .addrb(ph_cache_raddr),           // input wire [7 : 0] addrb
  .dinb(32'b0),                     // input wire [15 : 0] dinb
  .doutb(ph_cache0_data)            // output wire [15 : 0] doutb
);

wire [15:0] axi_cache1_data;
ph_bram ph_cache1 (
  .clka(clk),                       // input wire clka
  .rsta(rst),                       // input wire rsta
  .ena(ph_cache1_ena),              // input wire ena
  .wea(ph_cache1_wea),              // input wire [0 : 0] wea
  .addra(ph_cache1_addr),           // input wire [7 : 0] addra
  .dina(ph_data_d2_tmp),            // input wire [15 : 0] dina
  .douta(axi_cache1_data),          // output wire [15 : 0] douta
  .clkb(clk),                       // input wire clkb
  .rstb(rst),                       // input wire rstb
  .enb(ph_cache_enb),               // input wire enb
  .web(1'b0),                       // input wire [0 : 0] web
  .addrb(ph_cache_raddr),           // input wire [7 : 0] addrb
  .dinb(32'b0),                     // input wire [15 : 0] dinb
  .doutb(ph_cache1_data)            // output wire [15 : 0] doutb
);

assign ph_cache_data = (ph_cache_sel)?ph_cache1_data:ph_cache0_data;

assign axi_cache_data = (axi_cache_sel)?axi_cache1_data:axi_cache0_data;

endmodule

