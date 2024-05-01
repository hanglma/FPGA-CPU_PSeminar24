module Register_base(
  input [7:0] input,  // 8-bit input
  output reg [7:0] output  // 8-bit register output
  input clk,      // Clock signal
  input load,     // Load signal (active high)
  input rst,      // Reset signal (active low)
);

always @(posedge clk, negedge rst)
  if !rst begin 
    output <= 8'b0;
  end else if (load) begin 
    output <= input;
  end
endmodule