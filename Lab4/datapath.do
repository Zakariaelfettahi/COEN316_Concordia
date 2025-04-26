# Load waveforms
add wave clk
add wave reset
add wave reg_write
add wave alu_src
add wave mem_write
add wave mem_to_reg
add wave reg_dst
add wave alu_op
add wave ext_op
add wave -divider "Instruction & PC"
add wave pc
add wave instruction
add wave rs
add wave rt
add wave rd
add wave imm16
add wave -divider "Register File"
add wave reg_out_a
add wave reg_out_b
add wave write_data
add wave write_reg_addr
add wave -divider "ALU & Mem"
add wave alu_input_b
add wave alu_result
add wave dmem_out

# Initialization
force reset 1
force clk 0
run 10
force reset 0

# Cycle 1: Execute addi r1, r0, 1
force reg_write 1
force alu_src 1
force mem_write 0
force mem_to_reg 0
force reg_dst 0
force alu_op "00"
run 20

# Cycle 2: Execute addi r2, r0, 2
run 20

# Cycle 3: Execute add r2, r2, r1
force alu_src 0
force reg_dst 1
run 20

# Cycle 4: Execute j (just fetch for now, no actual jump yet)
run 20
