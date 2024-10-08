; ��� ������� �� 12 16-��������� ����� �� ������ 
; ����������� ����-����� ���������, ��������� �� ����� ���������� 
; � � �������� ����� ��������������� �1810��86, 
; ������� ��������� ������ ���� �� ������ � ��������. 
; � �����:
; ����������� ������ ����� � ������� �������� ������,
; ����������� �������� ����� � ������� ����������� ������,
; ������������ ������� �������������� ���� �����, ������� 3.

; http://www.avprog.narod.ru/progs/emu8086/8086_instruction_set.html
 
 
ORG 100h                     ; ��������� ����� ���������

array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 0F6D7h, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh
;array DW 0DDDDh, 0BCDAh, 0BCDFh, 012A3h, 0574Fh, 00000h, 01357h, 08888h, 01337h, 04488h, 0228Ch, 0DEF1h
;array DW 0FFFFh, 00000h, 08000h, 00001h, 04000h, 0C000h, 0F000h, 00FFFh, 08FFFh, 08765h, 01122h, 0FFFFh       
                       
count_even DW 0              ; ���������� ������ ���������
addres_array_even DW 00010h  ; ����� ��� ������ ������ ���������
index_array_even DW 0        ; ������ �������� ��n���� �������� �������
                
count_odd DW 0               ; ���������� �������� ���������
addres_array_odd DW 00030h   ; ����� ��� ������ �������� ��������� 
index_arrar_odd DW 0         ; ������ �������� ��������� �������� �������

count_value_3 DW 0           ; ���������� �����, ������� ������� �� 3
addres_value_sum_3 DW 00070h ; ����� ��� ������ ����� �����      
addres_array_avg_value_3 DW 00050h  
index_array_avg_value_3 DW 0
 
start:                
    MOV SI, 0             ; ������ �������� �������� �������
    MOV BP, 0             ; ����� ������ �������  
    MOV CX, 12            ; ���������� �������� � �������     
    OUTPUT:   
        MOV AX, array[SI] ; �������� ����� ��� �������� � ������� AX 
        TEST AX, 1        ; �������� �� ��������
        JNZ NUMBER_ODD    ; �������, ���� ����� ��������   (ZF=0)
        JZ NUMBER_EVEN    ; �������, ���� ����� ������ (ZF=1)          

    NUMBER_ODD:                     ; ���� ����� ������
         MOV DI, [index_arrar_odd]  ; ���������� � DI �������� ������� ������� ��� ������
         MOV BP, [addres_array_odd] ; ���������� � BP ������ ������� ��� ������ 
         MOV [BP+DI], AX            ; ���������� ������� ����� � �������   
         ADD SI, 2                  ; ������� � ���������� �������� �������
         INC [count_odd]            ; ���������� ���������� ������ �����  
         ADD [index_arrar_odd], 2   ; ����������� ������ ���� �������� ������� ��� ������
    LOOP OUTPUT                     ; ��������� � ����� OUTPUT ���� CX != 0
    JCXZ NEXT_ARRAY_SORT        ; ���� CX = 0, �� ���� ������
      
    NUMBER_EVEN:                     ; ���� ����� ��������
         MOV DI, [index_array_even]  ; ���������� � DI �������� ������� ������� ��� ��������
         MOV BP, [addres_array_even] ; ���������� � BP ������ ������� ��� ��������   
         MOV [BP+DI], AX             ; ���������� ������� ����� � �������   
         ADD SI, 2                   ; ������� � ���������� �������� �������
         INC [count_even]            ; ���������� ���������� ������ �����  
         ADD [index_array_even], 2   ; ����������� ������ ���� �������� ������� ��� ��������
    LOOP OUTPUT                      ; ��������� � ����� OUTPUT ���� CX != 0 
    JCXZ NEXT_ARRAY_SORT         ; ���� CX = 0, �� ���� ������

NEXT_ARRAY_SORT:
; ===============================     
; SORT ARRAY ODD
; ===============================

MOV AX, [count_odd]    
MOV [00001h], AX 
DEC [00001h]                    ; ������� � ������, ���������� �������� �����
MOV BX, 0                       ; ������� ������� �����
MOV BP, [addres_array_odd]      ; ����� �������
LOOOP_START_ODD:
    CMP BX, [00001h]            ; ���������� ������� �������
    JGE EXIT_SORT_ODD           ; ���� ������� ����� �� �������������� �������, �� �����
    MOV CX, [00001h]            ; ������ � ������� ���������� ���������
    SUB CX, BX                  ; �������� �� �������� ���������� ��������� ������� ������
    MOV SI, 0                   ; ������ �������� �������� 
    MOV DX, 0                   ; ����, ������� ����� ����� ����� ���� ������������ ��� ��� 
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
                
        JNAE NO_SWAP_ODD        ; ���� �������� ������ ��� �����, �� ���������� ������������
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      ; ������ ������� ��� ��������
        MOV [BP+SI], AX         ; ������� ��������
        MOV DX, 1               ; ������ �������� 1, ������ ������������ ����
        NO_SWAP_ODD:
        ADD SI, 2               ; ���������� � ������� 2, ����� ������� � ���� ��������
        LOOP LOOP_SORT_ODD      ; ���� CX �� ����������, ������� � LOOP_SORT_ODD
    INC BX                      ; ��������� � �������� �������� 1 LOOP_SORT_ODD
    CMP DX, 0                   ; ���� �� ���� ������������, �� ������ ������������, � ����� �����
    JE EXIT_SORT_ODD
    JMP LOOOP_START_ODD         ; ������� � LOOOP_START_ODD 
