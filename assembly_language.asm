
1.Write a Assembly program to read a character & display it, as well as convert uppercase to lowercase letter and vice versa.  


.model small
.stack 100h
.data
    msg db "Enter a character: $"
    newline db 13, 10, "$"
.code
main:
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    mov bl, al  

    lea dx, newline
    mov ah, 9
    int 21h

    mov dl, bl
    mov ah, 2
    int 21h

    lea dx, newline
    mov ah, 9
    int 21h

    cmp bl, 'A'
    jl not_alpha
    cmp bl, 'Z'
    jg check_lower

    add bl, 32
    jmp display_result

check_lower:
    cmp bl, 'a'
    jl not_alpha
    cmp bl, 'z'
    jg not_alpha

    sub bl, 32
    jmp display_result

not_alpha:
    jmp display_result

display_result:
    mov dl, bl
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h
end main

2.Display a '?' & read two decimal digits whose sum is less than 10 and display their sum as result using Assembly  language.
.model small
.stack 100h
.data
    questionMark db '?', '$'
    newline db 13, 10, '$'
.code
main:
    mov ax, @data
    mov ds, ax

    lea dx, questionMark
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'    
    mov bl, al    

    mov ah, 1
    int 21h
    sub al, '0'    ; Convert ASCII to number
    mov bh, al     ; Store second number in BH

    mov al, bl
    add al, bh

    cmp al, 10
    jae end_program ; if sum >= 10, terminate

    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h

end_program:
    mov ah, 4Ch
    int 21h
end main


3.Write a Assembly program that accepts input and if AL contains 1 or 3, display "o"; if AL contains 2 or 4, display "e".
.model small
.stack 100h
.data
    o_msg db 'o', '$'
    e_msg db 'e', '$'
.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 1
    int 21h
    sub al, '0' 

    cmp al, 1
    je display_o
    cmp al, 3
    je display_o

    cmp al, 2
    je display_e
    cmp al, 4
    je display_e

    jmp end_program

display_o:
    lea dx, o_msg
    mov ah, 9
    int 21h
    jmp end_program

display_e:
    lea dx, e_msg
    mov ah, 9
    int 21h
    jmp end_program

end_program:
    mov ah, 4Ch
    int 21h
end main



4.   Write a Assembly program to read a character and if it’s 'y' or 'Y', display it; otherwise, terminate the program.


.model small
.stack 100h
.data
.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 1
    int 21h

    cmp al, 'y'
    je display_char
    cmp al, 'Y'
    je display_char

    jmp end_program

display_char:
    mov dl, al
    mov ah, 2
    int 21h

end_program:
    ; Exit program
    mov ah, 4Ch
    int 21h
end main


  5.Write some Assembly  code to count the number of characters in input line.

.model small
.stack 100h
.data
    count db 0    ; character counter
    newline db 13, 10, '$'
.code
main:
    mov ax, @data
    mov ds, ax

start_reading:
    mov ah, 1
    int 21h

    cmp al, 13
    je show_count

    inc count
    jmp start_reading

show_count:
    lea dx, newline
    mov ah, 9
    int 21h

    mov al, count
    add al, '0'

    mov dl, al
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h
end main


 6.Write a Assembly program to read a character, and if it's an uppercase letter, display it.


.model small
.stack 100h
.data
    msg db 'Enter a character: $'
    newline db 13,10,'$'
.code
main:
    ; Initialize DS
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al ; Store character in BL

    cmp bl, 'A'
    jl not_uppercase
    cmp bl, 'Z'
    jg not_uppercase

    lea dx, newline
    mov ah, 09h
    int 21h

    mov dl, bl
    mov ah, 02h
    int 21h

    jmp exit

not_uppercase:

exit:
    mov ah, 4Ch
    int 21h
end main


7.Write a Assembly  program to display a "?", read two capital letters, and display them on the next line in alphabetical order.]


.model small
.stack 100h
.data
    prompt db '?$'
    newline db 13,10,'$'
.code
main:
    mov ax, @data
    mov ds, ax

    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al  ; Store first letter in BL

    mov ah, 01h
    int 21h
    mov bh, al  ; Store second letter in BH

    lea dx, newline
    mov ah, 09h
    int 21h

    cmp bl, bh
    jle display_in_order  
    xchg bl, bh           

