#Read All Files
#read_file -format verilog Bicubic.v
#read_file -format sverilog  Bicubic.v
analyze -format verilog { 
    ./rtl/Bicubic.v         \
    ./rtl/multi_div.v       \
    ./rtl/interpolation1d.v \
    ./rtl/sr.v             
}
elaborate Bicubic
current_design Bicubic
link

#Setting Clock Constraints
source -echo -verbose Bicubic.sdc
set_fix_hold                [all_clocks]
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
#set_max_area 0
#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile_ultra

sh mkdir -p report
sh mkdir -p syn

write -format ddc     -hierarchy -output "./syn/Bicubic_syn.ddc"
write_sdf -version 1.0  ./syn/Bicubic_syn.sdf
write -format verilog -hierarchy -output ./syn/Bicubic_syn.v
report_area > ./report/area.log
report_timing > ./report/timing.log
report_qor   >  ./report/Bicubic_syn.qor
write_parasitics -output ./syn/Bicubic_syn.spef
exit
