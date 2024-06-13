# Probe Bit Mapping

## Target Input

Bit Index | Signal Name
-|-
0 | clk_auto_en
1 | clk_step
2 | reset
3:4 | MUX_select
5:12 | data_bus_injection
13 | AR_load
14 | Memory_CS
15 | Memory_WE
16 | ACC_load
57 | dev_flags_load
58:59 | dev_alu_op

## Target Output

Bit Index | Signal
-|-
0:7 | DataBus
8:15 | AddressBus
16:23 | ACC_data
24:31 | IR_Data
32:39 | DR_Data
40:47 | PC_Data
48:55 | ALU_O
56 | Flags_Z
57 | Flags_C