module mux4(
  input a,
  input b,
  input c,
  input d,
  input [0;1] sel,
  output reg o
  );
always @ (*) begin
  case (sel)
    0: o <= A;
	1: o <= B;
	2: o <= C;
	3: o <= D;
  endcase
end

endmodule