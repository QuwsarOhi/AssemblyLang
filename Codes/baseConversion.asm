.STACK 100H
.DATA

REM DW ?
A DW ?
B DW ?
C DW ?
VAL DW ?
QUO DW ?
TMP DW ?

BASEARR DW 30 DUP(?)

.CODE


DIVI PROC                   ; DOES A/B, REM, QUO
    MOV DX, 0
    MOV AX, A
    MOV BX, B
    IDIV BX
    
    MOV REM, DX
    MOV QUO, AX
    RET  
    

MULTI PROC                  ; DOES A*B = C
    MOV AX, A
    MOV BX, B
    IMUL BX
    
    MOV C, AX
    RET


INPUTVAL PROC               ; TAKES INPUT IN A
    MOV VAL, 0
    MOV SI, 0               ; SI = 1 IF VALUE IS NEGATIVE
    
    INPUTLOOP:
        MOV AH, 1
        INT 21H

        CMP AL, 0DH          ; IF INPUT IS NEWLINE
        JE BREAKINPUT
        
        MOV AH, 0
        MOV CX, AX        
        
        ; MULTIPLY VAL WITH 10
        MOV AX, VAL
        MOV BX, 10D
        IMUL BX
        MOV VAL, AX

        CMP CX, '-'          ; IF INPUT IS NEGATIVE
        JNE NOTNEG
        
        MOV SI, 1
        JMP INPUTLOOP
        
        NOTNEG:
        
        SUB CX, '0'
        ADD VAL, CX
        
        MOV CX, VAL
        
        JMP INPUTLOOP        
    
    BREAKINPUT:
        CMP SI, 1
        JNE BREAKINPUTFINAL
        NEG VAL
        BREAKINPUTFINAL:
        RET




NEWLINE PROC                ; OUTPUTS NEW LINE
    ; NEW LINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H   
    ; CURSOR RESET
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    RET




PRINTVAL PROC               ; INPUT VALUE IS IN VAL
    MOV CX, 0               ; USING CL AS STACK COUNTER
    CMP VAL, 0
    JGE LOOP1
    
    ; INPUT IS NEGATIVE
    MOV AH, 2
    MOV DL, '-'
    INT 21H
    NEG VAL
    
    
    LOOP1:
        MOV AX, VAL
        MOV DX, 0
        MOV BX, 10D
        IDIV BX              ; (DX:AX)/BX = REMAINDER : DX, QUOTENT : AX
        
        INC CX           
        ;MOV REM, DX
        ;MOV QUO, AX
        
        PUSH DX
        CMP AX, 0
        JE PRINT
        MOV VAL, AX
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


INITBASECHAR PROC                   ; INITIALIZES THE OUTPUT CHARECHTERS IN ARRAY
    MOV SI, 0
    
    INITBASECHARLOOP1:
        MOV AX, 'A'
        ADD AX, SI
        MOV BASEARR[SI], AX         ; BASEARR CONTAINS A, B, C, D, E, .... Z
        INC SI
        CMP SI, 26
        JNE INITBASECHARLOOP1
    RET    


CONVBASECHAR PROC                   ; RETURNS THE OUTPUT CHARECTER OF BASE VALUE                   
    CMP TMP, 9                      ; VALUES ARE PASSED BY TMP VARIABLE
    JLE DIG
    
    MOV SI, TMP
    SUB SI, 10
    MOV AX, BASEARR[SI]
    MOV TMP, AX
    RET
    
    DIG:
        ADD TMP,'0'
    RET


CONVERTBASE PROC                   ; CONVERTS VALUE A TO B BASE VALUE STORED IN C
    MOV VAL, 0                     ; VAL CONTAINS THE SIZE OF CONVERTED VALUE
                                   ; FIRST RUN CONVBASECHAR
    CONVERTLOOP:
        MOV AX, A
        MOV DX, 0D
        MOV BX, B
        IDIV BX
        
        MOV A, AX
        MOV TMP, DX
        CALL CONVBASECHAR
        
        PUSH TMP
        INC VAL
            
        CMP A, 0D
        JNE CONVERTLOOP
    
    PRINTBASE:
        POP DX
        DEC VAL
        
        MOV AH, 2
        INT 21H
        CMP VAL, 0
        JNE PRINTBASE
    RET
    


MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    CALL INPUTVAL
    MOV AX, VAL
    CALL NEWLINE
    CALL PRINTVAL
    
    
    MAIN ENDP
END MAIN