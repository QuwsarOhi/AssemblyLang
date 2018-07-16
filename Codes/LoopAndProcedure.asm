.DATA
I DB ?
LIM DB ?
STR DB 'LOOP WORKING $'

.CODE

MAIN PROC    
    ; DATA SEGMENT 
    MOV AX, @DATA
    MOV DS, AX
    
    ; LOOP : FOR(I = 0; I < LIM; ++I)
    MOV I, 0
    MOV LIM, 10
    
    LOOP1:
    MOV AL, LIM
    CMP I, AL               ; LOOP COMPARISON IS DONE HERE 
    JGE BREAKLOOP1
    
    ; THE WORKS IN EACH ITERATION SHOULD BE DONE HERE
    ; -----------------------------------------------
    
    CALL LOOPSTRING
    
    ; PRINTING VALUE OF I
    MOV AH, 2
    MOV DL, I
    ADD DL, '0'
    INT 21H
    
    CALL NEWLINEPRINT
    
    ; -----------------------------------------------
    ; INCREMETN I AND GO BACK TO LOOP
    INC I                   ; INCREMENT LOOP COUNTER I BY 1
    JMP LOOP1               ; GO BACK TO LOOP
    
    
    BREAKLOOP1:             ; AFTER THE LOOP BREAKS, CODE WILL START FROM HERE
    JMP TOEND               ; IF JUMP IS NOT USED, THE IP WILL RUN THE NEXT PROCEDURES UNNECESSARY
    
    ; SELF DECLARED PROCEDURES START HERE
    
    NEWLINEPRINT PROC       ; SELF-DACLARED PROCEDURE
        ; NEW LINE
        MOV AH, 2
        MOV DL, 13
        INT 21H
        MOV DL, 10
        INT 21H
        RET                 ; IF RET IS USED, THEN THE IP WILL RETURN TO THE PREVIOUS PROCEDURE
        NEWLINEPRINT ENDP   


    LOOPSTRING PROC         ; SELF-DACLARED PROCEDURE
        LEA DX, STR
        MOV AH, 9H          ; IF RET IS USED, THEN THE IP WILL RETURN TO THE PREVIOUS PROCEDURE
        INT 21H
        RET
        LOOPSTRING ENDP   

    
    ; ENDING MAIN PROCEDURE
    TOEND:                  ; IF MAIN IS NOT ENDED IP MIGHT ROAM TO GARBAGE
    END MAIN                ; END MAIN MUST END AT LAST, OTHERWISE DATA SEGMENT FROM OTHER PROCEDURE WON'T BE VISIBLE



; MORE REFERENCES:
; http://www.shsu.edu/~csc_tjm/spring2001/cs272/ch4b.html
; https://stackoverflow.com/questions/28665528/while-do-while-for-loops-in-assembly-language-emu8086