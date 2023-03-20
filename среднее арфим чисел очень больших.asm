
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

;array DW 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh, 07FFBh
;array DW 004D2h, 0162Eh, 02334h, 00D80h, 0E12Eh, 0F6D7h, 01538h, 02694h, 010E1h, 0223Dh, 0F7C3h, 0E58Bh
;array DW 0DDDDh, 0BCDAh, 0BCDFh, 012A3h, 0574Fh, 00000h, 01357h, 08888h, 01337h, 04488h, 0228Ch, 0DEF1h
array DW 0FFFFh, 00000h, 08000h, 00001h, 04000h, 0C000h, 0F000h, 00FFFh, 08FFFh, 08765h, 01122h, 0FFFFh       
 
count_value_3 DW 0           
addres_value_sum_3 DW 00070h 
addres_avg_value DW 00080h     
addres_array_avg_value_3 DW 00050h  
index_array_avg_value_3 DW 0


MOV SI, 0                       
MOV BP, [addres_array_avg_value_3]    
MOV CX, 12                       
MOV BX, 3    
lea ax, array                    
AVG_OUTPUT:   
    MOV AX, array[SI]            
    MOV DX, 0                    
    TEST AX, 08000h              
    JZ NO_NEGATIVE               
    MOV DX, 0FFFFh               
    NO_NEGATIVE:
    IDIV BX                      
    CMP DX, 0                                          
    JNE NO_SUM3                  
    INC [count_value_3]          
    MOV AX, array[SI]       
    MOV DI, [index_array_avg_value_3]
    MOV [BP+DI], AX
    ADD [index_array_avg_value_3], 2                 
    NO_SUM3:
    ADD SI, 2                    
LOOP AVG_OUTPUT

MOV SI, 0                       
MOV BP, [addres_array_avg_value_3]  
MOV DI, [addres_avg_value]    
MOV CX, [count_value_3]                       
MOV BX, CX
MOV w. [DI], 00000h
MOV w. [DI+2], 00000h    
AVR_ARRAY_LOOP:
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
LOOP AVR_ARRAY_LOOP 

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


HLT    

ret

     array DW 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h, 0FFF4h 



