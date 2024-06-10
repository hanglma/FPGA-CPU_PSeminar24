`timescale 1ns / 1ps


module AR_test(

    );
    
    logic clk;
    logic rst;
    
    logic testbenchARLoad;
    logic testbenchIOBUF_enable;
    reg [1:0] testbenchMUXSelect;
    reg [7:0] testbenchData;
    
    reg [7:0] addressBus;
    wire [7:0] memoryBus;
    
    cpu cpu0(
        .clk(clk),
        .rst(rst),
        
        .testbenchARLoad,
        .testbenchIOBUF_enable,
        .testbenchMUXSelect,
        .testbenchData,
        
        .AdressBus(addressBus),
        .MemoryBus(memoryBus)
    );
    
    TestMemory tm (
        .addressBus,
        .memoryBus
    );
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk;     // Generate a 100MHz clock
    end
    
    initial begin
        rst = 1;
        addressBus = 'b0;
    
        testbenchData = 8'b10101010;
        testbenchMUXSelect = 2'b00;
        testbenchARLoad = 0;
        testbenchIOBUF_enable = 0;
        
        #50;
        
        testbenchARLoad = 1;
        #1;
        testbenchARLoad = 0;
        
        #10;
        
        testbenchIOBUF_enable = 1;
        testbenchMUXSelect = 2'b11;
        
        #1000;
        
        $stop;
       
    end
endmodule
