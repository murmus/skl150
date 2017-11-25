
CFILES=test.c

test: $(CFILES) threads.asm
	nasm -f elf64 threads.asm
	gcc -o test threads.o $(CFILES) -pthread
