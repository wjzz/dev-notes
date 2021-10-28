# Compiling a small assembly file on OS X

## Tools

`brew install nasm`

## Minimal assembly file

```
; tiny.asm
GLOBAL _main
SECTION .text
_main:
    mov     eax, 42
    ret
```

## Compile

```
nasm -f macho64 hello.asm
```

## Link

```
gcc -m64 hello.o
```

## Execute

```
./a.out; echo $?
42
```
