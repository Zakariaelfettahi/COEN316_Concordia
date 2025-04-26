# Testbench for data_cache

add wave clk
add wave reset
add wave addr
add wave d_in
add wave write_en
add wave d_out

# Reset first
force reset 1
run 2
force reset 0

# Write value to address 1
force addr "00001"
force d_in x"DEADBEEF"
force write_en 1
force clk 0
run 1
force clk 1
run 1
force clk 0
run 1

# Read value from address 1
force write_en 0
run 2

# Write value to address 2
force addr "00010"
force d_in x"BEEF1234"
force write_en 1
force clk 1
run 1
force clk 0
run 1

# Read value from address 2
force write_en 0
run 2
