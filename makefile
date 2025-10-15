NASM = nasm -g -f elf32

#OBJECTS = printf_s.o main.o

printf_s: link_printf_s
	./_test/bin/main

link_printf_s: main.o printf_s.o
	ld -m elf_i386 -o _test/bin/main _test/obj/main.o printf_s/obj/printf_s.o

printf_s.o: printf_s/src/printf_s.asm
	$(NASM) printf_s/src/printf_s.asm -o printf_s/obj/printf_s.o

#$(OBJECTS): printf_s/src/printf_s.asm
#	$(NASM) printf_s/src/printf_s.asm -o printf_s/obj/printf_s.o

main.o: _test/src/main.asm
	$(NASM) _test/src/main.asm -o _test/obj/main.o

compile_main_c: printf_s.o
	gcc -m32 -c _test/src/main.c -o _test/obj/main_c.o

link_main_printf_s: compile_main_c
	gcc -m32 _test/obj/main_c.o printf_s/obj/printf_s.o -o _test/bin/main_c

printf_s_c: link_main_printf_s
	./_test/bin/main_c

#clean:
#	rm _test/bin/main && \
#	rm _test/obj/main.o && \
#	rm _test/bin/main_c && \
#	rm _test/obj/main_c.o && \
#	rm print_i32/bin/print_i32 && \
#	rm print_i32/obj/print_i32.o && \
#	rm printf_s/bin/printf_s && \
#	rm printf_s/obj/printf_s.o
