# Probe Bit Mapping

## Target Input

Bit Index | Signal Name
-|-
0 | clk_auto_en
1 | clk_step
2 | reset
3:10 | ProgrammingAddress
11:18 | ProgrammingData
19 | programming_enable


## Target Output

Bit Index | Signal
-|-
0:7 | DataBus
8:15 | AddressBus
16:23 | ACC_Data
24:31 | IR_Data
32:39 | DR_Data
40:47 | PC_Data
48:55 | ALU_O
56 | Flags_Z
57 | Flags_C
58 | memory_WE
59:60 | dev_mux_sel
61:64 | dev_alu_op
65 | dev_ar_load
66 | dev_pc_load
67 | dev_pc_inc
68 | dev_ac_load
69 | dev_zc_load
70 | dev_ir_load
71 | dev_dr_load
72:75 | dev_ctrl_state_cnt
76 | dev_ctrl_clear
77 | dev_ar_inc
78 | dev_tl_load
79 | dev_th_load
80 | dev_ab_sel