; Group14
; ASSEMBLY ASSASSINS* ----
; Muhammad Ahmad(19l - 1199)
; Hassan Khalid(19l - 1181)
; Gulraiz jutt(19l - 1217)
; Yousaf Qadri(19l - 0909)
; TIC TAC TOE BY ASSEMBLY ASSASSINS* ----

[org 0x0100]
section.data
intro dw 0
n db 0
msg1 db 'He\$$lloh ', 41h, 7, '$', 10, 0
msg2 equ $ - msg1
msg3 dw msg2
spilter db 10, 10, "------------------------", 10, 10, '$'
O_Winner db 'O is Winner!', 10, 0
X_Winner db 'X is Winner!', 10, 0
prompt db 'Your turn (Enter input in 2D starting from 0th coloumn and row)', 10, 0
msg4 db 'GAME MADE BY ASSEMBLY ASSASSINS', 0x0d, 0x0a, '$'
location db 0, 0
r1 db ' | |  ', 10, 0; 1st row
r2 db ' | |  ', 10, 0; 2nd row
r3 db ' | |  ', 10, 0; 3rd row
sep db '----- ', 10, 0; separator




mov dx, msg4
mov ah, 9
int 21h
mov cl, [intro]
or cl, cl
jz end_if1
mov dx, msg1
mov ah, 9
int 21h
mov dx, spilter
mov ah, 9
int 21h

end_if1 :

    mov cx, 9
    mov dl, 'X'

for_loop :

    push cx
    push dx
    mov dx, prompt
    call string1
    call user_selection
    pop dx
    call update_board
    call display_board
    cmp dl, 'X'
    je  mov_o
    mov dl, 'X'
    jmp end_mov


mov_o :

    mov dl, 'O'
end_mov :

    push dx

check_for_win :

    mov si, r1
    mov cx, 3

check_for_win_row_loop :

    push cx                               ; looping index
    xor cx, cx                            ; making the register zero
    mov cl, [si]                          ; moving the values on address to cl
    mov ax, cx                            ; put values into ax
    mov cl, [si + 2]                      ; values of next cell into cl
    add ax, cx                            ; addition
    mov cl, [si + 4]                      ; adding 2 to move to third cell and moving its values in cl
    add ax, cx                            ; addition
    cmp ax,  'O'* 3                       ; examine if count of sign 'o' in 3 rows = 3
    jz winner
    cmp ax,  'X'* 3                       ; examine if count of sign 'x' in 3 rows = 3
    jz winner
    add si, 8                             ; jump to next row
    pop cx                                ; regain loop counter
    dec cx                                ; decrement counter
    jnz check_for_win_row_loop            ; go back to loop if not zero
    mov si, r1
    mov cx, 3

check_for_win_col_loop:

push cx
xor cx, cx
mov cl, [si]
mov ax, cx
mov cl, [si + 8]
add ax, cx
mov cl, [si + 2 * 8]
add ax, cx
cmp ax, 3 * 'O'       ; examine if count of sign 'o' in 3 cols = 3
jz winner
cmp ax, 3 * 'X'       ; examine if count of sign 'x' in 3 rows = 3
jz winner
add si, 2				; jump to next col
pop cx					; regain loop counter
dec cx					; decrement counter
jnz check_for_win_col_loop
mov si, r1
xor cx, cx   ; initialize to 0
mov cl, [si]
mov ax, cx
mov cl, [si + 8 + 2]
add ax, cx
mov cl, [si + 2 * 8 + 4]
add ax, cx
cmp ax, 3 * 'O'
jz winner
cmp ax, 3 * 'X'
jz winner
mov si, r1
xor cx, cx
mov cl, [si + 4]
mov ax, cx
mov cl, [si + 8 + 2]
add ax, cx
mov cl, [si + 2 * 8]
add ax, cx
cmp ax, 3 * 'O'
jz winner
cmp ax, 3 * 'X'
jz winner
pop dx
pop cx
dec cx
jnz for_loop

winner :

   cmp ax, 3 * 'O'
   jz o_wins
   mov dx, X_Winner
   call string1
   jmp end_print_winner

o_wins :

   mov dx, O_Winner
   call string1

end_print_winner :

    mov al, 0
    mov ah, 4Ch
    int 21h

string0 :

   mov ah, 40h
   mov bx, 01h
   int 21h
   ret

