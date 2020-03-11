# Jonah Usadi
## MPCS 52010 - Winter 2020
## Project 2 - Mersenne Primes in MIPS

## SPIM
* SPIM version tested on: 9.1.20

## Known issues
* The mult_big function can produce an incorrect result if the value of the big integer in register $a1 > $a0
* e.g. 
```
    mult_big(1764, 42) = 74088     [Correct]
    mult_big(42, 1764) = 414088    [Wrong]
```
* This parameter ordering is accounted for in pow_big, the only place where mult_big is called with two disjoint values with a significant difference in size. As a result, as long as the correct parmeter ordering is preserved, the rest of the program is not affected by this issue. 