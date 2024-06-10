`timescale 1ns / 1ps


module TestMemory(
    input [7:0] addressBus,
    inout [7:0] memoryBus
    );
    
    assign memoryBus = addressBus;
endmodule
