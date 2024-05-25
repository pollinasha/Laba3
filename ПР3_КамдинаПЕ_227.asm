data segment

Y1 DB ? 
Y2 DB ? 
A DB ? 
X DB ?
Y DB ? 
PERENOS DB 13,10,"$" 
VVOD_A DB 13,10,"VVEDITE A=$" 
VVOD_X DB 13,10,"VVEDITE X=$",13,10
VIVOD_Y DB "Y=$"
pkey db "press any key...$"

code segment

XOR AX, AX
    MOV DX, OFFSET VVOD_A
    MOV AH, 9
    INT 21H
    
   SLED2:
    MOV AH, 1
    INT 21H
    CMP AL, "-"
    JNZ SLED1
    MOV BX, 1
    JMP SLED2
    
   SLED1:
    SUB AL, 30H
    TEST BX, BX
    JZ SLED3
    NEG AL
   
   SLED3:
    MOV A, AL
    XOR AX, AX
    XOR BX, BX
    
    MOV DX, OFFSET VVOD_X
    MOV AH, 9
    INT 21H
    
   SLED4:
    MOV AH,1 
    INT 21H
    CMP AL, "-"
    JNZ SLED5
    MOV BX, 1
    JMP SLED4
    
   SLED5:
    SUB AL, 30H
    TEST BX, BX 
    JZ SLED6
    NEG AL     
    
   SLED6:
    MOV X, AL
    
    CMP AL, 2
    JG @BOLSHE_Y1
    MOV bl, X
    MOV AL, 2
    IMUL bl
    INC AL
    JMP @VIXOD_Y1
   @BOLSHE_Y1:
    MOV AL,2
    MOV BL, X
    IMUL BL
    ADD AL, A
   @VIXOD_Y1:
    MOV Y1, AL
    
    MOV AL, X
    CMP AL, 0
    JG @BOLSHE_Y2
    MOV AL, A
    DEC AL
    JMP @VIXOD_Y2
   @BOLSHE_Y2:
    MOV AL, X
    INC AL
   @VIXOD_Y2:
    MOV Y2, AL
    
    MOV AL, Y1
    SUB AL, Y2
    MOV Y, AL
    
    MOV DX, OFFSET PERENOS
    MOV AH, 9
    INT 21H
    
    MOV DX, OFFSET VIVOD_Y
    MOV AH, 9
    INT 21H
    
    MOV AL, Y
    CMP Y, 0
    JGE SLED7
    
    NEG AL
    MOV BL, AL
    MOV DL, "-"
    MOV AH, 2
    INT 21H
    MOV DL, BL
    ADD DL, 30H
    INT 21H
    JMP SLED8
    
   SLED7:
    MOV DL, Y
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    
   SLED8:
    MOV DX, OFFSET PERENOS
    MOV AH, 9
    INT 21H