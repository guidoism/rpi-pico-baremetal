        .cpu cortex-m0
        .thumb
        
        LDR     r0,=0x20001000 
        MOV     sp,r0
        BL      ntmain 
done:   B       done
put32:  STR     r1,[r0]
        BX      lr
get32:  LDR     r0,[r0]
        BX      lr
delay:  SUB     r0,#1
        BNE     delay 
        BX      lr
ntmain: PUSH    {r4,lr}
        MOVS    r1,#32
        LDR     r0,=0x4000f000 
        BL      put32 
        MOVS    r4,#32
loop1:  LDR     r0,=0x4000c008 
        BL      get32 
        TST     r4,r0
        BEQ     loop1 
        LDR     r0,=0xd0000028 
        LDR     r1,=0x2000000
        BL      put32 
        LDR     r0,=0xd0000018 
        LDR     r1,=0x2000000
        BL      put32 
        MOVS    r1,#5
        LDR     r0,=0x400140cc 
        BL      put32 
        LDR     r0,=0xd0000024 
        LDR     r1,=0x2000000
        BL      put32 
loop2:  LDR     r0,=0xd0000014 
        LDR     r1,=0x2000000
        BL      put32 
        LDR     r0,=0x20000
        BL      delay 
        LDR     r0,=0xd0000018 
        LDR     r1,=0x2000000
        BL      put32 
        LDR     r0,=0x100000
        BL      delay 
        B       loop2 
        NOP                     

