run_printf:
	gdb ./_test/bin/main

printf: _test/src/main.asm printf/src/printf.asm _test/obj/main.o printf/obj/printf.o
	ld -m elf_i386 -o _test/bin/main _test/obj/main.o printf/obj/printf.o
	nasm -f elf _test/src/main.asm -o _test/obj/main.o
	nasm -f elf printf/src/printf.asm -o printf/obj/printf.o
