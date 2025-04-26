# Constraints for regfile_bw
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk];

set_property PACKAGE_PIN W5 [get_ports clk];
set_property IOSTANDARD LVCMOS33 [get_ports clk];
set_property PACKAGE_PIN U18 [get_ports reset];
set_property IOSTANDARD LVCMOS33 [get_ports reset];

set_property PACKAGE_PIN V17 [get_ports write];
set_property IOSTANDARD LVCMOS33 [get_ports write];

set_property PACKAGE_PIN V16 [get_ports din_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports din_in[0]];
set_property PACKAGE_PIN W16 [get_ports din_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports din_in[1]];
set_property PACKAGE_PIN W17 [get_ports din_in[2]];
set_property IOSTANDARD LVCMOS33 [get_ports din_in[2]];
set_property PACKAGE_PIN W15 [get_ports din_in[3]];
set_property IOSTANDARD LVCMOS33 [get_ports din_in[3]];

set_property PACKAGE_PIN V15 [get_ports read_a_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports read_a_in[0]];
set_property PACKAGE_PIN W14 [get_ports read_a_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports read_a_in[1]];

set_property PACKAGE_PIN V14 [get_ports read_b_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports read_b_in[0]];
set_property PACKAGE_PIN U12 [get_ports read_b_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports read_b_in[1]];

set_property PACKAGE_PIN V12 [get_ports write_address_in[0]];
set_property IOSTANDARD LVCMOS33 [get_ports write_address_in[0]];
set_property PACKAGE_PIN U11 [get_ports write_address_in[1]];
set_property IOSTANDARD LVCMOS33 [get_ports write_address_in[1]];

set_property PACKAGE_PIN U16 [get_ports out_a_out[0]];
set_property IOSTANDARD LVCMOS33 [get_ports out_a_out[0]];
set_property PACKAGE_PIN E19 [get_ports out_a_out[1]];
set_property IOSTANDARD LVCMOS33 [get_ports out_a_out[1]];
set_property PACKAGE_PIN U19 [get_ports out_a_out[2]];
set_property IOSTANDARD LVCMOS33 [get_ports out_a_out[2]];
set_property PACKAGE_PIN V19 [get_ports out_a_out[3]];
set_property IOSTANDARD LVCMOS33 [get_ports out_a_out[3]];

set_property PACKAGE_PIN W18 [get_ports out_b_out[0]];
set_property IOSTANDARD LVCMOS33 [get_ports out_b_out[0]];
set_property PACKAGE_PIN W19 [get_ports out_b_out[1]];
set_property IOSTANDARD LVCMOS33 [get_ports out_b_out[1]];
set_property PACKAGE_PIN T19 [get_ports out_b_out[2]];
set_property IOSTANDARD LVCMOS33 [get_ports out_b_out[2]];
set_property PACKAGE_PIN T20 [get_ports out_b_out[3]];
set_property IOSTANDARD LVCMOS33 [get_ports out_b_out[3]];
