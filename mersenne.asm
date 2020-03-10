    .data
small_prime_tests:          .asciiz "Small Prime Tests\n"
compress_test:              .asciiz "Compress Tests\n"
shift_right_test:           .asciiz "Shift Right Test\n"
shift_left_test:            .asciiz "Shift Left Test\n"
comparison_tests:           .asciiz "Comparison Tests\n"
multiply_tests:             .asciiz "Multiply Tests\n"
power_tests:                .asciiz "Power Tests\n"
subtraction_tests:          .asciiz "Subtraction Tests\n"
modulus_tests:              .asciiz "Modulus Tests\n"
llt_tests:                  .asciiz "LLT Tests\n"
mersenne_scan_str:          .asciiz "Mersenne Scan\n"
testing_p_equals:           .asciiz "Testing p = "
found_prime_mp_equals:      .asciiz " found prime Mp = "
mp_not_prime:               .asciiz " Mp not prime\n"
newline:                    .asciiz "\n"
big_int_0:                  .word   0 0
big_int_1:                  .word   1 1
big_int_2:                  .word   1 2
big_int_0003:               .word   4 3 0 0 0
big_int_3:                  .word   1 3
big_int_4:                  .word   1 4
big_int_7:                  .word   1 7
big_int_7_copy:             .word   1 7
big_int_12:                 .word   2 2 1
big_int_30:                 .word   2 0 3
big_int_42:                 .word   2 2 4
big_int_48:                 .word   2 8 4
big_int_7000:               .word   4 0 0 0 7
big_int_7_654_321:          .word   7 1 2 3 4 5 6 7
big_int_9_000_000:          .word   7 0 0 0 0 0 0 9   
big_int_10_000_000:         .word   8 0 0 0 0 0 0 0 1
big_int_9_000_000_000:      .word   10 0 0 0 0 0 0 0 0 0 9
big_int_9_000_000_000_copy: .word   10 0 0 0 0 0 0 0 0 0 9
                                
mult_big_desination_space:  .space  1404    # 1404 = (350+1)*4 bytes 
pow_big_destination_space:  .space  1404
mod_big_temp_space:         .space  1404    # temp space used by mod_big
LLT_temp_space:             .space  1404    # temp space used by LLT
LLT_temp_space_Mp:          .space  1404    # temp space for Mp found in LLT

# TEST_big_int_1764: .word 4 4 6 7 1

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

    # Multiply Tests
    la      $a0, multiply_tests
    jal     print_string                # print "Multiply Tests"
    la      $a0, big_int_3
    la      $a1, big_int_7
    jal     mult_big                    # MultBig(3,7)
    move    $a0, $v0                    # move result ptr to $a0
    jal     print_big                   # print result
    la      $a0, big_int_30
    la      $a1, big_int_42
    jal     mult_big                    # MultBig(30,42)
    move    $a0, $v0                    # move result ptr to $a0
    jal     print_big                   # print result
    la      $a0, big_int_10_000_000
    la      $a1, big_int_9_000_000
    jal     mult_big                    # MultBig(10000000,9000000)
    move    $a0, $v0                    # move result ptr to $a0
    jal     print_big                   # print result

    # Multiply bug test
    # la      $a0, TEST_big_int_1764
    # la      $a1, big_int_42
    # jal     mult_big                    # MultBig(1764,42)
    # move    $a0, $v0                    # move result ptr to $a0 
    # jal     print_big                   # print result
    # la      $a0, big_int_42
    # la      $a1, TEST_big_int_1764
    # jal     mult_big                    # MultBig(42, 1764)
    # move    $a0, $v0                    # move result ptr to $a0 
    # jal     print_big                   # print result


    # Power Tests
    la      $a0, power_tests
    jal     print_string                # print "Power Tests"
    la      $a0, big_int_3
    li      $a1, 4
    jal     pow_big                     # PowBig(3, 4)
    move    $a0, $v0                    # move result ptr to $a0
    jal     print_big
    la      $a0, big_int_42
    li      $a1, 42
    jal     pow_big                     # PowBig(42, 42)
    move    $a0, $v0                    # move result ptr to $a0
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
    la      $a0, big_int_9_000_000_000
    la      $a1, big_int_7_654_321
    jal     sub_big                     # $a0 = sub_big(9000000000,7654321)
    jal     print_big                   # print result

    # Modulus Tests
    la      $a0, modulus_tests
    jal     print_string                # print "Modulus Tests"
    la      $a0, big_int_7_copy
    la      $a1, big_int_3
    jal     mod_big                     # 7 % 3
    move    $a0, $v0
    jal     print_big                   # print result
    la      $a0, big_int_48
    la      $a1, big_int_12
    jal     mod_big                     # 48 % 12
    move    $a0, $v0
    jal     print_big                   # print result
    la      $a0, big_int_9_000_000_000_copy
    la      $a1, big_int_7_654_321
    jal     mod_big                     # 9,000,000,000 % 7,654,321
    move    $a0, $v0
    jal     print_big                   # print result

    # LLT Tests
    # la      $a0, llt_tests
    # jal     print_string                # print "LLT Tests"
    # li      $a0, 11
    # jal     LLT                         # LLT(11)
    # move    $a0, $v0
    # jal     print_int                   # print 0 or 1
    # jal     print_newline
    # li      $a0, 61
    # jal     LLT                         # LLT(61)
    # move    $a0, $v0
    # jal     print_int                   # print 0 or 1
    # jal     print_newline

    # Mersenne Scan
    la		$a0, mersenne_scan_str
    jal     print_string                # print "Mersenne Scan"
    jal     mersenne_scan               # run mersenne scan

    # Exit
    li		$v0,10		                # $v0=10
    syscall

