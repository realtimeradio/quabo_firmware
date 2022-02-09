`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 07:19:29 PM
// Design Name: 
// Module Name: GRAY_DECODE
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


module GRAY_DECODE(
    input wire clk,
    input wire nrst,
    input wire [9:0] gray,
    output reg [9:0] binary
    );

wire [9:0] binary_tmp;
assign binary_tmp[9:9] = gray[9:9];
assign binary_tmp[8:8] = binary_tmp[9:9] ^ gray[8:8];
assign binary_tmp[7:7] = binary_tmp[8:8] ^ gray[7:7];
assign binary_tmp[6:6] = binary_tmp[7:7] ^ gray[6:6];
assign binary_tmp[5:5] = binary_tmp[6:6] ^ gray[5:5];
assign binary_tmp[4:4] = binary_tmp[5:5] ^ gray[4:4];
assign binary_tmp[3:3] = binary_tmp[4:4] ^ gray[3:3];
assign binary_tmp[2:2] = binary_tmp[3:3] ^ gray[2:2];
assign binary_tmp[1:1] = binary_tmp[2:2] ^ gray[1:1];
assign binary_tmp[0:0] = binary_tmp[1:1] ^ gray[0:0];
always @(posedge clk)
begin
    if(nrst == 0)
        binary <= 0;
    else
        binary <= binary_tmp;
end
endmodule
