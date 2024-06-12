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

## Target Output

Bit Index | Signal
-|-
0:7 | DataBus
8:15 | AddressBus