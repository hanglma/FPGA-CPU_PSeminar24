module PPB_Mapping(
    
    input [0:59] device_inputs,
    output [0:119] device_outputs,
    
    input [7:0] DataBus,
    input [7:0] AddressBus,
    
    output clk_auto_en,
    output clk_step,
    output reset,
    output reg [1:0] MUX_select,
    output [7:0] data_bus_injection,
    output AR_load
    
    );
    
    always @(device_inputs) begin
        MUX_select <= device_inputs[3:4];
    end
    
    assign clk_auto_en = device_inputs[0];
    assign clk_step = device_inputs[1];
    assign reset = device_inputs[2];
    assign data_bus_injection = device_inputs[5:12];
    assign AR_load = device_inputs[13];
    
    assign device_outputs[0:7] = DataBus;
    assign device_outputs[8:15] = AddressBus;
    
endmodule
