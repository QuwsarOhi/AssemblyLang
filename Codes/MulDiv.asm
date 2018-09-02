.STACK 100H
.DATA

A DW 2
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
        DIV BX              ; (DX:AX)/BX = REMAINDER : DX, QUOTENT : AX
        
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
    
    ; 8 BIT MULTIPLICATION
    ;MOV CX, A
    ;MOV AX, B
    ;MUL CL           ; AX = CL * AL     [OUTPUT IS 16 BIT, INPUTS ARE 8 BIT]
    
    ; PRINT OUTPUT
    ;MOV P, AX
    ;CALL PRINTVAL
    
    ; 16 BIT MULTIPLICATION
    MOV AX, A       ; SUPPOSE A AND B IS DW
    MOV BX, B
    MUL BX          ; DX:AX = BX*AX     [OUTPUT IS 32 BIT, FIRST 16 BIT CONTAINS DX, SECOND 16 BIT CONTAINS AX]
    
    MOV TMP, AX
    
    ; PRINT DX
    MOV P, DX
    CALL PRINTVAL
    ; PRINT AX
    MOV AX, TMP
    MOV P, AX
    CALL PRINTVAL
    
    
    
    MAIN ENDP
END MAIN