module ALU(
    
    input [1:0] op,
    
    input [7:0] A,
    input [7:0] B,
    
    output reg [7:0] O,
    output reg c,
    output z
    
    );
    
    reg [8:0] internal;
    
    always @(*) begin
        case(op)
            2'b00: internal <= A + B; // Add
            2'b01: internal <= A - B; // Subtract
            2'b10: internal <= A & B; // And operation
            2'b11: internal <= A | B; // Or operation
            default: internal <= 'b0;
        endcase
        
        {c,O} <= internal;
    end
    
    assign z = (O==0) ? 1:0;
    
endmodule
