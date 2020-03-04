    .data
small_prime_tests:      .asciiz "Small Prime Tests\n"
compress_test:          .asciiz "Compress Tests\n"
shift_right_test:       .asciiz "Shift Right Test\n"
shift_left_test:        .asciiz "Shift Left Test\n"
comparison_tests:       .asciiz "Comparison Tests\n"
multiply_tests:         .asciiz "Multiply Tests\n"
power_tests:            .asciiz "Power Tests\n"
subtraction_tests:      .asciiz "Subtraction Tests\n"
modulus_tests:          .asciiz "Modulus Tests\n"
llt_tests:              .asciiz "LLT Tests\n"
mersenne_scan:          .asciiz "Mersenne Scan\n"
test_p_equals:          .asciiz "Testing p = "
found_prime_mp_equals:  .asciiz " found prime Mp = "
newline:                .asciiz "\n"
big_int_0003:           .word   4 3 0 0 0
big_int_3:              .word   1 3
big_int_7:              .word   1 7
big_int_12:             .word   2 2 1
big_int_30:             .word   2 0 3
big_int_42:             .word   2 2 4
big_int_7000:           .word   4 0 0 0 7
big_int_7_654_321:      .word   7 1 2 3 4 5 6 7
big_int_9_000_000:      .word   7 0 0 0 0 0 0 9   
big_int_10_000_000:     .word   8 0 0 0 0 0 0 0 1
big_int_9_000_000_000:  .word   10 0 0 0 0 0 0 0 0 0 9
big_int_empty_space:    .space  1400 # 350*4 bytes

    .text
main:
    # Small Prime Tests
    la      $a0, small_prime_tests
    jal     print_string                # print "Small Prime Tests"
    li		$a0,7 		                # a0=7 
    jal		is_small_prime				# jump to is_small_prime and save position to $ra
    move    $a0,$v0                     # move result of is_small_prime to $a0
    jal     print_int
    jal     print_newline
    li		$a0,81 		                # $a0=81
    jal		is_small_prime				# jump to is_small_prime and save position to $ra
    move    $a0,$v0                     # move result of is_small_prime to $a0
    jal     print_int
    jal     print_newline
    li		$a0,127 		            # $a0=127
    jal		is_small_prime				# jump to is_small_prime and save position to $ra
    move    $a0,$v0                     # move result of is_small_prime to $a0
    jal     print_int
    jal     print_newline

    # Compress Tests
    la      $a0, compress_test
    jal     print_string                # print "Compress Test"
    la      $a0, big_int_0003
    jal     compress                    # Compress(0003)
    jal     print_big

    # Shift Right Test
    la      $a0, shift_right_test
    jal     print_string                # print "Shift Right Test"
    la      $a0, big_int_0003
    jal     shift_right                 # ShiftRight(3)
    jal     shift_right                 # ShiftRight(30)
    jal     shift_right                 # ShiftRight(300)
    jal     print_big

    # Shift Left Test
    la      $a0, shift_left_test
    jal     print_string                # print "Shift Left Test"
    la      $a0, big_int_7000
    jal     shift_left                  # ShiftLeft(7000)
    jal     shift_left                  # ShiftLeft(700)
    jal     print_big

    # Comparison Tests
    la      $a0, comparison_tests
    jal     print_string                # print "Comparison Tests"
    la      $a0, big_int_42
    la      $a1, big_int_30
    jal     compare_big                 # CompareBig(42,30)
    move    $a0, $v0                    # move result to $a0
    jal     print_int                   # print result
    jal     print_newline
    la      $a0, big_int_30
    la      $a1, big_int_42
    jal     compare_big                 # CompareBig(30,42)
    move    $a0, $v0                    # move result to $a0
    jal     print_int                   # print result
    jal     print_newline
    la      $a0, big_int_42
    la      $a1, big_int_42
    jal     compare_big                 # CompareBig(42,42)
    move    $a0, $v0                    # move result to $a0
    jal     print_int                   # print result
    jal     print_newline

    # Subtraction Tests
    la      $a0, subtraction_tests
    jal     print_string                # print "Subtraction Tests"
    la      $a0, big_int_7
    la      $a1, big_int_3
    jal     sub_big                     # $a0 = sub_big(7,3)
    jal     print_big                   # print result
    la      $a0, big_int_42
    la      $a1, big_int_12
    jal     sub_big                     # $a0 = sub_big(42,12)
    jal     print_big                   # print result
    la      $a0, big_int_9_000_000_000
    la      $a1, big_int_7_654_321
    jal     sub_big                     # $a0 = sub_big(9000000000,7654321)
    jal     print_big                   # print result

    # Exit
    li		$v0,10		                # $v0=10
    syscall

