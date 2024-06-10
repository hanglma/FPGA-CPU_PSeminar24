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