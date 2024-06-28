module RAM(
    input clk,
    input WE,   // Write-Enable,
    
    input [15:0] Address,
    input [7:0] WriteDataBus,
    output [7:0] ReadDataBus
    );
    
    reg [7:0] Memory [0:4095];
    
    always @(negedge clk) begin
        if(WE) begin
            // Write mode
            Memory[Address] <= WriteDataBus;
        end
    end
    
    assign ReadDataBus = Memory[Address];
endmodule
