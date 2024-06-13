module register_Flags(
    
    input z_in,
    input c_in,
    
    input clk,
    input load,
    
    output reg z_out,
    output reg c_out
    
    );
    
    always @(posedge clk) begin
        if(load) begin
            z_out <= z_in;
            c_out <= c_in;
        end
    end
endmodule
