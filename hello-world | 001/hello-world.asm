mov ah, 0x0e ; tty mode
mov al, 'W'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'c'
int 0x10
mov al, 'o'
int 0x10
mov al, 'm'
int 0x10
mov al, 'e'

int 0x10
mov al, ' '
int 0x10

mov al, 't'
int 0x10
mov al, 'o'
int 0x10

mov al, ' '
int 0x10

mov al, 'm'
int 0x10
mov al, 'a'
int 0x10
mov al, 'z'
int 0x10
mov al, 'y'
int 0x10
mov al, 'o'
int 0x10
mov al, 's'
int 0x10

jmp $ ; jump to current address = infinite loop

times 510-($-$$) db 0
; Magic number
dw 0xaa55 