compare_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    lw      $t0, ($a0)                  # t0 = A.length
    lw      $t1, ($a1)                  # t1 = B.length
    li      $v0, 0                      # initialise return value = 0
    beq     $t0, $t1, compare_big_digits # if lengths are equal then goto individual digits comparison
    bgt		$t0, $t1, a_greater_than_b  # if $t0 > $t1 then goto a_greater_than_b
a_less_than_b:
    li      $v0, -1                     # return = -1
    j		return_cb				    # jump to end of compare_big
a_greater_than_b:
    li      $v0, 1                      # return = 1
    j		return_cb				    # jump to end of compare_big
compare_big_digits:
    beq     $t0, $0, return_cb          # if lengths == 0, jump to end
    move    $t2, $a0                    # t2 = A
    move    $t3, $a1                    # t3 = B
    mul     $t7, $t0, 4                 # multiply big_int length by 4 to get array len
    add     $t2, $t2, $t7               # get ptr to A[n]
    add     $t3, $t3, $t7               # get ptr to B[n]
    li      $t4, 0                      # initialise counter
loop_cb:
    lw      $t5, ($t2)                  # load A[i]
    lw      $t6, ($t3)                  # load B[i]
    bgt		$t5, $t6, a_greater_than_b  # if A[i] > B[i] then goto a_greater_than_b
    blt		$t5, $t6, a_less_than_b     # if A[i] < B[i] then goto a_less_than_b
    addi    $t2, -4                     # t2 points to A[i-1]
    addi    $t3, -4                     # t3 points to B[i-1]
    addi    $t4, 1                      # counter += 1
    bne     $t4, $t0, loop_cb           # test loop condition
return_cb:
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
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

LLT:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move    $s0, $a0                    # a0 = p
    la      $s1, big_int_0
    la      $s2, big_int_1
    la      $s3, big_int_2
    la      $a0, LLT_temp_space
    jal     zero_out_big                # zero out bits in LLT temp space
    la      $a0, LLT_temp_space_Mp
    jal     zero_out_big                # zero out bits in LLT temp space for Mp
    move    $a0, $s3                    # a0 = 2
    move    $a1, $s0                    # a1 = p
    jal     pow_big                     # Mp = powBig(2, p)
    move    $s4, $v0                    # s4 = Mp
    move    $a0, $s4                    # a0 = Mp
    move    $a1, $s2                    # a1 = 1
    jal     sub_big                     # Mp -= 1
    move    $a0, $s4
    la      $a1, LLT_temp_space_Mp
    jal     memcpy_big                  # copy Mp to LLT_temp_space_Mp to stop it getting overwritten
    la      $s4, LLT_temp_space_Mp      # s4 points to LLT_temp_space_Mp
    la      $a0, big_int_4              # load copy source
    la      $a1, LLT_temp_space         # load copy destination
    jal     memcpy_big                  # LLT_temp_space = "s" = 4
    move    $s5, $v0                    # s5 = s
    li      $s6, 0                      # initialise counter
    addi    $s0, -2                     # p -= 2
