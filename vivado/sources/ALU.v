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
            4'b0000: internal <= 0;       // Zero
            4'b0001: internal <= B;         // Passthrough
            
            4'b0010: internal <= A + B;     // Add
            4'b0011: internal <= A - B;     // Subtract
            
            4'b0100: internal <= A & B;     // AND operation
            4'b0101: internal <= A | B;     // OR operation
            4'b0110: internal <= A ^ B;     // XOR operation
            4'b0111: internal <= !A;        // NOT operation
            
            default: internal <= 0;
        endcase
        
        {c,O} <= internal;
    end
    
    assign z = (O==0) ? 1:0;
    
endmodule
