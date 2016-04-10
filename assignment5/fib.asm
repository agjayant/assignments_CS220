%macro read 2
    mov edx, %2
    mov ecx, %1
    mov ebx, 0
    mov eax, 3
    int 80h
%endmacro

%macro write 2
    mov edx, %2
    mov ecx, %1
    mov ebx, 1
    mov eax, 4
    int 80h
%endmacro

%macro exit 1
  mov ebx, %1
  mov eax, 1
  int 80h
%endmacro

;;  converting string to integer
%macro read_val 2
    read %1, %2
    mov esi, %1         ; esi gets 1st argument of the function
    mov ecx, eax        ; loop counter
    xor ebx, ebx        ; initiating ebx to zero's
  loop2:                   
    sub ecx,1
    cmp ecx,0
    je skip        
    imul ebx, 10       
    lodsb               ; loading esi on al
    sub eax, '0'        ; ascii to numbers
    add ebx, eax        ; converting to integer from string
    jmp loop2
    skip:
    mov eax, ebx        ;
%endmacro

;; converting an integer to string
%macro int_to_string 2
  xor ecx, ecx         ;initiating ecx to zero's
  mov ebx, 10          ;intiating in such a way that integer can be converted to decimal by dividing by 10
  mov edi, %1          ;moving 1st argument to edi
pushing:
  xor edx, edx         ;initiating edi to zero's
  div ebx              ;remainder is edx and quotient is eax
  add edx, '0'         ;to get ascii values
  push edx             ;adding to string
  inc ecx              
  cmp eax, 0           ; loop run till quotient becomes 0
  jne pushing
  mov %2, ecx ; digits in the number
poping:
  pop eax  
  stosb                ;  loading eax to location pointed by esi or edi
  dec ecx
  cmp ecx, 0
  jne poping
%endmacro

section .data
  endl db 0xa
  len_endl equ $ - endl
  mes1 db 'Give a Number: '
  meslen1 equ $-mes1
  mes2 db 'fibo number is: '
  meslen2 equ $-mes2


section .bss
  Numb resb 8
  len resb 8

section .text
	global _start
_start:
  write mes1, meslen1   
  read_val Numb, 3           ; taking number
  call fibo                 ; ret value stored in eax
  int_to_string Numb, [len]
  write mes2, meslen2
  write Numb, [len]
  write endl,len_endl
  exit 0

fibo:
  mov ecx, eax
  mov eax, 0            
  mov ebx, 1
loop1:
  sub ecx,1
  cmp ecx,0
  je rtrn               ; exiting from loop when eax is 0
  mov edx,eax           ;using edx as temp
  mov eax,ebx           ;moving ebx to eax
  add ebx, edx          ;adding eax to ebx
  jmp loop1
rtrn:
  ret
