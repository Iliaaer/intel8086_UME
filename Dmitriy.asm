ORG 100h

;array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 0F6D7h, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh
;array DW 0cf30h, 03828h, 041D9h, 05B63h, 058A8h, 0D60Fh, 0157Ah, 099c0h, 04c35h, 0f0e7h, 016d3h, 01c9eh
;array DW 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h, 00005h
;array DW 00000h, 00003h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h 
;array DW 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h, 00002h  
array DW 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h, 00018h

even_counter DW 0
even_index_arr DW 0
even_address_arr DW 00010h

even_avg_result DW 00090h
even_avg_index_arr DW 0
    
odd_m5_counter DW 0
odd_m5_index_arr DW 0
odd_m5_address_arr DW 00050h  

start:
    MOV SI, 0
    MOV BP, 0
    MOV CX, 12
    MOV BX, 5
    OUTPUT:
        MOV AX, array[SI]
        TEST AX, 1
        JNZ ODD
        JZ EVEN
    ODD:
        MOV DX, 0
        TEST AX, 08000h
        JZ POZITIVE_AX
        MOV DX, 0FFFFh
        POZITIVE_AX:
            IDIV BX
            CMP DX, 0
            JNE NO_MULTI_5
            INC [odd_m5_counter]
            MOV AX, array[SI]
            MOV BP, [odd_m5_address_arr] 
            MOV DI, [odd_m5_index_arr]
            MOV [BP + DI], AX
            ADD [odd_m5_index_arr], 2
            NO_MULTI_5:
                ADD SI, 2
    LOOP OUTPUT
    JCXZ SORT_ARR
    EVEN:
         MOV BP, [even_address_arr]
         MOV DI, [even_index_arr]
         MOV [BP + DI], AX
         ADD SI, 2
         INC [even_counter]
         ADD [even_index_arr], 2
    LOOP OUTPUT
    JCXZ SORT_ARR
    
 SORT_ARR:
 MOV AX, [odd_m5_counter]
 CMP AX, 0
 JE ODD_SORT_EXIT
 MOV [00001h], AX
 DEC [00001h]
 MOV BX, 0
 MOV BP, [odd_m5_address_arr]
 ODD_SORT:
    CMP BX, [00001h]
    JGE ODD_SORT_EXIT
    MOV CX, [00001h] 
    SUB CX, BX
    MOV SI, 0
    MOV DX, 0
    ODD_RPT_SORT:
        MOV DI, [BP+SI+2]
        TEST DI, 08000h
        JZ SCND_POZITIVE_ODD
        NEG DI
        SCND_POZITIVE_ODD:
        MOV AX, [BP+SI] 
        TEST AX, 08000h
        JZ FRST_POZITIVE_ODD
        NEG AX                 
        FRST_POZITIVE_ODD:
        CMP AX, DI
        JNB NO_SWAP_ODD          
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      
        MOV [BP+SI], AX         
        MOV DX, 1
        NO_SWAP_ODD:
            ADD SI, 2
            LOOP ODD_RPT_SORT
    INC BX
    CMP DX, 0
    JE ODD_SORT_EXIT
    JMP ODD_SORT
    
 ODD_SORT_EXIT:
 MOV AX, [even_counter]
 CMP AX, 0
 JE EVEN_SORT_EXIT
 MOV [00001h], AX 
 DEC [00001h]                    
 MOV BX, 0                       
 MOV BP, [even_address_arr]     
 EVEN_SORT:
    CMP BX, [00001h]            
    JGE EVEN_SORT_EXIT          
    MOV CX, [00001h]            
    SUB CX, BX                  
    MOV SI, 0                   
    MOV DX, 0                   
    EVEN_RPT_SORT:
        MOV DI, [BP+SI+2]
        TEST DI, 08000h
        JZ SCND_POZITIVE_EVEN
        NEG DI
        SCND_POZITIVE_EVEN:
        MOV AX, [BP+SI] 
        TEST AX, 08000h
        JZ FRST_POZITIVE_EVEN              
        NEG AX                 
        FRST_POZITIVE_EVEN:
        CMP AX, DI
        JNA NO_SWAP_EVEN         
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      
        MOV [BP+SI], AX         
        MOV DX, 1               
        NO_SWAP_EVEN:
            ADD SI, 2               
            LOOP EVEN_RPT_SORT     
    INC BX                      
    CMP DX, 0                   
    JE EVEN_SORT_EXIT
    JMP EVEN_SORT
            
 EVEN_SORT_EXIT:
 MOV SI, 0
 MOV BP, [even_address_arr]
 MOV DI, [even_avg_result]
 MOV CX, [even_counter]
 MOV BX, CX
 MOV w. [DI], 00000h
 MOV w. [DI+2], 00000h 
 CMP CX, 0
 JE EXIT_AVG_VALUE
 
 AVG_ARRAY_LOOP:
    MOV AX, [BP + SI] 
    MOV DX, 0
    TEST AX, 08000h                 
    JZ NO_NEGATIVE_IDIV 
    MOV DX, 0FFFFh                  
    NO_NEGATIVE_IDIV:   
        IDIV BX 
        ADD [DI],   AX 
        ADD [DI+2], DX 
        ADD SI, 2 
    LOOP AVG_ARRAY_LOOP
    MOV AX, [DI+2]
    MOV DX, 0 
    TEST AX, 08000h                 
    JZ NO_NEGATIVE_IDIV_2 
    NEG AX                 
    NO_NEGATIVE_IDIV_2:   
        IDIV BX 
        TEST [DI], 08000h
        JZ NO_NEGATIVE_IDIV_3 
        NEG AX                 
    NO_NEGATIVE_IDIV_3: 
        ADD [DI],   AX  
        MOV [DI+2], DX 
    EXIT_AVG_VALUE:
HLT  

;array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 0F6D7h, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh
 