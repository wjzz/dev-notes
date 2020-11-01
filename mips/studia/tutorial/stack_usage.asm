# Program, ktory probuje manipulowac stosem
	.text
	.globl __start

__start:
	ori	$t0, $zero, 15
	ori     $t1, $zero, 7
	ori	$t2, $zero, 4
	sub	$sp, $sp, $t2
	sw      $t0, ($sp)
	sub     $sp, $sp, $t2
	sw	$t1, ($sp)
	lw	$t3, ($sp)
	add     $sp, $sp, $t2
	lw	$t4, ($sp)
	add	$sp, $sp, $t2