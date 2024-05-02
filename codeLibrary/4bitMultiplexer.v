module mux4(
  input a,
  input b,
  input c,
  input d,
  input [0:1] sel,
  output reg o
  );
always @ (*) begin
  case (sel)
    0: o <= a;
	  1: o <= b;
	  2: o <= c;
	  3: o <= d;
  endcase
end

endmodule