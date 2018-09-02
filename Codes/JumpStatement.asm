.DATA
LESS DB ' IS LESS THAN OR EQUAL 5$'
GREATER DB ' IS GREATER THAN 5$'   


.CODE 
    MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX    
        
    MOV AH,1
    INT 21H
    MOV BL,AL
    SUB BL,30H
        
    MOV AH,2
    MOV DL,0AH
    INT 21H
    
    MOV AH, 2
    MOV DL,0DH
    INT 21H 
    
    CMP BL,5
    JLE PRINTLESS
    
    MOV AH,2
    MOV DL,BL
    ADD DL,30H
    INT 21H
    LEA DX,GREATER
    MOV AH,9
    INT 21H
    JMP LAST
        
    PRINTLESS:
    MOV AH,2
    MOV DL,BL
    ADD DL,30H
    INT 21H
    LEA DX,LESS
    MOV AH,9
    INT 21H
    
    LAST:
    MAIN ENDP
END MAIN