compare_big:
    lw      $t0, ($a0)                  # t0 = A.length
    lw      $t1, ($a1)                  # t1 = B.length
    li      $v0, 0                      # initialise return value = 0
    beq     $t0, $t1, compare_big_digits# if lengths are equal then goto individual digits comparison
    bgt		$t0, $t1, a_greater_than_b  # if $t0 > $t1 then goto a_greater_than_b
a_less_than_b:
    li      $v0, -1                     # return = -1
    j		return_cb				    # jump to end of compare_big
a_greater_than_b:
    li      $v0, 1                      # return = 1
    j		return_cb				    # jump to end of compare_big
compare_big_digits:
    add     $t2, $a0, 4                 # t2 points to A[0]
    add     $t3, $a1, 4                 # t3 points to B[0]
    li      $t4, 0                      # initialise counter
loop_cb:
    lw      $t5, ($t2)                  # load A[i]
    lw      $t6, ($t3)                  # load B[i]
    bgt		$t5, $t6, a_greater_than_b  # if A[i] > B[i] then goto a_greater_than_b
    blt		$t5, $t6, a_less_than_b     # if A[i] < B[i] then goto a_less_than_b
    addi    $t2, 4                      # t2 points to A[i+1]
    addi    $t3, 4                      # t3 points to B[i+1]
    addi    $t4, 1                      # counter += 1
    bne     $t4, $t0, loop_cb           # test loop condition
return_cb:
    jr      $ra

compress:
    move    $t0, $a0                    # copy address from $a0 to $t0
    lw      $t1, ($t0)                  # load length of big int stored in $t0 into register $t1
    move    $t2, $t1                    # copy length to $t2
    mul     $t2, $t2, 4                 # multiply big_int length by 4 to get array len
    add     $t2, $t2, $t0               # get address of last element in big int & store in register $t2
    li      $t3, 0                      # initialise counter
loop_c:
    lw      $t4, ($t2)                  # t4 = A[n-i]
    bne     $t4, $0, end_loop_c
    addi    $t3, 1                      # increment counter
    addi    $t2, -4                     # decrement address
    bne     $t3, $t1, loop_c            # test loop condition 
end_loop_c:
    sub     $t1, $t1, $t3		        # old length - leading zeros count
    sw      $t1, ($t0)                  # store new length back into big_int
    jr      $ra

is_small_prime:
    move 	$t0, $a0		            # $t0 = $a0
    move    $t1, $t0                    # $t1 = $t0
    li      $t2, 2                      # init end of loop number
    li      $t3, 1                      # init bool isPrime = true
loop_isp:
    addi	$t1, $t1, -1		        # $t0 -= 1
    div		$t0, $t1			        # $t0 / $t1
    mfhi	$t4					        # $t4 = $t0 % $t1
    bne		$t4, $0, continue_loop_isp  # if $t4 != 0 then continue_loop_isp
# else not prime
    li		$t3, 0		                # $t3 = false
    j		end_loop_isp			    # jump to end of loop
continue_loop_isp:
    bne		$t1, $t2, loop_isp	        # if $t1 != $t2 then continue loop
end_loop_isp:
    move    $v0, $t3                    # store result in v0
    jr		$ra					        # jump to $ra

print_big:
    sw      $ra, -4($sp)                # store return address on stack
    sub     $sp, $sp, 4                 # decrement stack ptr
    move    $t0, $a0                    # copy address from $a0 to $t0
    lw      $t2, ($t0)                  # load length of big int stored in $t0 into register $t2
    move    $t3, $t2                    # copy length to $t3
    mul     $t3, $t3, 4                 # multiply big_int length by 4 to get array len
    add     $t3, $t3, $t0               # get address of last element in big int & store in register $t3
    li      $t4, 0                      # initialise counter
loop_pb:
    lw      $a0, ($t3)
    jal     print_int
    addi    $t4, 1                      # increment counter
    addi    $t3, -4                     # decrement address
    bne     $t4, $t2, loop_pb           # test loop condition 
# end loop
    jal     print_newline
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
    jr      $ra

print_int:
    li      $v0, 1                      # 1 is print_int code
    syscall
    jr      $ra

