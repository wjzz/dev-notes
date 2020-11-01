# Program pobiera dwie liczby z konsoli i je dodaje
	.text
	.globl __start
__start:
	li 	$v0, 5
	syscall
	or	$t0, $zero, $v0
	li 	$v0, 5
	syscall
	add	$t0, $t0, $v0
	li	$v0, 1
	or	$a0, $zero, $t0
	syscall