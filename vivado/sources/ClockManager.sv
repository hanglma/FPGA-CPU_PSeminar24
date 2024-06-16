module ClockManager(
    input clk_100MHZ,
    input clk_auto_en,
    input clk_step,
    output clk
    );
    
    reg [24:0] counter;
    
    logic slow_auto_clk;
    
    always @(posedge clk_100MHZ) begin
        counter <= counter + 1;
    end
    
    assign slow_auto_clk = counter[24] == 1;
    assign clk = clk_auto_en ? slow_auto_clk : clk_step;
endmodule
