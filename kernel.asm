[org 0x0000]
[bits 16]
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00
mov ax, 0x0003
int 0x10
mov si, m1
call print
mov si, m2
call print
main:
mov si, prompt
call print
xor ah, ah
int 0x16
mov ah, 0x0e
int 0x10
mov al, 13
int 0x10
mov al, 10
int 0x10
cmp al, 'f'
je fuel
jmp main
fuel:
mov ax, 0x0003
int 0x10
mov si, f1
call print
mov si, f2
call print
mov si, f3
call print
mov si, f4
call print
mov si, f5
call print
mov si, f6
call print
xor ah, ah
int 0x16
jmp main
print:
lodsb
test al, al
jz done
mov ah, 0x0e
xor bh, bh
int 0x10
jmp print
done: ret
m1: db "ASINAT IMMORTAL OS BOOTED", 13, 10, 0
m2: db "Press F = FUEL TANK ANALYZER", 13, 10, 0
prompt: db "> ", 0
f1: db "ROCKET FUEL TANK ANALYZER", 13, 10, 0
f2: db "LOX  [##########------] 65% OK", 13, 10, 0
f3: db "RP-1 [############----] 78% OK", 13, 10, 0
f4: db "LH2  [#######---------] 45% LOW", 13, 10, 0
f5: db "PRESSURE: 210 PSI - NORMAL", 13, 10, 0
f6: db "STATUS: GO FOR LAUNCH", 13, 10, 0
