NASM = nasm -g -f elf

OBJECTS = printf.o main.o

printf: link_printf
	gdb ./_test/bin/main

link_printf: main.o printf.o
	ld -m elf_i386 -o _test/bin/main _test/obj/main.o printf/obj/printf.o

printf.o: printf/src/printf.asm
	$(NASM) printf/src/printf.asm -o printf/obj/printf.o

#$(OBJECTS): printf/src/printf.asm
#	$(NASM) printf/src/printf.asm -o printf/obj/printf.o

main.o: _test/src/main.asm
	$(NASM) _test/src/main.asm -o _test/obj/main.o

