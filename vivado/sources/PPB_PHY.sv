module PPB_PHY (
    input clk,
    input rst,

    // Connections to the PMod Connector //
    input pmod_bus_clk,
    input pmod_bus_control,
    input [2:0] pmod_bus_poti,
    output reg [2:0] pmod_bus_pito,
    
    input [23:0] PROJECT_ID,
    
    // Actual module inputs and outputs & cycle signals //
    input [OUTPUT_BLOCKS*3-1 : 0] device_outputs,
    output reg [INPUT_BLOCKS*3-1 : 0] device_inputs,
    //output reg [INPUT_BLOCKS-1:0] input_cycle_signals,
    //output reg [OUTPUT_BLOCKS-1:0] output_cycle_signals,
    
    output [3:0] interface_state
    );
    
    // Parameters //
    
    parameter [8:0] INPUT_BLOCKS = 9'd4;
    parameter [8:0] OUTPUT_BLOCKS = 9'd4;
    
    // A couple of constants //
    localparam int NUM_WAITING_CYCLES = 50;
    localparam int TIMEOUT_VALUE = 100_000_000;   // Max number of cycles of the FPGA Clock between bus clock cycles before timeout
    
    // Keep track of module state //
    enum [3:0] {
        S_WAITING_FOR_CLK=0,      // No clock signal on Probe Bus
        S_WAITING_CYCLES=1,       // Waiting for physical connection to stabilize
        S_COMM_INIT=2,            // Transmitting communication options from target to probe
        S_COMM_INIT_PRJ=3,          // Comm Init: Project ID (24 bits -> 8 transmissions)
        S_COMM_INIT_IBLX=4,         // Comm Init: Input Block count (9 bits -> 3 transmissions)
        S_COMM_INIT_OBLX=5,         // Comm Init: Output Block count (9 bits -> 3 transmissions)
        S_AWAITING_INIT_ACK=6,    // Waiting for probe to acknowledge comm options
        S_INIT_SUCCESS=7,         // Communication Initialization has succeeded -> proceed to ACTIVE
        S_INIT_FAILED=8,          // Communication Initializtaion has failed -> proceed to WAITING_FOR_CLK
        S_ACTIVE=9,               // Communication with probe is active
        S_TIMEOUT=10              // Probe Bus Clock has gone inactive -> proceed to WAITING_FOR_CLK
    } COMM_STATE;
    
    reg [3:0] state;
    
    
    reg [15:0] waited_cycles;
    reg [31:0] ack_timeout_counter;
    
    reg [3:0] comm_init_prj_tx_count;
    reg [3:0] comm_init_iblx_tx_count;
    reg [3:0] comm_init_oblx_tx_count;    
    
    reg [8:0] transmitted_block_count;
    
    
    always @(posedge pmod_bus_clk) begin
        case (state)
            S_WAITING_FOR_CLK: begin
                    // PMod Probe Clock has been detected //
                    waited_cycles <= '0;
                    state <= S_WAITING_CYCLES;
                end
            S_WAITING_CYCLES: begin
                    // Waiting for physical connection to settle
                    // After NUM_WAITING_CYCLES, proceed to COMM_INIT
                    waited_cycles <= waited_cycles + 1;
                    if(waited_cycles > NUM_WAITING_CYCLES) begin
                        state <= S_COMM_INIT;
                    end
                end
            S_COMM_INIT: begin
                    pmod_bus_pito <= 3'b111;
                    comm_init_prj_tx_count <= 0;
                    comm_init_iblx_tx_count <= 0;
                    comm_init_oblx_tx_count <= 0;
                    state <= S_COMM_INIT_PRJ;
                end
            S_COMM_INIT_PRJ: begin
                    pmod_bus_pito <= PROJECT_ID[23-comm_init_prj_tx_count*3 -: 3];
                    comm_init_prj_tx_count <= comm_init_prj_tx_count + 1;
                    
                    if(comm_init_prj_tx_count > 6) state <= S_COMM_INIT_IBLX;
                end
            S_COMM_INIT_IBLX: begin
                    pmod_bus_pito <= INPUT_BLOCKS[8-comm_init_iblx_tx_count*3 -: 3];
                    comm_init_iblx_tx_count <= comm_init_iblx_tx_count + 1;
                    
                    if(comm_init_iblx_tx_count > 1) state <= S_COMM_INIT_OBLX;
                end
            S_COMM_INIT_OBLX: begin
                    pmod_bus_pito <= OUTPUT_BLOCKS[8-comm_init_oblx_tx_count*3 -: 3];
                    comm_init_oblx_tx_count <= comm_init_oblx_tx_count + 1;
                    
                    if(comm_init_oblx_tx_count > 1) begin
                        state <= S_AWAITING_INIT_ACK;
                        ack_timeout_counter <= 0;
                    end
                end
            S_AWAITING_INIT_ACK: begin
                    ack_timeout_counter <= ack_timeout_counter + 1;
                    
                    if(pmod_bus_control) begin
                        state <= S_ACTIVE;
                    end
                    
                    if(ack_timeout_counter > 100) begin
                        state <= S_INIT_FAILED;
                    end
                end
            S_INIT_FAILED: begin
                    state <= S_WAITING_FOR_CLK;
                end
                
            S_ACTIVE: begin
                    // if it works, dont touch it
                    if(transmitted_block_count < INPUT_BLOCKS)  device_inputs[(INPUT_BLOCKS*3-1)-(transmitted_block_count*3) -: 3] <= {<<{pmod_bus_poti}};
                    if(transmitted_block_count < OUTPUT_BLOCKS) pmod_bus_pito <= {<<{device_outputs[(OUTPUT_BLOCKS*3-1)-(transmitted_block_count*3) -: 3]}};
            
                    transmitted_block_count <= transmitted_block_count + 1;
                    if(OUTPUT_BLOCKS > INPUT_BLOCKS) begin
                        if(transmitted_block_count == OUTPUT_BLOCKS-1) transmitted_block_count <= 0;
                    end else begin
                        if(transmitted_block_count == INPUT_BLOCKS-1) transmitted_block_count <= 0;
                    end
                    if(pmod_bus_control) transmitted_block_count <= 1;          // Synchronization
                end
        endcase // case (state)
        
        if(rst) begin
            state <= S_WAITING_FOR_CLK;
        end
    end // posedge pmod_bus_clk
    
    
    assign interface_state = state;
    
endmodule
