module Programming(
    input clk,
    input rst_in,
    output core_clk,
    output core_rst,
    output mem_clk,
    
    input programming_enable,
    input [7:0] ProgrammingAddress,
    input [7:0] ProgrammingData,
    
    input memory_WE,
    input [7:0] AddressBus,
    input [7:0] WriteBus,
    output [7:0] ReadBus,
    
    input [7:0] MemReadBus,
    output [7:0] MemWriteBus,
    output [7:0] MemAddressBus,
    output MemWE
    );
    
    
    assign mem_clk  = clk;
    assign core_rst = programming_enable ? 0 : rst_in;
    assign core_clk = programming_enable ? 0 : clk;
    
    assign MemWE            = programming_enable ? 1 : memory_WE;
    assign MemAddressBus    = programming_enable ? ProgrammingAddress : AddressBus;
    assign MemWriteBus      = programming_enable ? ProgrammingData : WriteBus;
    
    assign ReadBus = programming_enable ? 8'b0 : MemReadBus;
endmodule