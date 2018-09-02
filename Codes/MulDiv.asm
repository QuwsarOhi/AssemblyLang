.STACK 100H
.DATA

A DW -2
B DW 2
P DW ?
I DW ?
TMP DW ?
REM DW ?
QUO DW ?

.CODE

NEWLINE PROC
    ; NEW LINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H   
    ; CURSOR RESET
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    RET


PRINTVAL PROC               ; INPUT VALUE IS IN P
    MOV CX, 0               ; USING CL AS STACK COUNTER
    
    LOOP1:
        MOV AX, P
        MOV DX, 0
        MOV BX, 10D
        IDIV BX              ; (DX:AX)/BX = REMAINDER : DX, QUOTENT : AX
        
        INC CX           
        ;MOV REM, DX
        ;MOV QUO, AX
        
        PUSH DX
        CMP AX, 0
        JE PRINT
        MOV P, AX
        JMP LOOP1
    
    PRINT:
        POP DX
        DEC CX
        ADD DX, '0'
        
        MOV AH, 2
        INT 21H
        CMP CX, 0
        JNE PRINT
        
    ;CALL NEWLINE
    RET
    
    
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX    
    
    ; MULTIPLICATION UNSUGNED  : MUL
    ; MULTIPLICATION SIGNED    : IMUL
    
    ; 8 BIT MULTIPLICATION [UNSIGNED]
    ;MOV CX, A
    ;MOV AX, B
    ;MUL CL           ; AX = CL * AL     [OUTPUT IS 16 BIT, INPUTS ARE 8 BIT]
    
    ; PRINT OUTPUT
    ;MOV P, AX
    ;CALL PRINTVAL
    ;CALL NEWLINE
    
    ; 16 BIT MULTIPLICATION
    MOV AX, A       ; SUPPOSE A AND B IS DW
    MOV BX, B
    IMUL BX          ; DX:AX = BX*AX     [OUTPUT IS 32 BIT, FIRST 16 BIT CONTAINS DX, SECOND 16 BIT CONTAINS AX]
    
    MOV TMP, AX
    
    CMP DX, 0
    JL NEGMULPRINT
    NEGMULPRINT:
        MOV P, DX
        
        ; PRINT SIGN
        MOV AH, 2H
        MOV DL, '-'
        INT 21H
        
        NEG P
        NEG TMP
        ; 2'S COMPLEMENT OF FFFF IS 1 WHICH IS NOT ALWAYS TRUE, SO WE WOULD IGNORE IF DX HAS 1       
        CMP P, 1
        JNE CALL PRINTVAL       ; PRINT DX
        MOV DX, TMP
        MOV P, DX
        CALL PRINTVAL       ; PRINT AX
        JMP ENDLINE
       
    POSMULPRINT: 
        ; PRINT DX
        MOV P, DX
        CALL PRINTVAL
        ; PRINT AX
        MOV AX, TMP
        MOV P, AX
        CALL PRINTVAL
    
    ENDLINE:
    
    
    MAIN ENDP
END MAIN



; MAKING POSITIVE VALUE NEGATIVE : https://stackoverflow.com/questions/40516205/converting-a-negative-number-to-a-positive-number-in-assembly-x86