string1 :

;push ax     ;loop
;mov ax,n
;cmp ax,0
;pop ax
;je ForR1

;ForR1:

;push ax 
;push bx
;push cx
;push dx
;push es

       ;mov al,1h
       ;mov cx,10
       ;mov dh,11 
       ;mov dl,37
       ;mov bp,[r1] 
;       mov es,0xB800
;	   int 10h
;      push ax
;	   mov ax,[n]
;	   add ax,1
;	   mov [n],ax
;	   pop ax
 ;       
;pop es
;pop dx
;pop cx
;pop bx
;pop ax


;push ax
;mov ax,n
;cmp ax,1
;pop ax

;je ForR2

;ForR2:

;push ax 
;push bx
;push cx
;push dx
;push es

 ;      mov al,1h
  ;     mov cx,10
   ;    mov dh,12 
    ;   mov dl,37
     ;  mov bp,[r2] 
      ; mov es,0xB800
	   ;int 10h
;	   push ax
;	   mov ax,[n]
;	   add ax,1
;	   mov [n],ax
;	   pop ax
       
        
;pop es
;pop dx
;pop cx
;pop bx
;pop ax

;push ax
;mov ax,n
;cmp ax,0
;pop ax
;je ForR3

;ForR3:

;push ax 
;push bx
;push cx
;push dx
;push es

 ;      mov al,1h
  ;     mov cx,10
   ;    mov dh,13
    ;   mov dl,37
     ;  mov bp,[r3] 
      ; mov es,0xB800
;	   int 10h
;	   push ax
;	   mov ax,[n]
;	   add ax,1
;	   mov [n],ax
;	   pop ax
        
        
;pop es
;pop dx
;pop cx
;pop bx
;pop ax

   mov si, dx; load the start of string into si

string2 :

   mov cl, [si]
   inc si
   and cl, cl
   jnz string2
   dec si
   sub si, dx
   mov cx, si
   mov ah, 40h
   mov bx, 01h
   int 21h
   ret; string1




display_board :


push dx
;call color
mov dx, r1
call string1
;call color
mov dx, sep
;call color
call string1
;call color
mov dx, r2
call string1
;call color
mov dx, sep
call string1
;call color
mov dx, r3
call string1
;call color
pop dx

ret; display_board
user_selection :

               ;read r1

      mov ah, 07h
      int 21h
      sub al, 30h; ascii to integer
      mov[location], al
               ;read c1
      mov ah, 07h
      int 21h
      sub al, 30h; ascii to integer
      mov[location + 1], al



push ax    ;clear screen
push cx
push di
push es
mov ax, 0xB800
mov es, ax
mov ax, 0x0720
mov cx, 2000
cld
rep stosw
pop es
pop di
pop cx
pop ax


       ret; user_selection

update_board :

call backgroundcolor
push 0xb800  ; creating color borders
pop es

Mov di,160

mov cx,80

cld 

stosw        ;upper border 

push 0xb800

pop es

Mov di,18640

mov cx,80

cld 

stosw          ;down border



xor ax, ax
mov  al, [location + 1]
shl  ax, 1; multiple by 2 to handle the vertical bar separators
xor cx, cx
mov  cl, [location]
shl  cx, 3; multiply by 8 to get the row(each row is conviently 8 bytes)
add  ax, cx
add  ax, r1
mov  si, ax
mov[si], dl
push dx
push ax
mov dx, msg4
mov ah, 9
int 21h
pop ax
pop dx
ret; update_board

backgroundcolor:

push ax ;changing background color
push bx
push cx
push dx

mov ah, 06h; 
mov al, 0; 
mov cx, 0000; 
mov dx, 184FH; 
mov bh, 3Ah; 
int 10h


pop dx
pop cx
pop bx
pop ax
ret

color:

push ax ;changing background color
push bx
push cx
push dx

mov ah, 06h; 
mov al, 1; 
mov cx, 0000; 
mov dx, 184FH; 
mov bh, 3Ah; 
int 10h


pop dx
pop cx
pop bx
pop ax
ret
;ClearScreen:
;push ax  ;to clear the screen
;push cx
;push di
;push es
;mov ax, 0xB800
;mov es, ax
;mov ax, 0x0720
;mov cx, 2000
;cld
;rep stosw
;pop es
;pop di
;pop cx
;pop ax
;ret






