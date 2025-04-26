# Testbench for instruction_cache

add wave addr
add wave inst

# Test fetching instruction from address 0
force addr "00000"
run 2

# Test fetching instruction from address 1
force addr "00001"
run 2

# Test fetching instruction from address 2
force addr "00010"
run 2

# Test fetching from an unused address (should return 0s)
force addr "00100"
run 2
