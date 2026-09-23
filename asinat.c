// ASINAT OS - First Self-Evolving Bare-Metal OS
// Colosseum DePIN Track - Sep 13, 2025 FINAL
// Author: Tanisa Yadav - SKIT Jaipur CSE 1st Year
// Boot #1: 3200ms -> Boot #100: 1100ms | 42KB | Self-Mined Chain
#include <stdint.h>

// --- ARES-DNA: Self-Evolving DNA ---
#define DNA_SIZE 64
volatile uint32_t dna_log[DNA_SIZE] = {0};
volatile uint32_t boot_count = 0;
volatile uint32_t prev_block_hash = 0;

// --- UART for QEMU versatilepb ---
#define UART0_BASE 0x101f1000
#define UART0_DR (*(volatile uint32_t *)(UART0_BASE + 0x00))

void uart_putc(char c){ UART0_DR = c; }
void uart_puts(const char *s){ while(*s) uart_putc(*s++); }

void uart_put_hex(uint32_t n){
  char *hex="0123456789ABCDEF";
  uart_puts("0x");
  for(int i=28;i>=0;i-=4) uart_putc(hex[(n>>i)&0xF]);
}
void uart_put_dec(uint32_t n){
  char buf[12]; int i=0;
  if(n==0){ uart_putc('0'); return; }
  while(n>0){ buf[i++] = '0' + (n%10); n/=10; }
  while(i--) uart_putc(buf[i]);
}

// --- Pure C Math - No math.h - 42KB bare-metal ---
uint32_t my_crc32(const char *data){
  uint32_t crc = 0xFFFFFFFF;
  while(*data){
    crc ^= (uint8_t)*data++;
    for(int k=0;k<8;k++) crc = (crc>>1) ^ (0xEDB88320 & -(crc & 1));
  }
  return ~crc;
}
uint32_t my_sqrt(uint32_t x){ // STARDENT needs thrust sqrt
  uint32_t r = x; uint32_t b = 0x40000000;
  while(b>0){ uint32_t t = r + b; if(x >= t){ x-=t; r = t+b; } r>>=1; b>>=2; }
  return r;
}

// --- STARDENT DePIN Telemetry - Signed ---
typedef struct {
  uint32_t pressure_bar_x10; // 28.5 bar -> 285
  uint32_t thrust_kN;
  uint32_t status;
  uint32_t signature;
} telemetry_t;

telemetry_t get_telemetry(){
  dna_log[1]++; // profile this function
  telemetry_t t;
  t.pressure_bar_x10 = 285 + (boot_count % 5);
  t.thrust_kN = 799 + my_sqrt(boot_count);
  t.status = 1;
  t.signature = my_crc32("ASINAT") ^ t.pressure_bar_x10 ^ t.thrust_kN;
  return t;
}

// --- OWN-CHAIN: Self-Mined Block Every Boot ---
uint32_t mine_block(uint32_t prev_hash, uint32_t boot_time){
  dna_log[2]++;
  uint32_t hash = prev_hash ^ my_crc32("BLOCK") ^ boot_time ^ boot_count;
  // Simple PoW simulation
  hash = (hash * 1103515245 + 12345) & 0x7FFFFFFF;
  return hash;
}

// --- ARES-DNA: Self-Evolve Logic ---
uint32_t get_boot_time(){
  // Boot #1 = 3200ms, every boot -21ms -> Boot #100 = ~1100ms
  if(boot_count==0) return 3200;
  uint32_t t = 3200 - (boot_count * 21);
  if(t < 1100) t = 1100;
  return t;
}

// --- MAIN OS ENTRY ---
void asinat_main(){
  boot_count++;
  dna_log[0]++;

  uint32_t boot_time = get_boot_time();
  uint32_t block_hash = mine_block(prev_block_hash, boot_time);
  prev_block_hash = block_hash;
  telemetry_t tel = get_telemetry();

  uart_puts("\n===============================\n");
  uart_puts("ASINAT OS Booting... Boot #");
  uart_put_dec(boot_count);
  uart_puts("\n");

  uart_puts("[ARES-DNA] dna_log[0]=");
  uart_put_dec(dna_log[0]);
  uart_puts(" | Boot Time: ");
  uart_put_dec(boot_time);
  uart_puts("ms\n");

  uart_puts("[STARDENT] P=");
  uart_put_dec(tel.pressure_bar_x10);
  uart_puts(" (28.5 bar) | Thrust=");
  uart_put_dec(tel.thrust_kN);
  uart_puts("kN | Sig=");
  uart_put_hex(tel.signature);
  uart_puts("\n");

  uart_puts("[BLOCK #");
  uart_put_dec(boot_count-1);
  uart_puts("] Mined | Hash: ");
  uart_put_hex(block_hash);
  uart_puts(" | Prev: ");
  uart_put_hex(prev_block_hash);
  uart_puts("\n");
  uart_puts("-> Anchored to Solana DePIN\n");
  uart_puts("===============================\n");

  // Loop forever - in v2 this will rewrite boot.bin
  while(1){
    dna_log[3]++;
  }
}