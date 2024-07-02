module PPB_Mapping(
    
    input [0:59] device_inputs,
    output [0:119] device_outputs,
    
    input [7:0] DataBus,
    input [15:0] AddressBus,
    input [7:0] ACC_Data,
    input [7:0] IR_Data,
    input [7:0] DR_Data,
    input [7:0] PC_Data,
    input [7:0] ALU_O,
    input Flags_Z,
    input Flags_C,
    input memory_WE,
    
    input [1:0] dev_mux_sel,
    input [3:0] dev_alu_op,
    input dev_ar_load,
    input dev_pc_load,
    input dev_pc_inc,
    input dev_ac_load,
    input dev_zc_load,
    input dev_ir_load,
    input dev_dr_load,
    input [3:0] dev_ctrl_state_cnt,
    input dev_ctrl_clear,
    input dev_ar_inc,
    input dev_tl_load,
    input dev_th_load,
    input dev_ab_sel,
    input [7:0] fibonacciResult,
    
    output clk_auto_en,
    output clk_step,
    output reset,
    output programming_en,
    output [7:0] ProgrammingAddress,
    output [7:0] ProgrammingData,
    output fibonacciProg
    
    );
    
    assign clk_auto_en = device_inputs[0];
    assign clk_step = device_inputs[1];
    assign reset = device_inputs[2];
    assign ProgrammingAddress = device_inputs[3:10];
    assign ProgrammingData = device_inputs[11:18];
    assign programming_enable = device_inputs[19];
    assign fibonacciProg = device_inputs[20];
    
    assign device_outputs[0:7] = DataBus;
    assign device_outputs[8:23] = AddressBus;
    assign device_outputs[24:31] = ACC_Data;
    assign device_outputs[32:39] = IR_Data;
    assign device_outputs[40:47] = DR_Data;
    assign device_outputs[48:63] = PC_Data;
    assign device_outputs[64:71] = ALU_O;
    assign device_outputs[72] = Flags_Z;
    assign device_outputs[73] = Flags_C;
    assign device_outputs[74] = memory_WE;
    
    assign device_outputs[75:76] = dev_mux_sel;
    assign device_outputs[77:80] = dev_alu_op;
    assign device_outputs[81] = dev_ar_load;
    assign device_outputs[82] = dev_pc_load;
    assign device_outputs[83] = dev_pc_inc;
    assign device_outputs[84] = dev_ac_load;
    assign device_outputs[85] = dev_zc_load;
    assign device_outputs[86] = dev_ir_load;
    assign device_outputs[87] = dev_dr_load;
    assign device_outputs[88:91] = dev_ctrl_state_cnt;
    assign device_outputs[92] = dev_ctrl_clear;
    assign device_outputs[93] = dev_ar_inc;
    assign device_outputs[94] = dev_tl_load;
    assign device_outputs[95] = dev_th_load;
    assign device_outputs[96] = dev_ab_sel;
    assign device_outputs[97:104] = fibonacciResult;
    
endmodule