EXIT_SORT_ODD:

;
; ===============================     
; SORT ARRAY EVEN
; ===============================
      
MOV AX, [count_even]    
MOV [00001h], AX 
DEC [00001h]                    ; ������� � ������, ���������� ������ �����
MOV BX, 0                       ; ������� ������� �����
MOV BP, [addres_array_even]      ; ����� �������
LOOOP_START_EVEN:
    CMP BX, [00001h]            ; ���������� ������� �������
    JGE EXIT_SORT_EVEN          ; ���� ������� ����� �� �������������� �������, �� �����
    MOV CX, [00001h]            ; ������ � ������� ���������� ���������
    SUB CX, BX                  ; �������� �� �������� ���������� ��������� ������� ������
    MOV SI, 0                   ; ������ �������� �������� 
    MOV DX, 0                   ; ����, ������� ����� ����� ����� ���� ������������ ��� ���
    
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
 
        JNBE NO_SWAP_EVEN         ; ���� �������� ������ ��� �����, �� ���������� ������������ 
        MOV AX, [BP+SI]
        XCHG AX, [BP+SI+2]      ; ������ ������� ��� ��������
        MOV [BP+SI], AX         ; ������� ��������
        MOV DX, 1               ; ������ �������� 1, ������ ������������ ����
        NO_SWAP_EVEN:
        ADD SI, 2               ; ���������� � ������� 2, ����� ������� � ���� ��������
        LOOP LOOP_SORT_EVEN     ; ���� CX �� ����������, ������� � LOOP_SORT_EVEN
    INC BX                      ; ��������� � �������� �������� 1 LOOP_SORT_EVEN
    CMP DX, 0                   ; ���� �� ���� ������������, �� ������ ������������, � ����� �����
    JE EXIT_SORT_EVEN
    JMP LOOOP_START_EVEN        ; ������� � LOOOP_START_EVEN 
EXIT_SORT_EVEN:

; ��� ��������
; ===============================     
; AVG VALUE 3
; ===============================  
MOV SI, 0                        ; ������ �������� �������� �������
MOV BP, [addres_array_avg_value_3]     ; ����� ��� ��������� ����� ��������  
MOV CX, 12                       ; ���������� �������� � �������  
MOV BX, 3                        ; ����� � BX ��� ��������    
AVG_OUTPUT:   
    MOV AX, array[SI]            ; �������� ����� ��� �������� � ������� AX 
    MOV DX, 0                    ; ������� ������� DX
    TEST AX, 08000h              ; ��������� ����� ������������� ��� ���
    JZ NO_NEGATIVE               ; ���� �������������, �� ����������
    MOV DX, 0FFFFh               ; ��������� � DX -1, ����� DX:AX ���� �������������
    NO_NEGATIVE:
    IDIV BX                      ; ����� DX:AX �� BX(3)
    CMP DX, 0                    ; ��������� ���� �� ������� ��� ���
                       
    JNE NO_SUM3                  ; ���� ������� ����, �� ���������� �����, ��� ������� �����
    INC [count_value_3]          ; ���������� ������� �������   
    MOV DI, [addres_value_sum_3] ; ���������� ����� ������, � ������� ����� ��������� ����� ���� ����� ������� ������� �� 3
    MOV AX, array[SI]            ; �������� ����� ��� �������� � ������� AX
    ADD [DI], AX                 ; ��������� ����� ����� � ������ ���� ����� ���� ����� ������� ������� �� 3 
    MOV DI, [index_array_avg_value_3]
    MOV [BP+DI], AX
    ADD [index_array_avg_value_3], 2
    NO_SUM3:
    ADD SI, 2                    ; ������� � ���������� �������� ������ 
LOOP AVG_OUTPUT
    
        
MOV AX, 0                       ; �������� ��������
MOV BX, 0                       ; �������� ��������
MOV BP, [addres_value_sum_3]    ; ���������� � BP ����� ��� ��������� ��� ����� ��������
MOV AX, [BP]                    ; ���������� � AX �������� �� ������ 
MOV DX, 0  

TEST AX, 08000h                 ; ��������� ����� ������������� ��� ���
JZ NO_NEGATIVE_IDIV             ; ���� �������������, �� ����������
MOV DX, 0FFFFh                  ; ��������� � DX -1, ����� DX:AX ���� �������������
NO_NEGATIVE_IDIV: 

MOV BX, [count_value_3]         ; ���������� � BX ���������� ���� ��������
CMP BX, 0                       ; ���������� ���������� � �����
JE NO_IDIV_AVG                  ; ���� ���������� = 0, �� ���������� ������� (�� ���� ������ ������)
IDIV BX                         ; ����� ����� ���� �������� �� ����������
NO_IDIV_AVG:

HLT    
END

