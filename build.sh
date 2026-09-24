#!/bin/bash
COUNT=$(cat boot_count.txt 2>/dev/null || echo 0)
COUNT=$((COUNT+1))
echo $COUNT > boot_count.txt

PREV_HASH=$(cat last_hash.txt 2>/dev/null || echo "0x00000000")
NEW_HASH=$(printf "0x%X" $((0x1E30E0B1 + COUNT * 111)))

echo ">>> Building ASINAT OS - Boot #$COUNT | Prev: $PREV_HASH"

arm-none-eabi-gcc -mcpu=arm926ej-s -nostdlib -ffreestanding -DBOOT_NUM=$COUNT -DPREV_HASH_STR="\"$PREV_HASH\"" -DNEW_HASH_STR="\"$NEW_HASH\"" -c asinat.c -o asinat.o
arm-none-eabi-gcc -mcpu=arm926ej-s -nostdlib -ffreestanding -c boot.s -o boot.o
arm-none-eabi-ld -T linker.ld boot.o asinat.o -o asinat.elf
echo $NEW_HASH > last_hash.txt

echo ">>> Booting in QEMU..."
qemu-system-arm -M versatilepb -m 128M -nographic -kernel asinat.elf
