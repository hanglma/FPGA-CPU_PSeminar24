`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 12:56:08
// Design Name: 
// Module Name: obuft8
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


module obuft8(
    input T,
    input [7:0] I,
    output reg[7:0] O
    );
    
always @ (I or T)
begin
if (!T)
  O <= I;
else
  O <= 8'bZ;
end

endmodule
