printf: link_printf
	gdb ./_test/bin/main

link_printf: main.o printf.o
	ld -m elf_i386 -o _test/bin/main _test/obj/main.o printf/obj/printf.o

printf.o: printf/src/printf.asm
	nasm -f elf printf/src/printf.asm -o printf/obj/printf.o

main.o: _test/src/main.asm
	nasm -f elf _test/src/main.asm -o _test/obj/main.o

