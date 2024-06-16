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
    input memory_WE,
    
    input [1:0] dev_mux_sel,
    input [1:0] dev_alu_op,
    input dev_ar_load,
    input dev_pc_load,
    input dev_pc_inc,
    input dev_ac_load,
    input dev_zc_load,
    input dev_ir_load,
    input dev_dr_load,
    input [2:0] dev_ctrl_state_cnt,
    input dev_ctrl_clear,
    
    output clk_auto_en,
    output clk_step,
    output reset,
    output programming_en,
    output [7:0] ProgrammingAddress,
    output [7:0] ProgrammingData
    
    );
    
    assign clk_auto_en = device_inputs[0];
    assign clk_step = device_inputs[1];
    assign reset = device_inputs[2];
    assign ProgrammingAddress = device_inputs[3:10];
    assign ProgrammingData = device_inputs[11:18];
    assign programming_enable = device_inputs[19];
    
    assign device_outputs[0:7] = DataBus;
    assign device_outputs[8:15] = AddressBus;
    assign device_outputs[16:23] = ACC_Data;
    assign device_outputs[24:31] = IR_Data;
    assign device_outputs[32:39] = DR_Data;
    assign device_outputs[40:47] = PC_Data;
    assign device_outputs[48:55] = ALU_O;
    assign device_outputs[56] = Flags_Z;
    assign device_outputs[57] = Flags_C;
    assign device_outputs[58] = memory_WE;
    
    assign device_outputs[59:60] = dev_mux_sel;
    assign device_outputs[61:62] = dev_alu_op;
    assign device_outputs[63] = dev_ar_load;
    assign device_outputs[64] = dev_pc_load;
    assign device_outputs[65] = dev_pc_inc;
    assign device_outputs[66] = dev_ac_load;
    assign device_outputs[67] = dev_zc_load;
    assign device_outputs[68] = dev_ir_load;
    assign device_outputs[69] = dev_dr_load;
    assign device_outputs[70:72] = dev_ctrl_state_cnt;
    assign device_outputs[73] = dev_ctrl_clear;
    
endmodule
