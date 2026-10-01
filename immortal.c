__asm__(".code16gcc\n");
#define VIDEO_MEMORY 0xB8000
void print(char* str, int color, int row) {
    char* video = (char*)VIDEO_MEMORY;
    int offset = row * 160;
    for(int i=0; str[i]!=0; i++) {
        video[offset + i*2] = str[i];
        video[offset + i*2 + 1] = color;
    }
}
void kmain() {
    unsigned int* gen_ptr = (unsigned int*)0x7E00;
    unsigned int generation = *gen_ptr;
    char* video = (char*)VIDEO_MEMORY;
    for(int i=0; i<80*25*2; i+=2){ video[i]=0; video[i+1]=0x07; }
    print("ASINAT OS - V1 SMRITI - REMEMBERS", 0x0A, 0);
    print("STATUS: DISK-MUTATING IMMORTAL", 0x0E, 1);
    if(generation == 1) print("GEN 1: BIRTH", 0x0C, 3);
    else if(generation < 10) print("GEN: I remember past boots", 0x0B, 3);
    else print("GEN: IMMORTAL 10+ lives", 0x0D, 3);
    video[6*160]='0'+(generation/10)%10; video[6*161]=0x0E;
    video[6*162]='0'+generation%10; video[6*163]=0x0E;
    print("Reboot QEMU to evolve - I remember you", 0x08, 8);
    while(1){ __asm__ volatile("hlt"); }
}