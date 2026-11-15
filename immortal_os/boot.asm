[bits 16]
[org 0x7c00]
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

mov si, msg
mov ah, 0x0E
.loop:
lodsb
test al, al
jz load_kernel
int 0x10
jmp .loop

load_kernel:
mov ax, 0x1000
mov es, ax
xor bx, bx
mov ah, 0x02
mov al, 30
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0
int 0x13
jc load_kernel

cli
in al, 0x92
or al, 2
out 0x92, al

lgdt [gdt_desc]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp 0x08:0x10000

msg db 13,10,'ASINAT IMMORTAL OS - Loading...',13,10,0
gdt_start:
dq 0
dq 0x00cf9a000000ffff
dq 0x00cf92000000ffff
gdt_end:
gdt_desc:
dw gdt_end - gdt_start - 1
dd gdt_start
times 510-($-$$) db 0
dw 0xAA55
