# ASINAT - The Immortal OS on Solana

First bare-metal x86 OS that stores its boot heartbeat on Solana.

- Boots on QEMU: `qemu-system-i386 -drive format=raw,file=immortal.img`
- Message: "ASINAT IMMORTAL OS / PRANA: Active"
- Next: Each boot will call Solana program `log_boot` on devnet to store generation + slot
- Vision: DePIN OS where hardware death doesn't matter, Solana remembers last state

## Run
nasm -f bin boot.asm -o immortal.img
qemu-system-i386 -drive format=raw,file=immortal.img

## Solana Program (WIP)
programs/immortal-sol/src/lib.rs - Anchor program to log boot proof

Colosseum Infra Track 2026
