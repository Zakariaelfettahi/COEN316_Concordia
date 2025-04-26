# Testbench for sign_extender

add wave imm_in
add wave imm_out

# Test positive value
force imm_in x"7FFF"  ; +32767
run 2

# Test zero
force imm_in x"0000"
run 2

# Test negative value
force imm_in x"FFFF"  ; -1
run 2

# Another negative test
force imm_in x"8000"  ; -32768
run 2
