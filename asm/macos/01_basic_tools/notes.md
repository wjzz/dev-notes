# Assembly on Macos with GCC

## Normal build

```sh
$ gcc -W -Wall -pedantic -std=c99 -o hello hello.c
```

### File format

```
$ file hello
hello: Mach-O 64-bit executable x86_64
```

## Check text

```sh
$ strings hello
```

## Output assembly (AT&T syntax)

```sh
$ gcc -S hello.c
```

### Example output

```asm
        .section        __TEXT,__text,regular,pure_instructions
        .build_version macos, 11, 0     sdk_version 11, 0
        .globl  _main                   ## -- Begin function main
        .p2align        4, 0x90
_main:                                  ## @main
        .cfi_startproc
## %bb.0:
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        subq    $32, %rsp
        movl    $0, -4(%rbp)
        movl    %edi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        leaq    L_.str(%rip), %rdi
        movb    $0, %al
        callq   _printf
        xorl    %ecx, %ecx
        movl    %eax, -20(%rbp)         ## 4-byte Spill
        movl    %ecx, %eax
        addq    $32, %rsp
        popq    %rbp
        retq
        .cfi_endproc
                                        ## -- End function
        .section        __TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
        .asciz  "Hello, world!\n"

.subsections_via_symbols
```

## Output assembly (Intel syntax)

```sh
$ gcc -masm=intel -S hello.c
```

### Example output

```
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 0
	.intel_syntax noprefix
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	mov	dword ptr [rbp - 4], 0
	mov	dword ptr [rbp - 8], edi
	mov	qword ptr [rbp - 16], rsi
	lea	rdi, [rip + L_.str]
	mov	al, 0
	call	_printf
	xor	ecx, ecx
	mov	dword ptr [rbp - 20], eax ## 4-byte Spill
	mov	eax, ecx
	add	rsp, 32
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Hello, world!\n"

.subsections_via_symbols
```

## Dissambly

### AT&T syntax

```sh
objdump -d hello
objdump -D hello # show all sections
```

The intel syntax seems not to be available on Mac.
