.8086
.model small

.stack 100h

.data
    header_msg          db 10, '--- Multiplier by 2 ---', 10, 10, 13, '$'
    prompt_msg          db 'Enter your number (from -32 768 to 32 767): $'
    result_msg          db 'Result is: $'
    overflow_err_msg    db 'Error: Overflow happened.', 10, 13, '$'
    non_int_err_msg     db 'Error: You have entered non-integer value.', 10, 13, '$'
    incorrect_input_msg db 'Error: Incorrect input number.', 10, 13, '$'
    new_line            db 10, 13, "$"

    buffer              db 7, ?, 7 dup (?)
    num                 dw 0
    minus_sign          db 0

.code
    start:                 
                           mov  ax, DGROUP
                           mov  ds, ax

    ; print header
                           lea  dx, header_msg
                           call print_line

    ; read number
                           call process_number


    ; print result
                           lea  dx, new_line
                           call print_line
                           lea  dx, result_msg
                           call print_line
                           call print_number

    ; terminate program
                           mov  ax, 4c00h
                           int  21h

print_line proc
                           mov  ah, 09h
                           int  21h
                           ret
print_line endp

process_number proc
    process_input:         
                           xor  ax, ax
                           xor  dx, dx
                           mov  minus_sign, 0

    ; print prompt
                           lea  dx, prompt_msg
                           call print_line

    ; receive user input using DOS function 21h, interruption 0Ah
                           lea  dx, buffer
                           mov  ah, 0ah
                           int  21h

    ; Process numerical input (digits 0-9)
                           xor  ax, ax
                           mov  cl, buffer + 1            ; Set the loop counter to the number of characters to process
                           mov  si, 2                     ; Set the SI index to the first character of number
                           cmp  buffer + 2, '-'
                           jne  process_digit

    ; Handle negative sign (if present)
                           inc  si                        ; Increment SI to point to the first digit after the minus sign
                           dec  cl                        ; Decrement CL to account for the minus sign (one less digit to process)
                           mov  minus_sign, 1

    ; Convert ASCII to integer and check for errors
    process_digit:         
                           mov  bl, buffer[si]
                           cmp  bl, '0'
                           jb   handle_non_int
                           cmp  bl, '9'
                           ja   handle_non_int
                           sub  bl, '0'
                           mov  dx, 10
                           imul dx
                           jo   handle_overflow
                           add  ax, bx
                           jo   handle_overflow
                           inc  si
                           loop process_digit
                           jmp  check_sign

    handle_overflow:       
                           lea  dx, new_line
                           call print_line
                           lea  dx, overflow_err_msg
                           call print_line
                           jmp  process_input

    handle_non_int:        
                           lea  dx, new_line
                           call print_line
                           lea  dx, non_int_err_msg
                           call print_line
                           jmp  process_input

    check_sign:            
                           cmp  minus_sign, 1
                           jne  perform_math_operation
                           neg  ax
                           
    perform_math_operation:
                           mov  dx, 2
                           imul dx
                           jo   handle_overflow
                           mov  num, ax

                           ret
process_number endp

print_number proc
                           mov  bx, num
                           or   bx, bx
                           jns  m1
                           mov  al, '-'
                           int  29h
                           neg  bx

    m1:                    
                           mov  ax, bx
                           xor  cx, cx
                           mov  bx, 10

    m2:                    
                           xor  dx, dx
                           div  bx
                           add  dl, '0'
                           push dx
                           inc  cx
                           test ax, ax
                           jnz  m2

    m3:                    
                           pop  ax
                           int  29h
                           loop m3

                           ret
print_number endp

end start