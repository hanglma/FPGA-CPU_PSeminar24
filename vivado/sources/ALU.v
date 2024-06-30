module ALU(
    
    input [3:0] op,
    
    input [7:0] A,
    input [7:0] B,
    
    output reg [7:0] O,
    output reg c,
    output z
    
    );
    
    reg [8:0] internal;
    
    always @(*) begin
        case(op)
            4'b0000: internal <= 0;         // Zero
            4'b0001: internal <= B;         // Passthrough
            
            4'b0010: internal <= A + B;     // Add
            4'b0011: internal <= A - B;     // Subtract
            
            4'b0100: internal <= A & B;     // AND operation
            4'b0101: internal <= A | B;     // OR operation
            4'b0110: internal <= A ^ B;     // XOR operation
            4'b0111: internal <= !A;        // NOT operation
            
            4'b1000: internal <= (A >  B) ? 'b1:'b0;    // GT comparison
            4'b1001: internal <= (A >= B) ? 'b1:'b0;    // GTE comparison
            4'b1010: internal <= (A <  B) ? 'b1:'b0;    // LT comparison
            4'b1011: internal <= (A <= B) ? 'b1:'b0;    // LTE comparison
            4'b1100: internal <= (A == B) ? 'b1:'b0;    // EQ comparison
            
            default: internal <= 0;
        endcase
        
        {c,O} <= internal;
    end
    
    assign z = (O==0) ? 1:0;
    
endmodule
