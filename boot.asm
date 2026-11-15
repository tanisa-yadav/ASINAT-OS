[org 0x7c00]
[bits 16]
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00
mov ax, 0x1000
mov es, ax
xor bx, bx
mov ah, 0x02
mov al, 20
mov ch, 0
mov cl, 2
mov dh, 0
int 0x13
jmp 0x1000:0x0000
times 510-($-$$) db 0
dw 0xAA55
