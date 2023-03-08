
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h   
 
 
MOV [00270h], 00Ch  ; размер массива 
MOV [00272h], 00Ch
DEC [00272h]

MOV SI, 0           ; текущий элемент индекс  
MOV BP, 0       
MOV AX, 0           ; элемент массива 
MOV BX, 0           ; счетчик внешнего цикла 
MOV CX, 0           ; счетчик внутренего цикла
MOV DX, 0           ; флаг была перестановка или нет


LOOP_START:
    CMP BX, [00272h] 
    JGE EXIT_SORT
    MOV CX, [00272h]
    SUB CX, BX
    MOV SI, 0
    MOV DX, 0 
    
    LOOP_SORT:
        MOV AX, array[SI]
        CMP AX, array[SI+2] 
          
        JL NO_SWAP
        XCHG AX, array[SI+2]
        MOV array[SI], AX
        MOV DX, 1         
        NO_SWAP:
        NEXT_VALUE:
        ADD SI, 2
        LOOP LOOP_SORT
    INC BX
    CMP DX, 0
    JE EXIT_SORT
    
    JMP LOOP_START 
     

EXIT_SORT:

hlt
ret

array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh, 0F6D7h

;array DW 0, 1, -4, 4, -1

END
