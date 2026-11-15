#!/bin/bash
set -e
nasm -f bin boot.asm -o boot.bin
clang --target=i386-pc-none-elf -ffreestanding -m32 -fno-builtin -nostdlib -c immortal.c -o immortal.o
ld.lld -T linker.ld -o immortal.elf immortal.o
llvm-objcopy -O binary immortal.elf immortal.bin
cat boot.bin immortal.bin > immortal.img
ls -lh immortal.img
qemu-system-i386 -fda immortal.img
