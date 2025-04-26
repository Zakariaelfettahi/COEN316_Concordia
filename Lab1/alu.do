add wave x
add wave y
add wave add_sub
add wave logic_func
add wave func
add wave zero
add wave overflow


# Test case 1: Addition
force x "00000000000000000000000000000001"
force y "00000000000000000000000000000001"
force add_sub 0
force logic_func "00"
force func "10"
run 2

# Test case 2: Subtraction
force x "00000000000000000000000000000010"
force y "00000000000000000000000000000001"
force add_sub 1
force logic_func "00"
force func "10"
run 10 ns

# Test case 3: AND operation
force x "00000000000000000000000000000011"
force y "00000000000000000000000000000001"
force add_sub 0
force logic_func "00"
force func "11"
run 2

# Test case 4: OR operation
force x "00000000000000000000000000000010"
force y "00000000000000000000000000000001"
force add_sub 0
force logic_func "01"
force func "11"
run 2

# Test case 5: SLT operation
force x "00000000000000000000000000000001"
force y "00000000000000000000000000000010"
force add_sub 1
force logic_func "00"
force func "01"
run 2

# Test case 6: XOR operation
force x "00000000000000000000000000000011"
force y "00000000000000000000000000000001"
force add_sub 0
force logic_func "10"
force func "11"
run 2

# Test case 7: NOR operation
force x "00000000000000000000000000000010"
force y "00000000000000000000000000000001"
force add_sub 0
force logic_func "11"
force func "11"
run 2


