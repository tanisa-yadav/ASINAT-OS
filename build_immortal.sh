#!/bin/bash
cd "$(dirname "$0")"
echo "boot done"
nasm -f bin boot.asm -o boot.bin
clang --target=i386-pc-none-elf -ffreestanding -m32 -fno-builtin -nostdlib -c immortal.c -o immortal.o
python3 << 'PY'
import struct
f=open('immortal.o','rb').read()
# ELF 32-bit parser - linker ki zaroorat nahi
e_shoff=struct.unpack('<I', f[32:36])[0]
e_shentsize,e_shnum,e_shstrndx=struct.unpack('<HHH', f[46:52])
secs=[]
for i in range(e_shnum):
    off=e_shoff+i*e_shentsize
    name,typ,flags,addr,offset,size=struct.unpack('<IIIIII', f[off:off+24])
    secs.append((name,typ,flags,addr,offset,size))
# shstrtab se naam nikalo
shstr=secs[e_shstrndx]
def getname(n):
    s=shstr[4]+n
    e=f.find(b'\x00',s)
    return f[s:e].decode()
out=bytearray()
base=None
for s in secs:
    nm=getname(s[0])
    if nm in ('.text','.rodata','.data'):
        if base is None: base=s[3]
        off=s[3]-base
        if len(out)<off+s[5]: out.extend(b'\x00'*(off+s[5]-len(out)))
        out[off:off+s[5]]=f[s[4]:s[4]+s[5]]
        print(nm, 'ok')
open('immortal.bin','wb').write(out)
print('immortal.bin ban gaya:', len(out), 'bytes')
PY
cat boot.bin immortal.bin > immortal.img
ls -lh immortal.img
qemu-system-i386 -fda immortal.img
