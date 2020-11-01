# Probujemy wywolac procedure!
	.text
	.globl __start

proc:
	ori $t1, $zero, 14
	jr $ra

__start:
	ori $t0, $zero, 1
	ori $t1, $zero, 4
	jal proc
	ori $t2, $zero, 5
	