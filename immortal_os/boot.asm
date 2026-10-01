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
    mov si, msg_boot
    call print
    mov ah, 0x02
    mov al, 20
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov bx, 0x1000
    int 0x13
    jc disk_error
    jmp 0x0000:0x1000

disk_error:
    mov si, msg_err
    call print
    hlt

print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10
    jmp print
.done: ret

msg_boot db 13,10,'ASINAT IMMORTAL Booted! Proof-of-Boot Mining Started...',13,10,0
msg_err db 'DISK FAIL - Cannot resurrect',0

times 510-22-($-$$) db 0
immortal_sig: db 'IMMORTAL'       ; Signature
stage_marker: db 'C100',0        ; Will become C200
boot_count_marker: dw 2          ; Your video shows 2, starts from here
prev_hash_marker: db 'GENESIS_HASH_0000'
dw 0xaa55
