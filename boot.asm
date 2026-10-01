[org 0x7c00]
[bits 16]
start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 3
    mov dh, 0
    mov bx, 0x7E00
    mov dl, 0
    int 0x13
    mov ax, [0x7E00]
    cmp ax, 0
    jg valid
    mov ax, 0
valid:
    inc ax
    mov [0x7E00], ax
    mov ah, 0x03
    mov al, 1
    mov ch, 0
    mov cl, 3
    mov dh, 0
    mov bx, 0x7E00
    mov dl, 0
    int 0x13
    mov ah, 0x02
    mov al, 10
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov bx, 0x1000
    mov es, bx
    xor bx, bx
    int 0x13
    jmp 0x1000:0x0000
times 510-($-$$) db 0
dw 0xAA55
