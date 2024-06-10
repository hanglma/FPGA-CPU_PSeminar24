`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 17:45:41
// Design Name: 
// Module Name: MUX
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


module MUX(
  input [1:0] sel,
  input [7:0] A,
  input [7:0] B,
  input [7:0] C,
  input [7:0] D,
  output reg[0:7] O
  );
always @ (*) begin
  case (sel)
    0: O <= A;
	1: O <= B;
	2: O <= C;
	3: O <= D;
  endcase
end

endmodule
