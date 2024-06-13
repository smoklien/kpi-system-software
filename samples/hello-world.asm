.386

DATA SEGMENT USE16
    MESG DB 'Hello world','$'
DATA ENDS

CODE SEGMENT USE16
         ASSUME CS:CODE,DS:DATA
    BEG: 
         MOV    AX,DATA            ; Load data segment address into AX
         MOV    DS,AX              ; Set DS (data segment) register to AX

         MOV    DX, OFFSET MESG

         MOV    AH, 9              ; Function 9 (print string) for INT 21h
         INT    21h                ; Interrupt 21h (DOS services), execute function

         MOV    AH, 4Ch            ; Function 4Ch (terminate program) for INT 21h
         INT    21h                ; Terminate the program
CODE ENDS

END BEG