loop_llt:
    move    $a0, $s5
    move    $a1, $s5
    jal     mult_big                    # s = s*s
    move    $a0, $v0                    # move result to copy source
    move    $a1, $s5                    # move s to destination source
    jal     memcpy_big
    move    $a0, $s5                    # a0 = s
    move    $a1, $s3                    # a1 = 2
    jal     sub_big
    move    $a0, $s5                    # a0 = s
    move    $a1, $s4                    # a1 = Mp
    jal     mod_big
    addi    $s6, 1                      # counter ++
    bne     $s6, $s0, loop_llt          # continue while counter != p-2
    move    $a0, $s5                    # a0 = s
    la      $a1, big_int_0              # a1 = 0
    jal     compare_big                 # compareBig(s, 0)
    move    $t0, $v0                    # t0 = result
    li      $v0, 1                      # result = 1 (PRIME)
    beq		$t0, $0, return_llt         # if s == 0, goto return
    li      $v0, 0                      # result = 0 (NOT_PRIME)
return_llt:
    move    $v1, $s4                    # return value 2 = Mp
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
    jr  $ra

memcpy_big:
    sw      $s0, -4($sp)                # store s0 on stack
    sw      $s1, -8($sp)                # store s1 on stack
    sw      $s2, -12($sp)               # store s2 on stack
    sub     $sp, $sp, 12                # decrement stack ptr by 3
    move    $t0, $a0                    # load source address
    move    $t1, $a1                    # load destination address
    lw      $t2, ($t0)                  # get length of source big_int
    li      $t3, -1                     # initialise counter (want additional iteration to copy length)
loop_memb:
    lw      $t4, ($t0)                  # temp = A[i]
    sw      $t4, ($t1)                  # B[i] = temp
    addi    $t0, 4                      # point to A[a+1]
    addi    $t1, 4                      # point to B[i+1]
    addi    $t3, 1                      # counter += 1
    bne     $t3, $t2, loop_memb
    move    $v0, $a1                    # set return to destination address
    lw      $s2, 0($sp)                 # pop s2 off stack
    lw      $s1, 4($sp)                 # pop s1 off stack
    lw      $s0, 8($sp)                 # pop s0 off stack
    addi    $sp, 12                     # increment stack ptr by 3
    jr      $ra

mersenne_scan:
    sw      $ra, -4($sp)                # store return address on stack
    sub     $sp, $sp, 4                 # decrement stack ptr
    li      $s0, 2                      # initialise counter
    li      $s1, 129                    # load upper bound
loop_mscan:
    move    $a0, $s0                    # a0 = counter
    jal     is_small_prime              # is_small_prime(p)
    beq     $v0, $0, continue_loop_mscan # if result is false, goto next number
    la      $a0, testing_p_equals
    jal     print_string                # print "Testing p = "
    move    $a0, $s0
    jal     print_int                   # print p
    move    $a0, $s0
    jal     LLT                         # call LLT(p)
    beq     $v0, $0, not_mersenne_prime # if result is 0, goto not mersenne prime
    move    $s2, $v1                    # s2 = Mp
    la      $a0, found_prime_mp_equals
    jal     print_string
    move    $a0, $s2
    jal     print_big
    j		continue_loop_mscan		    # jump to target
not_mersenne_prime:
    la		$a0, mp_not_prime
    jal     print_string 
continue_loop_mscan:
    addi    $s0, 1                      # counter ++
    bne     $s0, $s1, loop_mscan        # test loop condition
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
    jr      $ra

mod_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move    $s0, $a0                    # s0 = a
    move    $s1, $a1                    # s1 = b
    la      $a0, mod_big_temp_space
    jal     zero_out_big                # zero out bits in mod temp space
    la      $s2, mod_big_temp_space     # s2 = empty space
    move    $a0, $s1
    move    $a1, $s2
    jal     memcpy_big                  # b_copy = b
loop_modb:
    move    $a0, $s0
    move    $a1, $s2
    jal     compare_big                 # CompareBig(a,b_copy)
    move    $t0, $v0                    # t0 = CompareBig result
    li      $t1, 1                      # t1 = 1
    bne		$t0, $t1, end_loop_modb	    # if $t0 != 1 then goto end of loop
    move    $a0, $s2
    jal     shift_right                 # b_copy >> 1
    j		loop_modb	                # jump to start of loop
end_loop_modb:
    move    $a0, $s2
    jal     shift_left                  # b_copy << 1
loop_outer_modb:
    move    $a0, $s2
    move    $a1, $s1
    jal     compare_big                 # CompareBig(b_copy,b)
    move    $t0, $v0                    # t0 = CompareBig result
    li      $t1, -1                     # t1 = 1
    beq		$t0, $t1, end_loop_outer_modb # if $t0 == -1 then goto end of loop
