
# set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]

## Inputs: rs_in
set_property -dict { PACKAGE_PIN U19 IOSTANDARD LVCMOS33 } [get_ports rs_in[0]]
set_property -dict { PACKAGE_PIN V19 IOSTANDARD LVCMOS33 } [get_ports rs_in[1]]

## Inputs: rt_in
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports rt_in[0]]
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports rt_in[1]]

## Input: pc_in
set_property -dict { PACKAGE_PIN T19 IOSTANDARD LVCMOS33 } [get_ports pc_in[0]]
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports pc_in[1]]
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports pc_in[2]]

## Input: target_address_in
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports target_address_in[0]]
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports target_address_in[1]]
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports target_address_in[2]]

## Input: pc_sel
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports pc_sel[0]]
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports pc_sel[1]]

## Input: branch_type
set_property -dict { PACKAGE_PIN U15 IOSTANDARD LVCMOS33 } [get_ports branch_type[0]]
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports branch_type[1]]

## Output: next_pc_out
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports next_pc_out[0]]
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports next_pc_out[1]]
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports next_pc_out[2]]
