    .data
newline:    .asciiz "\n"
    .text
main:
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
#exit
    li		$v0,10		                # $v0=10
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

is_small_prime:
    move 	$t0, $a0		        # $t0 = $a0
    move    $t1, $t0                # $t1 = $t0
    li      $t2, 2                  # init end of loop number
    li      $t3, 1                  # init bool isPrime = true
loop_isp:
    addi	$t1, $t1, -1		    # $t0 -= 1
    div		$t0, $t1			    # $t0 / $t1
    mfhi	$t4					    # $t4 = $t0 % $t1
    bne		$t4, $0, continue_loop_isp# if $t4 != 0 then continue_loop_isp
# else not prime
    li		$t3, 0		            # $t3 = false
    j		end_loop_isp			# jump to end of loop
continue_loop_isp:
    bne		$t1, $t2, loop_isp	    # if $t1 != $t2 then continue loop
end_loop_isp:
    move    $v0, $t3                # store result in v0
    jr		$ra					    # jump to $ra
    
    

# - Test regular int 7 for primacy, output 1 if prime, 0 otherwise (expected value: 1)
# - Test regular int 81 for primacy, output 1 if prime, 0 otherwise (expected value: 0)
# - Test regular int 127 for primacy, output 1 if prime, 0 otherwise (expected value: 1)