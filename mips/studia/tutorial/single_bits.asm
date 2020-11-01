	.text
	.globl __start
# program przechodzi przez poszczegolne bity slowa i anduje pojedyncze bity
__start:
	ori	$t0, $zero, 0xf0f0
	sll     $t1, $t0, 16
	add     $t1, $t1, $t0   # w t1 sa wszystkie bity rowne 1
	ori	$t0, $zero, 1   # maska z dokladnie jednym bitem rownym 1
	ori     $t3, $zero, 1   # licznik
	ori     $t4, $zero, 32  # wartosc, ktorej nie moze przekroczyc licznik
loop:   beq     $t3, $t4, endlp
	and     $t2, $t1, $t0
	addi    $t3, $t3, 1
        sll     $t0, $t0, 1
	j loop
endlp:  
