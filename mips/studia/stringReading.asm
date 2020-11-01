    .text
    .globl  __start
__start:
    li      $v0, 8
    la      $a0, theString
    li      $a1, 5
    syscall
    li      $v0, 4
    la      $a0, theString
    syscall
    li      $v0, 4
    la      $a0, theString
    syscall
    
    la      $t0, theString
    lbu     $a0, 0($t0)
    li      $v0, 1
    syscall

    .data
theString:
    .space 5