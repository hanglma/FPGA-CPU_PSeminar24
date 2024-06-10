module MUX(
  input A,
  input B,
  input C,
  input D,
  input [0:1] sel,
  output reg O
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