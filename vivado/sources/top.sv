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
        .clk,
        .WE(io.Memory_WE),
        .CS(io.Memory_CS)
    );
    
    cpu core0(
        .clk,
        .rst(io.reset),
        
        .DataBus(io.DataBus),
        .AddressBus(ram.address),
        .MemoryWriteBus(ram.WriteDataBus),
        .MemoryReadBus(ram.ReadDataBus),
        
        .ACC_Data(io.ACC_Data),
        .IR_Data(io.IR_Data),
        .DR_Data(io.DR_Data),
        .PC_Data(io.PC_Data),
        
        .MUX_select(io.MUX_select),
        .data_bus_injection(io.data_bus_injection),
        .AR_load(io.AR_load)
    );
    
    assign io.AddressBus = core0.AddressBus;
    
endmodule