loop_inner_modb:
    move    $a0, $s0
    move    $a1, $s2
    jal     compare_big                 # CompareBig(a,b_copy)
    move    $t0, $v0                    # t0 = CompareBig result
    li      $t1, -1                     # t1 = 1
    beq		$t0, $t1, end_loop_inner_modb # if $t0 == -1 then goto end of loop
    move    $a0, $s0
    move    $a1, $s2
    jal     sub_big                     # a - b_copy
    j		loop_inner_modb				# jump to start of loop
end_loop_inner_modb:
    move    $a0, $s2
    jal     shift_left                  # b_copy << 1
    j		loop_outer_modb				# jump to loop start
end_loop_outer_modb:
    move    $v0, $s0                    # return address = a
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
    jr      $ra

# TODO: fix parameter order bug
# 1764 * 42 = 74088     [Correct]
# 42 * 1764 = 414088    [Wrong]
mult_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move 	$t0, $a0		            # t0 = A
    move 	$t1, $a1		            # t1 = B
    la      $v0, mult_big_desination_space # v0 = C
    lw		$t2, ($t0)		            # temp = A.length
    lw		$t3, ($t1)		            # temp2 = B.length
    add     $t2, $t2, $t3               # temp += temp2
    sw      $t2, ($v0)                  # C.length = A.length + B.length
    add     $t4, $v0, 4                 # t4 points to C[0]
    li      $t5, 0                      # initialise counter
loop_init_zero:                         # initialse all digits in C to 0
    sw      $0, ($t4)                   # C[i] = 0
    addi    $t4, 4                      # t4 points to C[i+1]
    addi    $t5, 1                      # counter += 1
    bne     $t5, $t2, loop_init_zero    # check loop condition
    li      $t5, 0                      # reset counter
    lw		$s0, ($t0)		            # s0 = A.length
    move 	$t6, $t3		            # t6 = B.length
    addi    $t0, 4                      # t0 points to A[0]
    addi    $t1, 4                      # t1 points to B[0]
    move 	$s2, $t1		            # s2 points to B[0]
    li      $s5, 0                      # initialise address offset
loop_outer_mb:
    add     $s0, $s0, $t5               # s0 += outer counter (i) 
    li      $t7, 0                      # initialise carry
    move    $t8, $t5                    # init inner counter (j) = outer counter (i)
    move 	$s1, $t0		            # reset s0 to point to A[0]
    add     $t4, $v0, 4                 # reset t4 to point to C[0]
    add     $t4, $t4, $s5               # point to C[i] (add address offset)
loop_inner_mb:
    lw		$t9, ($t4)		            # temp = C[j]
    add     $t9, $t9, $t7               # temp += carry
    lw      $t2, ($s1)                  # t2 = A[j-i]
    lw      $t3, ($s2)                  # t3 = B[i]
    mul     $t2, $t2, $t3               # t2 = B[i] * A[j-i]
    add     $t9, $t9, $t2               # temp += t2
    li      $s4, 10                     # s4 = 10
    div     $t9, $s4                    # temp / 10
    mflo    $t7                         # carry = temp / 10
    mfhi    $s4                         # s4 = temp % 10
    sw      $s4, ($t4)                  # C[j] = s4
    addi    $s1, 4                      # s1 points to A[j-i+1]
    addi    $t4, 4                      # t4 points to C[j+1]
    addi    $t8, 1                      # inner counter += 1
    bne     $t8, $s0, loop_inner_mb     # while inner counter != A.length+i, continue inner loop
    beq     $t7, $0, endif_mb           # if carry == 0 then goto endif
    lw		$t9, ($t4)		            # temp = C[j]
    add     $t9, $t9, $t7               # temp += carry
    li      $s4, 10                     # s4 = 10
    div     $t9, $s4                    # temp / 10
    mflo    $t7                         # carry = temp / 10
    mfhi    $s4                         # s4 = temp % 10
    sw      $s4, ($t4)                  # C[j] = s4
endif_mb:
    addi    $s2, 4                      # s2 points to B[i+1]
    addi    $s5, 4                      # increment address offset to the next address
    addi    $t5, 1                      # outer counter += 1
    bne     $t5, $t6, loop_outer_mb     # while outer counter != B.length, continue outer loop
    move    $a0, $v0                    # a0 = address pointing to C
    jal     compress                    # Compress(C[])
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
    jr      $ra
    
