module Control(

    input clk,
    input rst,
    
    input [7:0] Instruction,// Data from Instruction Register
    input flag_z,           // ALU Zero Flag
    input flag_c,           // ALU Carry Flag
    
    output [1:0] MUX_sel,   // MUX selector
    output [1:0] ALU_op,    // ALU operation
    
    output AR_load,         // Address Register Load
    output PC_load,         // Program Counter Load
    output PC_inc,          // Program Counter Increment
    output AC_load,         // Accumulator Load
    output ZC_load,         // Flag Register Load
    output IR_load,         // Instruction Register Load
    output DR_load,         // Data Register Load
    
    /// IO for development & debugging ///
    output [2:0] dev_state_count,
    output dev_clear
    );
    
    // Instructions //
    localparam INS_LDA  = 8'h00;
    localparam INS_ADDA = 8'h01;
    localparam INS_STOA = 8'h02;
    localparam INS_JMP  = 8'h03;
    localparam INS_COMA = 8'h04;
    
    // MUX Settings //
    localparam MUX_ACC = 2'b00;
    localparam MUX_DR  = 2'b01;
    localparam MUX_PC  = 2'b10;
    localparam MUX_MEM = 2'b11;
    
    // ALU Operations //
    localparam ALU_ADD = 2'b00;
    localparam ALU_PAS = 2'b01;
    localparam ALU_AND = 2'b10;
    localparam ALU_COM = 2'b11;
    
    
    reg [2:0] StateCount;
    reg clear;
    
    always @(negedge clk or negedge rst) begin
        if(!rst) begin
            StateCount <= 0;
        end else if(!clk) begin
            if(clear) begin
                StateCount <= 0;
            end else begin
                StateCount <= StateCount + 1;
            end
        end
    end
    
    assign dev_state_count  = StateCount;
    assign dev_clear        = clear;
    
endmodule
