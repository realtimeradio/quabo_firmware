`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 07:19:29 PM
// Design Name: 
// Module Name: GRAY_CODE
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


module GRAY_CODE(
    input wire clk,
    input wire nrst,
    input wire [9:0] binary,
    output reg [9:0] gray
    );

always @(posedge clk)
begin
    if(nrst == 0)
        gray <= 0;
    else
        gray <= (binary>>1) ^ binary;
end
endmodule
