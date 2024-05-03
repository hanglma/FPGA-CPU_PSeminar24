module mux8(
  input [0;7] a,
  input [0;7] b,
  input [0;7] c,
  input [0;7] d,
  input [0:1] sel,
  output reg[0;7] o
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