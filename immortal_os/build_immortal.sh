#!/bin/bash
set -x
rm -f *.o *.bin immortal.elf immortal.img
nasm -f bin boot.asm -o boot.bin
echo "boot done"
gcc -m32 -ffreestanding -c immortal.c -o immortal.o -nostdlib
echo "gcc done"
ld -m elf_i386 -T linker.ld -o immortal.elf immortal.o -nostdlib
echo "ld done"
objcopy -O binary immortal.elf immortal.bin
cat boot.bin immortal.bin > immortal.img
truncate -s 1474560 immortal.img
ls -lh immortal.img
echo "BUILD SUCCESS - NOW BOOTING"
qemu-system-x86_64 -fda immortal.img
