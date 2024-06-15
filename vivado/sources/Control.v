module Control(

    input clk,
    input rst,
    
    input [7:0] Instruction,// Data from Instruction Register
    input flag_z,           // ALU Zero Flag
    input flag_c,           // ALU Carry Flag
    
    output [1:0] MUX_sel,   // MUX selector
    output [1:0] ALU_op,    // ALU operation,
    
    output memory_WE,       // Memory Write Enable
    
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
    wire clear;
    
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
    
    assign AR_load = (StateCount == 0) |
                     (StateCount == 2 & (Instruction==INS_LDA | Instruction==INS_STOA | Instruction==INS_ADDA | Instruction==INS_JMP)) |
                     (StateCount == 3 & (Instruction==INS_STOA)) ? 1 : 0;
    assign PC_load = (StateCount == 3 & Instruction==INS_JMP) ? 1 : 0;
    assign IR_load = (StateCount == 1) ? 1 : 0;
    assign AC_load = (StateCount == 2 & Instruction==INS_COMA) | (StateCount==3 & (Instruction==INS_LDA | Instruction == INS_ADDA)) ? 1 : 0;
    assign ZC_load = (StateCount == 3 & (Instruction==INS_LDA | Instruction==INS_ADDA)) |
                     (StateCount == 2 & Instruction==INS_COMA) ? 1 : 0;
    assign clear   = (StateCount == 2 & Instruction==INS_COMA) |
                     (StateCount == 3 & (Instruction==INS_LDA | Instruction==INS_ADDA | Instruction==INS_JMP)) |
                     (StateCount == 4 & Instruction==INS_STOA) ? 1 : 0;
    assign memory_WE = (StateCount==4 & Instruction==INS_STOA) ? 1 : 0;
    assign MUX_sel = (StateCount==0 | StateCount==2) ? MUX_PC :
                     (StateCount==1 | StateCount==3) ? MUX_MEM :
                     (StateCount==4 & Instruction==INS_STOA) ? MUX_ACC : 0;
    assign ALU_op  = (Instruction==INS_LDA) ? ALU_PAS :
                     (Instruction==INS_ADDA) ? ALU_ADD :
                     (Instruction==INS_COMA) ? ALU_COM : 0;
    
    assign dev_state_count  = StateCount;
    assign dev_clear        = clear;
    
endmodule
