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
jz halt
int 0x10
jmp .loop
halt:
cli
hlt
jmp halt
msg db 13,10,'ASINAT IMMORTAL OS',13,10,'PRANA: Active',13,10,'Gen: 1 - On-Chain Proof Stored',13,10,0
times 510-($-$$) db 0
dw 0xAA55
