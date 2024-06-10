`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 12:18:32
// Design Name: 
// Module Name: register_base
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


module register_base(
  input [7:0] Input,  // 8-bit input
  output reg [7:0] Output,  // 8-bit register output
  input clk,      // Clock signal
  input load,     // Load signal (active high)
  input rst      // Reset signal (active low)
  );

always @(posedge clk, negedge rst)
if (!rst) begin 
  Output <= 8'b0;
end else if (load) begin 
  Output <= Input;
end

endmodule
