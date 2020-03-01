    .data
big123:  .word 3 3 2 1 # n=3, [3,2,1]
big25:   .word 2 5 2   # n=2, [5,2]
newline: .asciiz "\n"
    .text
main:
    la $t0, big123 # load 123 into register $t0
    la $t1, big25  # load 25 into register $t1
# sub big123-big25
    jal sub_big
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
    lw $t2, ($t0)      # load length of big int stored in $t0 into register $t2
    move $t3, $t2      # copy length to $t3
    mul $t3, $t3, 4    # multiply big_int length by 4 to get array len
    add $t3, $t3, $t0  # get address of last element in big int & store in register $t3
    li $t4, 0          # initialise counter
loop_pb:
    lw $a0, ($t3)
    jal print_int
    addi $t4, 1           # increment counter
    addi $t3, -4          # decrement address
    bne $t4, $t2, loop_pb # test loop condition 
# end loop
    jal print_newline
    jr $ra

sub_big:
    lw $t2, ($t1)      # load length of big int stored in $t1 into register $t2
    move $t3, $t0      # copy $t0 array ptr to $t3
    move $t4, $t1      # copy $t1 array ptr to $t4
    addi $t3, 4        # point to first element in array
    addi $t4, 4        # point to first element in array
    li $t5, 0          # initialise counter
    li $t6, 0          # initialise carry
loop_sb:
    lw $t7, ($t3)      # load A[i]
    lw $t8, ($t4)      # load B[i]
    add $t8, $t8, $t6  # B[i] += carry
# if
    bge $t7, $t8, else # if A[i] >= B[i] goto else block
    addi $t7, 10
    li $t6, 1          # carry = 1
    sub $t7, $t7, $t8  # $t7 = $t7 - $t8/A[i] - B[i]
    j endif			   # jump to endif
else:
    sub $t7, $t7, $t8  # $t7 = $t7 - $t8/A[i] - B[i]
    li $t6, 0          # carry = 0
endif:
    sw $t7, ($t3)      # store result back to *$t3/A[i]
    addi $t5, 1        # increment counter
    addi $t3, 4        # increment address A
    addi $t4, 4        # increment address B
    bne $t5, $t2, loop_sb
# end loop
    beq $t6, $0, return# if carry == 0, return, else:
    lw $t7, ($t3)      # load A[B.length]
    addi $t7, -1       # subtract carry
    sw $t7, ($t3)      # store result back in A[B.length]
return:
    jr $ra
