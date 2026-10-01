# ASINAT OS - MORTAL
### First Self-Evolving Bare-Metal OS [Human-Triggered Evolution]

> OS that proves it can evolve before we let it evolve on its own.

**This is the MORTAL version. Evolution needs your command. See IMMORTAL version for autonomous evolution.**

### What is ASINAT OS?

ASINAT (Autonomous Self-Improving Native Attested Technology) is a bare-metal OS written in C. It doesn't run on Linux. It IS the OS.

Every boot, it hashes itself, signs its telemetry, and if you command it, it rewrites its own `boot.bin` to become faster.

From `asinat.c`:

```c
// ASINAT-001 Self-Declaration
hash = hash_block(BLACK) // self-hash every boot

// ASIN-001 Self-Evolve Logic
Boot #1 = 250ms, every boot -25ms -> Boot Crisis if <110ms

// Signed Telemetry
telemetry = get_telemetry() // pressure_bar * 250 + boot_count
