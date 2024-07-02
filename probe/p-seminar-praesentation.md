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
20 | fibonacciProg


## Target Output

Bit Index | Signal
-|-
0:7 | DataBus
8:23 | AddressBus
24:31 | ACC_Data
32:39 | IR_Data
40:47 | DR_Data
48:63 | PC_Data
64:71 | ALU_O
72 | Flags_Z
73 | Flags_C
74 | memory_WE
75:76 | dev_mux_sel
77:80 | dev_alu_op
81 | dev_ar_load
82 | dev_pc_load
83 | dev_pc_inc
84 | dev_ac_load
85 | dev_zc_load
86 | dev_ir_load
87 | dev_dr_load
88:91 | dev_ctrl_state_cnt
92 | dev_ctrl_clear
93 | dev_ar_inc
94 | dev_tl_load
95 | dev_th_load
96 | dev_ab_sel
97:104 | fibonacciResult