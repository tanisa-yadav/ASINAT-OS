.text
.global _start
_start:
    ldr sp, =0x00010000
    bl asinat_main
1: b 1b

