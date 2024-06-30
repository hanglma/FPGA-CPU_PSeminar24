module Control(

    input clk,
    input rst,
    
    input [7:0] Instruction,// Data from Instruction Register
    input flag_z,           // ALU Zero Flag
    input flag_c,           // ALU Carry Flag
    
    output [1:0] MUX_sel,   // MUX selector
    output [3:0] ALU_op,    // ALU operation,
    
    output memory_WE,       // Memory Write Enable
    
    output AR_load,         // Address Register Load
    output AR_inc,          // Address Register Increment
    output PC_load,         // Program Counter Load
    output PC_inc,          // Program Counter Increment
    output AC_load,         // Accumulator Load
    output ZC_load,         // Flag Register Load
    output IR_load,         // Instruction Register Load
    output DR_load,         // Data Register Load
    output TL_load,         // AddressControl TempLow Load
    output TH_load,         // AddressControl TempHigh Load
    output AB_sel,
    
    /// IO for development & debugging ///
    output [3:0] dev_state_count,
    output clear
    );
    
    // Instructions //
    localparam INS_NOP  = 8'h00;
    localparam INS_LDI  = 8'h01;
    localparam INS_LDA  = 8'h02;
    localparam INS_STA  = 8'h03;
    localparam INS_MVA  = 8'h04;
    localparam INS_JMP  = 8'h05;
    localparam INS_JMPZ = 8'h06;
    localparam INS_JPNZ = 8'h07;
    localparam INS_ADD  = 8'h08;
    localparam INS_ADDI = 8'h09;
    localparam INS_SUB  = 8'h0A;
    localparam INS_SUBI = 8'h0B;
    localparam INS_CLA  = 8'h0C;
    localparam INS_AND  = 8'h0D;
    localparam INS_OR   = 8'h0E;
    localparam INS_XOR  = 8'h0F;
    localparam INS_NOT  = 8'h10;
    localparam INS_GT   = 8'h11;
    localparam INS_GTE  = 8'h12;
    localparam INS_LT   = 8'h13;
    localparam INS_LTE  = 8'h14;
    localparam INS_EQ   = 8'h15;
    
    // MUX Settings //
    localparam MUX_ACC = 2'b00;
    localparam MUX_DR  = 2'b01;
    localparam MUX_PC  = 2'b10;
    localparam MUX_MEM = 2'b11;
    localparam MUX_default = MUX_ACC;
    
    // ALU Operations //
    localparam ALU_ZERO = 4'b0000;
    localparam ALU_PASS = 4'b0001;
    localparam ALU_ADD =  4'b0010;
    localparam ALU_SUB =  4'b0011;
    localparam ALU_AND =  4'b0100;
    localparam ALU_OR =   4'b0101;
    localparam ALU_XOR =  4'b0110;
    localparam ALU_NOT =  4'b0111;
    localparam ALU_GT =   4'b1000;
    localparam ALU_GTE =  4'b1001;
    localparam ALU_LT =   4'b1010;
    localparam ALU_LTE =  4'b1011;
    localparam ALU_EQ =   4'b1100;
    localparam ALU_default = ALU_PASS;
    
    
    reg [3:0] StateCount;
    
    always @(negedge clk) begin
        StateCount <= StateCount + 1;
        if(!rst) begin
            StateCount <= 0;
        end else begin
            if(clear) begin
                StateCount <= 0;
            end
        end
    end
    
    // whatever you are doing right now, dont scroll further
    // it only gets worse from here
    
    assign MUX_sel = ((Instruction==INS_STA & StateCount==5) | (Instruction==INS_MVA & StateCount==2)) ? MUX_ACC : (
                     (StateCount == 2 & (Instruction==INS_ADD|Instruction==INS_SUB|Instruction==INS_AND|Instruction==INS_OR|Instruction==INS_XOR|Instruction==INS_NOT|Instruction==INS_GT|Instruction==INS_GTE|Instruction==INS_LT|Instruction==INS_LTE|Instruction==INS_EQ)) ? MUX_DR : (
                     (StateCount == 1 | Instruction==INS_SUBI | Instruction==INS_ADDI | Instruction==INS_LDI | (Instruction==INS_LDA & StateCount == 5) | ((Instruction==INS_LDA|Instruction==INS_STA|Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ) & (StateCount==2|StateCount==3))) ? MUX_MEM : MUX_default ));
    
    assign ALU_op =  Instruction==INS_CLA ? ALU_ZERO : (
                        Instruction==INS_AND ? ALU_AND : (
                        Instruction==INS_OR ? ALU_OR: (
                        Instruction==INS_XOR ? ALU_XOR : (
                        Instruction==INS_NOT ? ALU_NOT : (
                        Instruction==INS_GT ? ALU_GT : (
                        Instruction==INS_GTE ? ALU_GTE : (
                        Instruction==INS_LT ? ALU_LT : (
                        Instruction==INS_LTE ? ALU_LTE : (
                        Instruction==INS_EQ ? ALU_EQ : (
                        (Instruction==INS_ADD | Instruction==INS_ADDI) ? ALU_ADD : (
                        (Instruction==INS_SUB | Instruction==INS_SUBI) ? ALU_SUB : ALU_default
                        ))))))))))
                    );
                    
    assign memory_WE = (Instruction == INS_STA & StateCount == 5) ? 1 : 0;
    
    assign clear = ((StateCount==2 & (Instruction==INS_NOP|Instruction==INS_LDI|Instruction==INS_MVA|Instruction==INS_ADD|Instruction==INS_ADDI|Instruction==INS_SUB|Instruction==INS_SUBI|Instruction==INS_CLA|Instruction==INS_AND|Instruction==INS_OR|Instruction==INS_XOR|Instruction==INS_NOT|Instruction==INS_GT|Instruction==INS_GTE|Instruction==INS_LT|Instruction==INS_LTE|Instruction==INS_EQ)) |
                    (StateCount==4 & (Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ)) |
                    (StateCount==5 & (Instruction==INS_STA|Instruction==INS_LDA))
                    ) ? 1:0;
                    
                    
    assign PC_load = ((Instruction==INS_JMP & StateCount==4) |
                      (Instruction==INS_JMPZ & StateCount==4 & flag_z==1'b1) |
                      (Instruction==INS_JPNZ & StateCount==4 & flag_z==1'b0)
                     ) ? 1 : 0;
                     
    assign PC_inc = ((StateCount==2&(Instruction==INS_ADDI|Instruction==INS_SUBI|Instruction==INS_LDI)) |
                     ((Instruction==INS_LDA|Instruction==INS_STA|Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ) & (StateCount==2|StateCount==3)) |
                     (StateCount==1)
                    ) ? 1:0;
                    
    assign AR_load = ((StateCount==0) |
                      (StateCount==4 & (Instruction==INS_LDA|Instruction==INS_STA))
                     ) ? 1:0;
                    
    assign AR_inc = ((StateCount==2&(Instruction==INS_ADDI|Instruction==INS_SUBI|Instruction==INS_LDI)) |
                     ((Instruction==INS_LDA|Instruction==INS_STA|Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ) & (StateCount==2|StateCount==3)) |
                      (StateCount==1)
                    ) ? 1:0;
                    
    assign TH_load = (StateCount==2 & (Instruction==INS_LDA|Instruction==INS_STA|Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ)) ? 1:0;
    assign TL_load = (StateCount==3 & (Instruction==INS_LDA|Instruction==INS_STA|Instruction==INS_JMP|Instruction==INS_JMPZ|Instruction==INS_JPNZ)) ? 1:0;
    
    assign AB_sel  = (StateCount == 0) ? 1:0;
    
    
    assign AC_load = ((StateCount==2 & (Instruction==INS_LDI|Instruction==INS_ADD|Instruction==INS_ADDI|Instruction==INS_SUB|Instruction==INS_SUBI|Instruction==INS_CLA|Instruction==INS_AND|Instruction==INS_OR|Instruction==INS_XOR|Instruction==INS_NOT|Instruction==INS_GT|Instruction==INS_GTE|Instruction==INS_LT|Instruction==INS_LTE|Instruction==INS_EQ)) |
                      (Instruction==INS_LDA & StateCount==5)
                     ) ? 1:0;
                     
    assign IR_load = (StateCount==1) ? 1:0;
    
    assign DR_load = (StateCount==2 & Instruction==INS_MVA) ? 1:0;
    
    assign ZC_load = (StateCount==2 & (Instruction==INS_ADD|Instruction==INS_ADDI|Instruction==INS_SUB|Instruction==INS_SUBI|Instruction==INS_CLA|Instruction==INS_AND|Instruction==INS_OR|Instruction==INS_XOR|Instruction==INS_NOT|Instruction==INS_GT|Instruction==INS_GTE|Instruction==INS_LT|Instruction==INS_LTE|Instruction==INS_EQ)) ? 1:0;
    
    assign dev_state_count  = StateCount;
    //assign dev_clear        = clear;
    
endmodule
