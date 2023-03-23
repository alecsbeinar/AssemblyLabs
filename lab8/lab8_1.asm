ctrlc  db   '****] Pressed CTRL+C key [****$'
 
start:
   xor   ax,ax
   int   16h
   cmp   al,3
   je    next
   jmp   start
 
next:
   mov   ah,9
   lea   dx,ctrlc
   int   21h