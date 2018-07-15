.DATA                       ; Data Segment

val1 DB '1'                 ; Initialized 1byte variable (As ascii value)
val2 DW ?                   ; Uninitialized 2byte variable
str DB 'ABCD$'              ; Initialized a string
inStr DB 21,0,22 dup('$')   ; Initializing a 20 size DB array with all containing '$'

.CODE                       ; Code Segment


MAIN PROC
    ; Moving data segment to data segment register
    MOV AX, @DATA
    MOV DS, AX              ; DS is the data segment register
    
    ; Printing Value of val1 (1byte)
    MOV AH, 2H              ; Passing 2nd Subroutine(Print) to AH
    MOV DL, val1            ; Passing 1byte value to the lower 1byte Data register
    INT 21H                 ; Running subroutine of AH                                                      
    
    ; Printing NEW-LINE
    MOV AH, 2H
    MOV DL, 0AH
    INT 21H
    
    ; Taking input of a 2byte value
    MOV AH, 1H              ; Passing 1st Subroutine(Input) to AH
    INT 21H                 ; Running subroutine of AH
    MOV val2, AX            ; Passing the input value (Contained by AX) to val2
    
    ; Printing NEW-LINE
    MOV AH, 2H
    MOV DL, 0AH
    INT 21H                 ; Running subroutine of AH
    
    ; Printing Value of val2 (2byte)
    MOV AH, 2H
    MOV DX, val2            ; Passing 2byte value to 16 byte DX register
    INT 21H                 ; Running subroutine of AH
    
    ; Printing NEW-LINE
    MOV AH, 2H
    MOV DL, 0AH
    INT 21H                 ; Running subroutine of AH
    
    
    ; Printing String 
    LEA DX, str
    MOV AH, 9H
    INT 21H
    
    ; Printing NEW-LINE
    MOV AH, 2H
    MOV DL, 0AH
    INT 21H                 ; Running subroutine of AH    
    
    ; Input String
    ;MOV AH, 10H             ; 10H procedure might not be supported by some emulators
    ;LEA DX, inStr
    ;INT 21H
    
    ; Printing String 
    LEA DX, inStr
    MOV AH, 9H
    INT 21H
     
    MAIN ENDP
END MAIN
    
    