    .data
big123:  .word 3 3 2 1 # n=3, [3,2,1]
big25:   .word 2 5 2   # n=2, [5,2]
newline: .asciiz "\n"
    .text
main:
    la $t0, big123 # load 123 into register $t0
    la $t1, big25  # load 25 into register $t1

# print big int
    jal print_big
# exit
    li $v0, 10 # 10 is exit code
    syscall

print_int:
    li $v0, 1 # 1 is print_int code
    syscall
    jr $ra

print_newline:
    la $a0, newline
    li $v0, 4 # 4 is print_string code
    syscall
    jr $ra

print_big:
    lw $t2, ($t0)      # load length of big123 (n=3) into register $t2
    move $t3, $t2      # copy length of big123 to $t3
    mul $t3, $t3, 4    # multiply big_int length by 4 to get array len
    add $t3, $t3, $t0  # get address of last element in big123 & store in register $t3
    li $t4, 0          # initialise counter
loop_pb:
    lw $a0, ($t3)
    jal print_int
    addi $t4, 1        # increment counter
    addi $t3, -4       # decrement address
    bne $t4, $t2, loop_pb # test loop condition 
# end loop
    jal print_newline
    jr $ra
