.model small
.code
start:
    mov ax, data
    mov ds, ax
    mov ah, 9h
    mov dx, offset message
    int 21h 
    mov ax, 4c00h ; exit to operating system.
    int 21h  

.data
    message db "Hello, World!$"
.stack 100h

end start ; set entry point and stop the assembler.
