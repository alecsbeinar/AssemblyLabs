.model tiny
.code
ORG 100h
START:
;   
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, char
    mov ah, 10 
    int 21h  
        
    xor ax, ax
    mov al, [char + 1]

    lea si,char   ;SI na adres bukv   
    add si, 2
    mov bx,si     ;sohranit v BX  
 
    mov cx,ax    ;kolichestvo bukv
    mov bp,cx     ;sohranit v BP
    
    lea dx,message
    mov ah, 9
    int 21h 
     
 
    mov dl,0FFh     ;dlia sravnenia max vozmozhnoy znachenie -1=0FFh      
          
m1:
    lodsb         ;kopiruet 1 byte iz DS:SI b AL potom SI uvelich na 1
    cmp dl,al     ;sravnivaem kod bukvy s max
    
    jb m2   ;bolshe
 
    mov dl,al     ;menshiy sohranit d DL
    mov di,si     ;adres v DI
    dec di
m2:
    loop m1       ;prochitat ostalnye
 
    cmp dl,0FFh     ;esli DL=0FFh vsia stroka zapolnena 0FFh,
 
    jz exit ;esli ZF=1 - chisla ravny (v samom konce vse odinakovye 0FFh)
 
    mov [di],0FFh ;menshiy zameniaem na bolshiy 0FFh
         
    xor ax, ax
    mov ah,2h      ;vyvod symvola na ekran
    int 21h       
    mov cx,bp     ;vosstanavlivaem kolichestvo symvolov
    mov si,bx     ;vosstanavlivaem adres stroki
 
    mov dl,0FFh     ;vosstanavlivaem max znach
 
    jmp m1 
 
exit:
;zhdat nazhatia klavishi
    xor ax,ax
    int 16h
 
    ret 

.DATA
MAX_LEN = 200       
char db MAX_LEN,?, MAX_LEN DUP('$') 
message db 10, 13, 'Sorted str:$'     
end start
                                                         
                                                         

                                                        