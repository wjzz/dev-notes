# Program oblicza liczby fibonacciego

	.text
	.globl __start
__start:
	# Pierwsze dwa wyrazy
	ori 	$t0, $zero, 0
	ori 	$t1, $zero, 1
loop:
	add     $t2, $t1, $t0
	or      $t0, $t1, $zero
	or      $t1, $t2, $zero
	j loop