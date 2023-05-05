C_SOURCES = $(wildcard src/kernel/*.c)
OBJ = ${C_SOURCES:.c=.o}

all: kernel

run: all
	qemu-system-x86_64 out/kernel

kernel : out/boot_sec.bin out/kernel.bin
	cat $^ > out/kernel

kernel.bin : out/kernel_entry.o ${OBJ}
	@mkdir -p out
	ld -o out/$@ -Ttext 0x1000 $^ --oformat binary -m elf_i386

kernel_entry.o : src/kernel/kernel_entry.asm
	nasm $< -f elf -o out/$@

%.o : %.c
	gcc -fno-pie -ffreestanding -m32 -c $< -o $@

out/boot_sec.bin : src/boot/boot_sec.asm
	nasm $< -f bin -I 'include/asm' -o $@

clean:
	rm -rf *.bin *.o *.dis *.map kernel

kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
