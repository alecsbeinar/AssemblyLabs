data segment
old_cs dw 0
old_ip dw 0
schet dw 0
message db 'hello',10,13,'$'
data ends
 
astack segment stack
dw 512 dup(?)
astack ends
 
code segment
assume cs:code, ds:data, ss:astack
 
NEW_INT PROC NEAR
PUSH AX ;????????? ??? ?????????? ????????
push dx
MOV Dl, 07h
MOV Ah, 2h
INT 21h
INC schet
POP dX ;??????????????? ????????
pop ax
IRET
NEW_INT ENDP
 
MAIN PROC NEAR
PUSH DS
SUB AX,AX
PUSH AX
MOV AX,data
MOV DS,AX
SUB AX,AX
 
MOV AH, 35h ; ??????? ????????? ???????
MOV AL, 23h ; ????? ???????
INT 21h
MOV old_ip, BX ; ??????????? ????????
MOV old_cs, ES ; ? ????????
 
 
PUSH DS
MOV DX, OFFSET NEW_INT ; ???????? ??? ????????? ? DX
MOV AX, SEG NEW_INT ; ??????? ?????????
MOV DS, AX ; ???????? ? DS
MOV AH, 25H ; ??????? ????????? ???????
MOV AL, 23H ; ????? ???????
INT 21H ; ?????? ??????????
POP DS
 
cickl_m:
mov dx, offset message
mov ah, 9
int 21h
cmp schet, 05h
jb cickl_m
 
CLI    ;????????? ?????????? ??????????
PUSH DS ;DS ????? ????????
MOV DX,old_ip ;?????????? ? ??????????????
MOV AX,old_cs ;
MOV DS,AX ;?????????? ? ??????????????
MOV AH,25h ;??????? ????????? ???????
MOV AL,23h ;????? ???????
INT 21h ;??????????????? ??????
POP DS ;??????????????? DS
STI  ;??? ???????? ?????????? ??????????
ret
MAIN ENDP
start:
call MAIN
mov ax,4C00h
int 21h
CODE ENDS ;????? ????????
END MAIN ;????? ?????????