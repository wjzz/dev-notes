## Program to add two plus three 
        .text
        .globl  __start

__start:
	ori	$t0, $zero, 121
	ori	$t1, $zero, 10
	divu    $t0, $t1
	mflo	$t2
	sra     $t3, $t2, 2
	srl     $t4, $t2, 2
    
## End of file
