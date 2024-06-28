module AddressControl(

    input clk,
    input rst,
    
    input PC_load,
    input PC_inc,
    input AR_load,
    input AR_inc,
    input TL_load,
    input TH_load,
    input sel,

    input [7:0] DataBus,
    
    output reg [15:0] ProgramCounter,
    output reg [15:0] AddressRegister

    );
    
    reg [7:0] Temp_L;
    reg [7:0] Temp_H;
    wire [15:0] Bus16;
    
    localparam reset_vector = 16'h0000;
    
    always @(posedge clk) begin
        if(!rst) begin
            ProgramCounter <= reset_vector;
            AddressRegister <= reset_vector;
        end else begin
            if(TL_load) begin
                Temp_L <= DataBus;
            end
            if (TH_load) begin
                Temp_H <= DataBus;
            end
            
            if(PC_inc) begin
                ProgramCounter <= ProgramCounter + 1;
            end else if (PC_load) begin
                ProgramCounter <= Bus16;
            end
            
            if(AR_inc) begin
                AddressRegister <= AddressRegister + 1;
            end else if (AR_load) begin
                AddressRegister <= Bus16;
            end
        end
    end
    
    assign Bus16[7:0] = (sel==1) ? ProgramCounter[7:0] : Temp_L;
    assign Bus16[15:8] = (sel==1) ? ProgramCounter[15:8] : Temp_H;
    
endmodule
