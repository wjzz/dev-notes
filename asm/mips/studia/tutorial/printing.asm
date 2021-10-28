	.text
	.globl __start
__start:
	li $v0, 1
	li $a0, 5
	syscall
	li $a0, 0xff
	syscall