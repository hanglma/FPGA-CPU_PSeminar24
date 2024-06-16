module register_Flags(
    
    input z_in,
    input c_in,
    
    input clk,
    input load,
    input rst,
    
    output reg z_out,
    output reg c_out
    
    );
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            z_out <= 1'b0;
            c_out <= 1'b0;
        end else if(load) begin
            z_out <= z_in;
            c_out <= c_in;
        end
    end
endmodule
