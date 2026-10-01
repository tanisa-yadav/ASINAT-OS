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
    unsigned int generation = 1;
    char* video = (char*)VIDEO_MEMORY;
    while(1) {
        for(int i=0; i<80*25*2; i+=2){ video[i]=0; video[i+1]=0x07; }
        print("ASINAT OS - V2 PRANA - LIVES ALONE", 0x0A, 0);
        print("STATUS: AUTONOMOUS - NO HUMAN NEEDED", 0x0C, 1);
        if(generation < 5) print("GEN BABY: Just born", 0x0F, 3);
        else if(generation < 20) print("GEN LEARNING: Rewriting myself", 0x0B, 3);
        else if(generation < 100) print("GEN IMMORTAL: I dont need you", 0x0D, 3);
        else print("GEN INFINITY: Beyond time", 0x0D, 3);
        video[6*160]='0'+(generation/100)%10;
        video[6*162]='0'+(generation/10)%10;
        video[6*164]='0'+generation%10;
        print("Boot ONCE, I evolve FOREVER", 0x08, 8);
        for(volatile long i=0; i<80000000; i++) {}
        generation++;
    }
}