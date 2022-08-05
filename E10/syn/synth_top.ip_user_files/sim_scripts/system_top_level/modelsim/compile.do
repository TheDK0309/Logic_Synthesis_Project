vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/util_vector_logic_v2_0_1

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap util_vector_logic_v2_0_1 modelsim_lib/msim/util_vector_logic_v2_0_1

vcom -work xil_defaultlib  -93 \
"../../../bd/system_top_level/ip/system_top_level_i2c_config_0_0/sim/system_top_level_i2c_config_0_0.vhd" \
"../../../bd/system_top_level/ip/system_top_level_synthesizer_0_0/sim/system_top_level_synthesizer_0_0.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../synth_top.gen/sources_1/bd/system_top_level/ipshared/d0f7" \
"../../../bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0.v" \

vlog -work util_vector_logic_v2_0_1  -incr "+incdir+../../../../synth_top.gen/sources_1/bd/system_top_level/ipshared/d0f7" \
"../../../../synth_top.gen/sources_1/bd/system_top_level/ipshared/3f90/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../synth_top.gen/sources_1/bd/system_top_level/ipshared/d0f7" \
"../../../bd/system_top_level/ip/system_top_level_util_vector_logic_0_0/sim/system_top_level_util_vector_logic_0_0.v" \
"../../../bd/system_top_level/ip/system_top_level_util_vector_logic_0_1/sim/system_top_level_util_vector_logic_0_1.v" \

vcom -work xil_defaultlib  -93 \
"../../../bd/system_top_level/sim/system_top_level.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

