module top(
    
    input board_clk,
        
    input pmod_rst,
    input pmod_bus_clk,
    input pmod_bus_control,
    input [2:0] pmod_bus_poti,
    output reg [2:0] pmod_bus_pito,
    
    output [3:0] leds
    
    );
    
    PPB_PHY #(.INPUT_BLOCKS(20), .OUTPUT_BLOCKS(40)) probe_phy(
        .clk,
        .rst(pmod_rst),
        .PROJECT_ID(23'h31c748),
        
        .pmod_bus_clk,
        .pmod_bus_control,
        .pmod_bus_poti,
        .pmod_bus_pito
    );
    
    logic clk;
    assign leds[0] = clk;
    
    PPB_Mapping io(
        .device_inputs(probe_phy.device_inputs),
        .device_outputs(probe_phy.device_outputs)
    );
    
    ClockManager clock(
        .clk_100MHZ(board_clk),
        .clk_auto_en(io.clk_auto_en),
        .clk_step(io.clk_step),
        .clk
    );
    
    RAM ram(
        .clk
    );
    
    cpu core0(
        .clk,
        .rst(io.reset),
        
        .DataBus(io.DataBus),
        .AddressBus(ram.address),
        .MemoryWriteBus(ram.WriteDataBus),
        .MemoryReadBus(ram.ReadDataBus),
        
        .memory_WE(ram.WE),
        
        .ACC_Data(io.ACC_Data),
        .IR_Data(io.IR_Data),
        .DR_Data(io.DR_Data),
        .PC_Data(io.PC_Data),
        .ALU_O(io.ALU_O),
        .Flags_Z(io.Flags_Z),
        .Flags_C(io.Flags_C),
        
        /// IO for development ///
        
        .dev_mux_sel(io.dev_mux_sel),
        .dev_alu_op(io.dev_alu_op),
        .dev_ar_load(io.dev_ar_load),
        .dev_pc_load(io.dev_pc_load),
        .dev_pc_inc(io.dev_pc_inc),
        .dev_ac_load(io.dev_ac_load),
        .dev_zc_load(io.dev_zc_load),
        .dev_ir_load(io.dev_ir_load),
        .dev_dr_load(io.dev_dr_load),
        .dev_ctrl_state_cnt(io.dev_ctrl_state_cnt),
        .dev_ctrl_clear(io.dev_ctrl_clear)
    );
    
    assign io.AddressBus = core0.AddressBus;
    assign io.memory_WE = core0.memory_WE;
    
endmodule
