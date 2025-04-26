# Constraints for next_address_wrapper
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk];

set_property PACKAGE_PIN W5 [get_ports clk];
set_property IOSTANDARD LVCMOS33 [get_ports clk];
set_property PACKAGE_PIN U18 [get_ports reset];
set_property IOSTANDARD LVCMOS33 [get_ports reset];

set_property PACKAGE_PIN V17 [get_ports rt_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports rt_in[0]];
set_property PACKAGE_PIN V16 [get_ports rt_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports rt_in[1]];

set_property PACKAGE_PIN W16 [get_ports rs_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports rs_in[0]];
set_property PACKAGE_PIN W17 [get_ports rs_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports rs_in[1]];

set_property PACKAGE_PIN W15 [get_ports target_address_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports target_address_in[0]];
set_property PACKAGE_PIN V15 [get_ports target_address_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports target_address_in[1]];
set_property PACKAGE_PIN W14 [get_ports target_address_in[2]];
set_property IOSTANDARD LVCMOS33 [get_ports target_address_in[2]];

set_property PACKAGE_PIN V14 [get_ports branch_type[0]];
set_property IOSTANDARD LVCMOS33 [get_ports branch_type[0]];
set_property PACKAGE_PIN U12 [get_ports branch_type[1]];
set_property IOSTANDARD LVCMOS33 [get_ports branch_type[1]];

set_property PACKAGE_PIN V12 [get_ports pc_sel[0]];
set_property IOSTANDARD LVCMOS33 [get_ports pc_sel[0]];
set_property PACKAGE_PIN U11 [get_ports pc_sel[1]];
set_property IOSTANDARD LVCMOS33 [get_ports pc_sel[1]];

set_property PACKAGE_PIN U16 [get_ports next_pc_out[0]];
set_property IOSTANDARD LVCMOS33 [get_ports next_pc_out[0]];
set_property PACKAGE_PIN E19 [get_ports next_pc_out[1]];
set_property IOSTANDARD LVCMOS33 [get_ports next_pc_out[1]];
set_property PACKAGE_PIN U19 [get_ports next_pc_out[2]];
set_property IOSTANDARD LVCMOS33 [get_ports next_pc_out[2]];
