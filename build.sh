mkdir Unosh/ -p
mkdir Unosh/boot/ -p
nasm src/loader.asm -f elf32 -o obj/loader.o
gcc -m32 -c -ffreestanding src/idt.c -o obj/idt.o 
gcc -m32 -c -ffreestanding src/isr.c -o obj/isr.o 
gcc -m32 -c -ffreestanding src/kb.c -o obj/kb.o 
gcc -m32 -c -ffreestanding src/screen.c -o obj/screen.o
gcc -m32 -c -ffreestanding src/string.c -o obj/string.o
gcc -m32 -c -ffreestanding src/system.c -o obj/system.o
gcc -m32 -c -ffreestanding src/util.c -o obj/util.o
gcc -m32 -c -ffreestanding src/shell.c -o obj/shell.o
gcc -m32 -c -ffreestanding src/kernel.c -o obj/kernel.o
sudo ld -m elf_i386 -T src/link.ld obj/loader.o obj/kernel.o obj/idt.o obj/isr.o obj/kb.o obj/screen.o obj/string.o obj/system.o obj/util.o obj/shell.o -o Unosh/boot/kernel.bin
sudo chown $USER  Unosh/boot/kernel.bin
rm Unosh/boot/grub/ -r -f
mkdir Unosh/boot/grub/
echo set default=0 >> Unosh/boot/grub/grub.cfg
echo set timeout=0 >> Unosh/boot/grub/grub.cfg
echo menuentry "Unosh" { >> Unosh/boot/grub/grub.cfg
echo         set root='(hd96)' >> Unosh/boot/grub/grub.cfg
echo         multiboot /boot/kernel.bin >> Unosh/boot/grub/grub.cfg
echo	     module /programs/hello-world >> Unosh/boot/grub/grub.cfg
echo } >> Unosh/boot/grub/grub.cfg
grub-mkrescue -o Unosh.iso Unosh/
