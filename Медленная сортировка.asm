
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h   
 
 
MOV [00270h], 00Ch

MOV SI, 0             
MOV BP, 0       
MOV AX, 0
MOV BX, 0      
MOV CX, 0
MOV DX, 0
LOOP_START:
    CMP BX, [00270h] 
    JGE EXIT_SORT
    MOV CX, [00270h]
    SUB CX, BX
    MOV AX, 2
    MUL BX
    MOV SI, AX
    MOV AX, 0
    MOV BP, SI
    ADD BP, 2
    
    LOOP_SORT:
        CMP SI, BP
        JE NEXT_VALUE
        MOV AX, array[SI]
        CMP AX, array[BP] 
          
        JL NO_SWAP
        XCHG AX, array[BP]
        MOV array[SI], AX         
        NO_SWAP:
        NEXT_VALUE:
        ADD BP, 2
        LOOP LOOP_SORT
    INC BX
    JMP LOOP_START 
     

EXIT_SORT:

hlt
ret

 array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh, 0F6D7h

;array DW 0, 1, -4, 4, -1

END