pow_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move    $t0, $a0                    # copy big_int address from $a0 to $t0
    move    $s0, $a0                    # copy big_int address also to $s0
    move    $s1, $a1                    # move exponent to $t1
    li      $s2, 1                      # initialise counter
    la      $a0, pow_big_destination_space
    jal     zero_out_big                # zero out bits in destination space
loop_powb:
    move    $a0, $t0                    # a0 = result of last iteration
    move    $a1, $s0                    # a1 = A
    jal     mult_big                    # v0 = MultBig(A, result of last iteration)
    move    $a0, $v0                    # move result address to a0
    la      $a1, pow_big_destination_space # load address of empty space
    jal     memcpy_big                  # copy result of MultBig to empty space
    move    $t0, $v0                    # t0 points to empty space
    addi    $s2, 1                      # increment counter
    bne     $s2, $s1, loop_powb         # test loop condition
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
    jr      $ra

print_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move    $t0, $a0                    # copy address from $a0 to $t0
    lw      $t2, ($t0)                  # load length of big int stored in $t0 into register $t2
    bne     $t2, $0, continue_pb        # if length is not 0 then goto continue_pb
    move    $a0, $0
    jal     print_int                   # print "0"
    j       end_loop_pb                 # goto end
continue_pb:
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
end_loop_pb:
    jal     print_newline
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
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
    li		$t3, 1		                # t3 = 1
    bne     $t2, $t3, continue_sl       # if big_int.length > 1 goto continue
    sw      $0, 4($t0)                  # A[0] = 0
    j		end_loop_sl				    # jump to end_loop_sl
continue_sl:
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
end_loop_sl:
    jal     compress
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
    jr      $ra

shift_right:
    sw      $ra, -4($sp)                # store return address on stack
    sub     $sp, $sp, 4                 # decrement stack ptr
    move    $t0, $a0                    # copy address from $a0 to $t0
    move    $t1, $t0                    # make another copy
    lw      $t2, ($t1)                  # get A.length
    # beq     $t2, $0, end_shift_right    # if length = 0, do nothing
    addi    $t1, 4                      # point to A[0]
    lw      $t3, ($t1)                  # get A[0]
    sw      $0, ($t1)                   # set A[0] = 0
    li      $t4, 0                      # initialise counter
loop_sr:
    addi    $t1, 4                      # point to A[i+1]
    # move    $a0, $t1
    # jal     print_int
    lw      $t5, ($t1)                  # temp = A[i+1]
    sw      $t3, ($t1)                  # A[i+1] = A[i]
    move    $t3, $t5                    # update A[i] temp register
    addi    $t4, 1                      # increment counter
    bne     $t4, $t2, loop_sr           # test loop condition 
    addi    $t2, 1                      # A.length += 1
    sw      $t2, ($t0)                  # store length back into big int
# end_shift_right:
    lw      $ra, ($sp)                  # get return address off stack
    addi    $sp, 4                      # increment stack ptr
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

zero_out_big:
    sw      $ra, -4($sp)                # store return address on stack
    sw      $s0, -8($sp)                # store s0 on stack
    sw      $s1, -12($sp)               # store s1 on stack
    sw      $s2, -16($sp)               # store s2 on stack
    sw      $s3, -20($sp)               # store s3 on stack
    sw      $s4, -24($sp)               # store s4 on stack
    sw      $s5, -28($sp)               # store s5 on stack
    sw      $s6, -32($sp)               # store s6 on stack
    sw      $s7, -36($sp)               # store s7 on stack
    sub     $sp, $sp, 36                # decrement stack ptr by 9
    move    $s0, $a0
    li      $s1, 351                    # MAX_DIGITS (350) + 1 int for size
    li      $s2, 0                      # initialise counter
loop_z:
    sw      $0, ($s0)                   # A[i] = 0
    addi    $s0, 4                      # point to A[i+1]
    addi    $s2, 1                      # counter ++
    bne     $s1, $s2, loop_z            # test loop condition
    lw      $s7, 0($sp)                 # pop s7 off stack
    lw      $s6, 4($sp)                 # pop s6 off stack
    lw      $s5, 8($sp)                 # pop s5 off stack
    lw      $s4, 12($sp)                # pop s4 off stack
    lw      $s3, 16($sp)                # pop s3 off stack
    lw      $s2, 20($sp)                # pop s2 off stack
    lw      $s1, 24($sp)                # pop s1 off stack
    lw      $s0, 28($sp)                # pop s0 off stack
    lw      $ra, 32($sp)                # get return address off stack
    addi    $sp, 36                     # increment stack ptr by 9
    jr      $ra