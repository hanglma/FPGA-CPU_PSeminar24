module RAM(
    input clk,
    input WE,   // Write-Enable,
    input CS,   // Chip-Select
    
    input [7:0] address,
    input [7:0] WriteDataBus,
    output [7:0] ReadDataBus
    );
    
    reg [7:0] Memory [0:255];
    
    always @(negedge clk) begin
        if(WE & CS) begin
            // Write mode
            Memory[address] <= WriteDataBus;
        end
    end
    
    assign ReadDataBus = Memory[address];
endmodule
