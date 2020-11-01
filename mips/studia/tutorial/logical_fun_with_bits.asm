## Program to add two plus three 
        .text
        .globl  __start

__start:
	ori   $t0, $zero, 0xf00
	srl   $t1, $t0, 4
	or    $t2, $t1, $t0
	and   $t3, $t1, $t2
        xor   $t4, $t2, $t3
        nor   $t5, $t4, $zero  # not $t4

	ori   $t6, $zero, 0xffff
	sll   $t6, $t6, 8
	ori   $t7, $zero, 0xffff
	multu $t6, $t7
	mfhi  $t0
	mflo  $t1
    
## End of file
