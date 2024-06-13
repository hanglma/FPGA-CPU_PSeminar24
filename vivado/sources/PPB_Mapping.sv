module PPB_Mapping(
    
    input [0:59] device_inputs,
    output [0:119] device_outputs,
    
    input [7:0] DataBus,
    input [7:0] AddressBus,
    input [7:0] ACC_Data,
    input [7:0] IR_Data,
    input [7:0] DR_Data,
    input [7:0] PC_Data,
    input [7:0] ALU_O,
    input Flags_Z,
    input Flags_C,
    
    output clk_auto_en,
    output clk_step,
    output reset,
    output reg [1:0] MUX_select,
    output [7:0] data_bus_injection,
    output AR_load,
    output ACC_load,
    output Memory_CS,
    output Memory_WE,
    
    output dev_flags_load,
    output [1:0] dev_alu_op
    
    );
    
    assign clk_auto_en = device_inputs[0];
    assign clk_step = device_inputs[1];
    assign reset = device_inputs[2];
    assign MUX_select = device_inputs[3:4];
    assign data_bus_injection = device_inputs[5:12];
    assign AR_load = device_inputs[13];
    assign Memory_CS = device_inputs[14];
    assign Memory_WE = device_inputs[15];
    assign ACC_load = device_inputs[16];
    
    assign dev_flags_load = device_inputs[57];
    assign dev_alu_op = device_inputs[58:59];
    
    assign device_outputs[0:7] = DataBus;
    assign device_outputs[8:15] = AddressBus;
    assign device_outputs[16:23] = ACC_Data;
    assign device_outputs[24:31] = IR_Data;
    assign device_outputs[32:39] = DR_Data;
    assign device_outputs[40:47] = PC_Data;
    assign device_outputs[48:55] = ALU_O;
    assign device_outputs[56] = Flags_Z;
    assign device_outputs[57] = Flags_C;
    
endmodule
