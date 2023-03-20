ORG 100h                     

array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 0F6D7h, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh
;array DW 0DDDDh, 0BCDAh, 0BCDFh, 012A3h, 0574Fh, 00000h, 01357h, 08888h, 01337h, 04488h, 0228Ch, 0DEF1h
;array DW 0FFFFh, 00000h, 08000h, 00001h, 04000h, 0C000h, 0F000h, 00FFFh, 08FFFh, 08765h, 01122h, 0FFFFh       
;array DW 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh

;[0x0010] - с этой €чейки начинаетс€ массив четных чисел.
;[0x0030] - с этой €чейки начинаетс€ массив нечетных чисел.
;[0x0050] - с этой €чейки начинаетс€ массив чисел кратных 3.
;[0x0070] - €чейка дл€ записи суммы чисел кратных 3.
;[0x0080] - €чейка дл€ записи среднего арифметического всех чисел кратных 3.
;[0x0082] - €чейка дл€ записи остатка среднего арифметиче-ского всех чисел кратных 3.

                     
count_even DW 0              
addres_array_even DW 00010h  
index_array_even DW 0        
                
count_odd DW 0               
addres_array_odd DW 00030h   
index_arrar_odd DW 0         

count_value_3 DW 0           
addres_value_sum_3 DW 00070h 
addres_avg_value DW 00080h     
addres_array_avg_value_3 DW 00050h  
index_array_avg_value_3 DW 0
 
start:                
    MOV SI, 0           
    MOV BP, 0           
    MOV CX, 12
    MOV BX, 3              
    OUTPUT:   
        MOV AX, array[SI] 
        MOV DX, 0
        TEST AX, 08000h
        JZ NO_NEGATIVE_AX
        MOV DX, 0FFFFh
        NO_NEGATIVE_AX:
        IDIV BX 
        CMP DX, 0
        JNE NO_IDIV3
        INC [count_value_3]
        MOV AX, array[SI]  
        MOV BP, [addres_array_avg_value_3]     
        MOV DI, [index_array_avg_value_3]
        MOV [BP+DI], AX
        ADD [index_array_avg_value_3], 2
        NO_IDIV3:
        MOV AX, array[SI]
        TEST AX, 1        
        JNZ NUMBER_ODD    
        JZ NUMBER_EVEN            
    NUMBER_ODD:                   
         MOV DI, [index_arrar_odd] 
         MOV BP, [addres_array_odd] 
         MOV [BP+DI], AX            
         ADD SI, 2                  
         INC [count_odd]            
         ADD [index_arrar_odd], 2   
    LOOP OUTPUT                     
    JCXZ NEXT_ARRAY_SORT        
    NUMBER_EVEN:                
         MOV DI, [index_array_even]  
         MOV BP, [addres_array_even] 
         MOV [BP+DI], AX             
         ADD SI, 2                   
         INC [count_even]            
         ADD [index_array_even], 2   
    LOOP OUTPUT                      
    JCXZ NEXT_ARRAY_SORT         
NEXT_ARRAY_SORT:
; ===============================     
; SORT ARRAY ODD
; ===============================
MOV AX, [count_odd]
CMP AX, 0
JE EXIT_SORT_ODD      
MOV [00001h], AX 
DEC [00001h]                    
MOV BX, 0                       
MOV BP, [addres_array_odd]      
LOOOP_START_ODD:
    CMP BX, [00001h]            
    JGE EXIT_SORT_ODD           
    MOV CX, [00001h]            
    SUB CX, BX                  
    MOV SI, 0                   
    MOV DX, 0                   
    MOV DI, 0
    LOOP_SORT_ODD:     
        MOV DI, [BP+SI+2]
        TEST DI, 08000h
        JZ NO_NEGATIVE_WORD2_ODD
        NEG DI
        NO_NEGATIVE_WORD2_ODD:
        MOV AX, [BP+SI] 
        TEST AX, 08000h
        JZ NO_NEGATIVE_WORD1_ODD              
        NEG AX                 
        NO_NEGATIVE_WORD1_ODD:
        CMP AX, DI
        JNA NO_SWAP_ODD          
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      
        MOV [BP+SI], AX         
        MOV DX, 1               
        NO_SWAP_ODD:
        ADD SI, 2               
        LOOP LOOP_SORT_ODD      
    INC BX                      
    CMP DX, 0                   
    JE EXIT_SORT_ODD
    JMP LOOOP_START_ODD         
EXIT_SORT_ODD:  
; ===============================     
; SORT ARRAY EVEN
; ===============================  
   
MOV AX, [count_even]
CMP AX, 0
JE EXIT_SORT_EVEN    
MOV [00001h], AX 
DEC [00001h]                    
MOV BX, 0                       
MOV BP, [addres_array_even]     
LOOOP_START_EVEN:
    CMP BX, [00001h]            
    JGE EXIT_SORT_EVEN          
    MOV CX, [00001h]            
    SUB CX, BX                  
    MOV SI, 0                   
    MOV DX, 0                   
    LOOP_SORT_EVEN:
        MOV DI, [BP+SI+2]
        TEST DI, 08000h
        JZ NO_NEGATIVE_WORD2_EVEN
        NEG DI
        NO_NEGATIVE_WORD2_EVEN:
        MOV AX, [BP+SI] 
        TEST AX, 08000h
        JZ NO_NEGATIVE_WORD1_EVEN              
        NEG AX                 
        NO_NEGATIVE_WORD1_EVEN:
        CMP AX, DI
        JNB NO_SWAP_EVEN         
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      
        MOV [BP+SI], AX         
        MOV DX, 1               
        NO_SWAP_EVEN:
        ADD SI, 2               
        LOOP LOOP_SORT_EVEN     
    INC BX                      
    CMP DX, 0                   
    JE EXIT_SORT_EVEN
    JMP LOOOP_START_EVEN        
EXIT_SORT_EVEN:   
; ===============================     
; AVG VALUE 3
; ===============================   
MOV SI, 0                       
MOV BP, [addres_array_avg_value_3]  
MOV DI, [addres_avg_value]    
MOV CX, [count_value_3]                       
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