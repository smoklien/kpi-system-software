.8086
.model small

.stack 100h

.data
    header_msg          db 10, '--- Piecewise Function Calculator ---', 10, 10, 13, '$'
    function_msg        db '| x-1,                  if x < -1', 10, 13
                        db '| 0,                    if x = -1', 10, 13
                        db '| (x^3+2x^2+11)/(2x+1), if x > -1', 10, 10, 13, '$'
    prompt_msg          db 'Enter your X (from -32 768 to 32 767): ', '$'
    result_msg          db 'Result is: ', '$'
    remainder_msg       db 'Remainder is: ', '$'
    overflow_err_msg    db 'Error: Overflow happened.', 10, 13, '$'
    non_int_err_msg     db 'Error: You have entered non-integer value.', 10, 13, '$'
    incorrect_input_msg db 'Error: Incorrect input number.', 10, 13, '$'
    new_line            db 10, 13, "$"

    buffer              db 7, ?, 7 dup (?)
    number              dw 0
    result              dw 0
    remainder           dw 0
    minus_sign          db 0

.code
    start:              
                        mov  ax, DGROUP
                        mov  ds, ax

                        lea  dx, header_msg
                        call print_line
                        lea  dx, function_msg
                        call print_line

process_input:
                        call process_number
                        call process_function

                        lea  dx, new_line
                        call print_line
                        lea  dx, result_msg
                        call print_line

                        mov  bx, result
                        call print_number

                        lea  dx, new_line
                        call print_line
                        lea  dx, remainder_msg
                        call print_line

                        mov  bx, remainder
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
    ; process_input:      
                        xor  ax, ax
                        xor  cx, cx
                        xor  dx, dx
                        mov  minus_sign, 0

    ; print prompt
                        lea  dx, prompt_msg
                        call print_line

    ; receive user input using DOS function 21h, interruption 0ah
                        lea  dx, buffer
                        mov  ah, 0ah
                        int  21h

    ; Process numerical input (digits 0-9)
                        xor  ax, ax
                        mov  cl, buffer + 1          ; Set the loop counter to the number of characters to process
                        mov  si, 2                   ; Set the SI index to the first character of number
                        cmp  buffer + 2, '-'
                        jne  process_digit

    ; Handle negative sign (if present)
                        inc  si                      ; Increment SI to point to the first digit after the minus sign
                        dec  cl                      ; Decrement CL to account for the minus sign (one less digit to process)
                        mov  minus_sign, 1

    ; Convert ASCII to integer and check for errors
    process_digit:      

    ; Handle non-integer values
                        mov  bl, buffer[si]
                        cmp  bl, '0'
                        jb   handle_non_int
                        cmp  bl, '9'
                        ja   handle_non_int

    ; Convert ASCII to integer
                        sub  bl, '0'

    ; Add together converted digits and check for overflow
                        mov  dx, 10
                        imul dx
                        jo   handle_overflow
                        add  ax, bx
                        jo   handle_special_case

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

    handle_special_case:
                        cmp  ax, -32768
                        jne  handle_overflow
                        cmp  minus_sign, 1
                        jne  handle_overflow
                        neg  ax
                        jmp  return_number
    
    check_sign:         
                        cmp  minus_sign, 1
                        jne  return_number
                        neg  ax

    return_number:      
                        mov  number, ax

                        ret
process_number endp

process_function proc
    
                        xor  ax, ax
                        xor  bx, bx
                        xor  dx, dx

                        mov  ax, number
                        test ax, ax
                        jns  third_operation

                        cmp  ax, -1
                        je   second_operation

    ; if x < -1
    ; result = x - 1
    first_operation:    
                        sub  ax, 1
                        ; jo   handle_special_case

                        jmp  return_result

    ; if x = -1
    ; result = 0
    second_operation:   
                        mov  ax, 0

                        jmp  return_result

    ; if x > -1
    ; result = (x^3 + 2x^2 + 11) / (2x + 1)
    third_operation:    
                        mov  ax, number              ; Load number into ax
                        mov  dx, ax                  ; Copy ax to dx
                        mul  dx                      ; ax = ax * dx (ax = number * number)
                        jo   handle_overflow

                        mov  cx, ax                  ; Move result to cx
                        mov  ax, number              ; Load number into ax again
                        mul  cx                      ; ax = ax * cx (ax = number * (number * number)), ax - first term of numerator
                        jo   handle_overflow

                        add  cx, cx                  ; cx = cx + cx (cx = 2 * (number * number)), cx - second term of numenator
                        add  ax, cx                  ; ax = ax + cx (ax = (number * (number * number)) + (2 * (number * number)))
                        jo   handle_overflow
                        add  ax, 11                  ; ax = ax + 11, ax - numerator
                        jo   handle_overflow

                        mov  dx, number              ; Load x into dx
                        add  dx, dx                  ; dx = dx + dx (dx = 2 * number), dx - first term of denumerator
                        add  dx, 1

                        mov  cx, dx                  ; Move denumenator to the cx
                        xor  dx, dx                  ; reset dx to perform multiply
                        div  cx                      ; ax = ax / cx (result in ax, remainder in dx)

                        mov  remainder, dx
                        mov  result, ax


    return_result:      
                        mov  result, ax
                        ret

process_function endp

print_number proc
    ; mov  bx, result              ; number
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