display_in_order:
    mov dl, bl
    mov ah, 02h
    int 21h

    mov dl, bh
    mov ah, 02h
    int 21h

    mov ah, 4Ch
    int 21h
end main



8.Write a Assembly  program that will prompt the user to enter a hex digit character ("0"–"9" or "A"–"F"), display it on the next line in decimal, and ask the user if he or she wants to do it again. If the user types "y" or "Y", the program repeats; if the user types anything else, the program terminates. If the user enters an illegal character, prompt the user to try again.


.model small
.stack 100h
.data
    prompt db 'Enter a hex digit (0-9 or A-F): $'
    newline db 13,10,'$'
    invalid db 13,10,'Invalid input. Try again.',13,10,'$'
    again_msg db 13,10,'Do you want to continue? (y/n): $'
.code
main:
    ; Setup DS
    mov ax, @data
    mov ds, ax

start_over:
    ; Prompt for hex digit
    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al  ; Store character

    cmp bl, '0'
    jl invalid_input
    cmp bl, '9'
    jle valid_digit

    cmp bl, 'A'
    jl invalid_input
    cmp bl, 'F'
    jg invalid_input

valid_digit:
    ; Display newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Convert hex digit to decimal
    cmp bl, '9'
    jle convert_digit   ; '0'-'9' are simple

    sub bl, 'A'
    add bl, 10
    jmp display_decimal

convert_digit:
    sub bl, '0'

display_decimal:
    mov ah, 0
    mov al, bl
    aam             ; ASCII Adjust after Multiply (for decimal output)
    add ax, 3030h   ; Convert to ASCII
    mov dl, ah
    mov ah, 02h
    int 21h         ; Output tens digit
    mov dl, al
    mov ah, 02h
    int 21h         ; Output ones digit

ask_again:
    lea dx, again_msg
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    cmp al, 'y'
    je start_over
    cmp al, 'Y'
    je start_over

    mov ah, 4Ch
    int 21h

invalid_input:
    lea dx, invalid
    mov ah, 09h
    int 21h
    jmp start_over

end main


9Write a Assembly   program to input a hex-digit character and if the user fails to enter a hex-digit character in three tries, display a message and terminate the program.

.model small
.stack 100h
.data
    prompt db 'Enter a hex digit (0-9 or A-F): $'
    newline db 13,10,'$'
    invalid db 13,10,'Invalid input. Try again.',13,10,'$'
    fail_msg db 13,10,'Failed 3 times. Program terminated.$'
.code
main:
    mov ax, @data
    mov ds, ax

    mov cl, 3  

input_loop:
    lea dx, prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al

    cmp bl, '0'
    jl invalid_input
    cmp bl, '9'
    jle valid_input

    cmp bl, 'A'
    jl invalid_input
    cmp bl, 'F'
    jg invalid_input

valid_input:
    lea dx, newline
    mov ah, 09h
    int 21h

    mov dl, bl
    mov ah, 02h
    int 21h

    mov ah, 4Ch
    int 21h

invalid_input:
    lea dx, invalid
    mov ah, 09h
    int 21h

    dec cl
    jz fail      

    jmp input_loop

fail:
    lea dx, fail_msg
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h

end main


10.Write a program using stack to input a string and reverse it.


.model small
.stack 100h
.data
    prompt db 'Enter a string (max 20 chars): $'
    newline db 13,10,'$'
    string db 21 dup('$') ; Space for 20 characters + null
.code
main:

    mov ax, @data
    mov ds, ax

    lea dx, prompt
    mov ah, 09h
    int 21h

    lea dx, string
    mov ah, 0Ah
    int 21h

    mov si, offset string + 1 
    mov cl, [si]             
    inc si                    
    mov bx, cx               

push_loop:
    mov al, [si]
    push ax
    inc si
    dec cl
    jnz push_loop

    lea dx, newline
    mov ah, 09h
    int 21h

pop_loop:
    pop ax
    mov dl, al
    mov ah, 02h
    int 21h
    dec bx
    jnz pop_loop

    mov ah, 4Ch
    int 21h
end main
