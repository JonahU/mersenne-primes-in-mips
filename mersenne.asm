    .data
small_prime_tests:      .asciiz "Small Prime Tests\n"
compress_test:          .asciiz "Compress Tests\n"
shift_right_test:       .asciiz "Shift Right Test\n"
shift_left_test:        .asciiz "Shift Left Test\n"
comparison_test:        .asciiz "Comparison Tests\n"
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
big_int_7_654_321:      .word   7 6 5 4 3 2 1
big_int_9_000_000:      .word   0 0 0 0 0 0 9   
big_int_10_000_000:     .word   0 0 0 0 0 0 0 1
big_int_9_000_000_000:  .word   0 0 0 0 0 0 0 0 0 9

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
    jal     compress
    jal     print_big

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
    # TODO: 9000000000 - 7654321

    # Exit
    li		$v0,10		                # $v0=10
    syscall

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

sub_big:
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
    addi    $t7, 10
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
    li      $t6, 0                      # carry = 0
    bne     $t5, $t2, loop_sb
# end loop
    beq     $t6, $0, return_sb          # if carry == 0, return, else:
    lw      $t7, ($t3)                  # load A[B.length]
    addi    $t7, -1                     # subtract carry
    sw      $t7, ($t3)                  # store result back in A[B.length]
return_sb:
    jr      $ra
