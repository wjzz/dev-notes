compile:
	nasm -f macho64 hello.asm

link:
	gcc -m64 hello.o

test:
	./a.out; echo $?
