.8086
.model small

.stack 100h

.data
    buffer              db 7, ?, 7 dup (?)
    header_msg          db 10, '--- Piecewise Function Calculator ---', 10, 10, 13, '$'
    prompt_msg          db 'Enter your number (from -32 768 to 32 767): $'
    result_msg          db 'Result is: $'
    overflow_err_msg    db 'Error: Overflow happened.', 10, 13, '$'
    non_int_err_msg     db 'Error: You have entered non-integer value.', 10, 13, '$'
    incorrect_input_msg db 'Error: Incorrect input number.', 10, 13, '$'
    new_line            db 10, 13, "$"

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