print_newline:
    la      $a0, newline
    li      $v0, 4                      # 4 is print_string code
    syscall
    jr      $ra

print_string:
    li      $v0, 4                      # 4 is print_string code
    syscall
    jr      $ra

shift_left:
    sw      $ra, -4($sp)                # store return address on stack
    sub     $sp, $sp, 4                 # decrement stack ptr
    move    $t0, $a0                    # copy address from $a0 to $t0
    lw      $t2, ($t0)                  # load length of big int stored in $t0 into register $t2
    move    $t3, $t2                    # copy length to $t3
    mul     $t3, $t3, 4                 # multiply big_int length by 4 to get array len
    add     $t3, $t3, $t0               # get address of last element in big int & store in register $t3
    li      $t4, 1                      # initialise counter
    lw      $t5, ($t3)                  # get A[n]
    sw      $0, ($t3)                   # A[n] = 0
loop_sl:
    addi    $t3, -4                     # point to A[i-1]
    lw      $t6, ($t3)                  # temp = A[i-1]
    sw      $t5, ($t3)                  # A[i-1] = A[i]var
    move    $t5, $t6                    # A[i]var = temp
    addi    $t4, 1                      # increment counter
    bne     $t4, $t2, loop_sl           # test loop condition
# end loop
    jal     compress
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
    jr      $ra

shift_right:
    move    $t0, $a0                    # copy address from $a0 to $t0
    move    $t1, $t0                    # make another copy
    lw      $t2, ($t1)                  # get A.length
    addi    $t1, 4                      # point to A[0]
    lw      $t3, ($t1)                  # get A[0]
    sw      $0, ($t1)                   # set A[0] = 0
    li      $t4, 0                      # initialise counter
loop_sr:
    addi    $t1, 4                      # point to A[i+1]
    lw      $t5, ($t1)                  # temp = A[i+1]
    sw      $t3, ($t1)                  # A[i+1] = A[i]
    move    $t3, $t5                    # update A[i] temp register
    addi    $t4, 1                      # increment counter
    bne     $t4, $t2, loop_sr           # test loop condition 
    addi    $t2, 1                      # A.length += 1
    sw      $t2, ($t0)                  # store length back into big int
    jr      $ra

sub_big:
    sw      $ra, -4($sp)                # store return address on stack
    sub     $sp, $sp, 4                 # decrement stack ptr
    move    $t0, $a0                    # copy address from $a0 to $t0
    move    $t1, $a1                    # copy address from $a1 to $t1
    lw      $t2, ($t1)                  # load length of big int stored in $t1 into register $t2
    move    $t3, $t0                    # copy $t0 array ptr to $t3
    move    $t4, $t1                    # copy $t1 array ptr to $t4
    addi    $t3, 4                      # point to first element in array
    addi    $t4, 4                      # point to first element in array
    li      $t5, 0                      # initialise counter
    li      $t6, 0                      # initialise carry
loop_sb:
    lw      $t7, ($t3)                  # load A[i]
    lw      $t8, ($t4)                  # load B[i]
    add     $t8, $t8, $t6               # B[i] += carry
# if
    bge     $t7, $t8, else_sb           # if A[i] >= B[i] goto else block
    addi    $t7, 10                     # $t7 += 10
    li      $t6, 1                      # carry = 1
    sub     $t7, $t7, $t8               # $t7 = $t7 - $t8/A[i] - B[i]
    j       endif_sb			        # jump to endif
else_sb:
    sub     $t7, $t7, $t8               # $t7 = $t7 - $t8/A[i] - B[i]
    li      $t6, 0                      # carry = 0
endif_sb:
    sw      $t7, ($t3)                  # store result back to *$t3/A[i]
    addi    $t5, 1                      # increment counter
    addi    $t3, 4                      # increment address A
    addi    $t4, 4                      # increment address B
    bne     $t5, $t2, loop_sb
# end loop
    beq     $t6, $0, return_sb          # if carry == 0, return, else:
loop2_sb:
    lw      $t7, ($t3)                  # load A[B.length]
    bne     $t7, $0, end_loop2_sb       # end loop if A[i] != 0
    li      $t7, 9
    sw      $t7, ($t3)                  # A[i] = 9
    addi    $t3, 4                      # increment ptr to A[i+1]
    j       loop2_sb                    # check again if integer is > 0
end_loop2_sb:
    addi    $t7, -1                     # subtract carry
    sw      $t7, ($t3)                  # store result back in A[B.length]
return_sb:
    jal     compress
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
    jr      $ra
