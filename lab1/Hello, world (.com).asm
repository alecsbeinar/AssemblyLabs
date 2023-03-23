.model tiny   
ORG 100h
.data
    message db 'Hello, World!$' 
.code 
START:
    mov ah, 9h
    lea dx, message
    int 21h
    ret
end START 

