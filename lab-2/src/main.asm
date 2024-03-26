.model small

.stack 100h

.data
    start_message db 'Enter your number: '

.code

printMsg proc
                  mov  ax, @data           ; Load data segment address into AX
                  mov  ds, ax              ; Set DS (data segment) register to AX
    ; -------------------------------------
    ; print whole word
    ;    lea  dx, start_message    ; Load effective address of start_message into DX

    ;    mov  ah, 9                ; Function 9 (print string) for INT 21h
    ;    int  21h                  ; Interrupt 21h (DOS services), execute function
    ; -------------------------------------
                  mov  ah,02h              ; Function 2 (print character) for INT 21h

                  lea  di,start_message
                  mov  cx, 19
    printCh:      mov  dl,[di]
                  int  21h                 ; Interrupt 21h (DOS services), execute function
                  inc  di
    ; -------------------------------------
    ; delay
                  mov  bx,32768
    dummy_process:
                  dec  bx
                  push bx
                  pop  bx
                  jnz  dummy_process
    ; -------------------------------------
                  loop printCh


                  mov  ah, 4Ch             ; Function 4Ch (terminate program) for INT 21h
                  int  21h                 ; Terminate the program
printMsg endp

end printMsg
