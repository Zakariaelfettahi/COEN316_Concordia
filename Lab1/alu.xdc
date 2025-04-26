# Constraints for alu_board
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk];

# Inputs
set_property PACKAGE_PIN V17 [get_ports x_in[0]];  # SW0
set_property PACKAGE_PIN V16 [get_ports x_in[1]];  # SW1
set_property PACKAGE_PIN W16 [get_ports x_in[2]];  # SW2
set_property PACKAGE_PIN W17 [get_ports x_in[3]];  # SW3

set_property PACKAGE_PIN W15 [get_ports y_in[0]];  # SW4
set_property PACKAGE_PIN V15 [get_ports y_in[1]];  # SW5
set_property PACKAGE_PIN W14 [get_ports y_in[2]];  # SW6
set_property PACKAGE_PIN V14 [get_ports y_in[3]];  # SW7

set_property PACKAGE_PIN U12 [get_ports logic_func[0]]; # SW8
set_property PACKAGE_PIN V12 [get_ports logic_func[1]]; # SW9

set_property PACKAGE_PIN U11 [get_ports func[0]];  # SW10
set_property PACKAGE_PIN V10 [get_ports func[1]];  # SW11

set_property PACKAGE_PIN U18 [get_ports add_sub];   # BTNC (Button Center)

# Outputs
set_property PACKAGE_PIN U16 [get_ports output_out[0]];  # LED0
set_property PACKAGE_PIN E19 [get_ports output_out[1]];  # LED1
set_property PACKAGE_PIN U19 [get_ports output_out[2]];  # LED2
set_property PACKAGE_PIN V19 [get_ports output_out[3]];  # LED3

set_property PACKAGE_PIN W18 [get_ports overflow];       # LED4
set_property PACKAGE_PIN W19 [get_ports zero];           # LED5
