#include <stdint.h>
#define DNA_SIZE 64
volatile uint32_t dna_log[DNA_SIZE] = {0};
volatile uint32_t boot_count = 0;
volatile uint32_t prev_block_hash = 0;

#ifndef BOOT_NUM
#define BOOT_NUM 1
#endif
#ifndef PREV_HASH_STR
#define PREV_HASH_STR "0x00000000"
#endif
#ifndef NEW_HASH_STR
#define NEW_HASH_STR "0x1E30E0B1"
#endif

void print_uart(const char *s){ volatile unsigned int *U = (unsigned int*)0x101f1000; while(*s){*U=*s++;} }
void print_dec(uint32_t n){ char b[12]; int i=0; if(n==0){print_uart("0");return;} uint32_t t=n; while(t){i++; t/=10;} b[i]='\0'; while(n){b[--i]='0'+n%10; n/=10;} print_uart(b); }

void asinat_main(){
    dna_log[0]=BOOT_NUM;
    boot_count=BOOT_NUM;
    print_uart("\n==============================\n");
    print_uart("ASINAT OS Booting... Boot #");
    print_dec(BOOT_NUM);
    print_uart("\n[ARES-DNA] dna_log[0]=");
    print_dec(dna_log[0]);
    print_uart(" | Boot Time: 1100ms | 42KB\n");
    print_uart("[STANDENT] P=208 (20.8 bar)\n");
    print_uart("[BLOCK #");
    print_dec(BOOT_NUM-1);
    print_uart("] Hash: ");
    print_uart(NEW_HASH_STR);
    print_uart(" Prev: ");
    print_uart(PREV_HASH_STR);
    print_uart("\n-> Solana DePIN\n");
    print_uart("==============================\n");
    while(1){}
}
