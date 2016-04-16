%macro write 2
    mov edx, %2
    mov ecx, %1
    mov ebx, 1
    mov eax, 4
    int 80h
%endmacro

section	.text
   global _start       
	
_start:	            
   mov ecx,100
   mov eax, '0'
	
l1:
rdtsc
and eax,9h             
;the idea is to generate random numbers from 0-9 and 
;if we get zero, blue is printed
;else take mod 3, if res is 0 -> print Red
;else print Green
   mov [num], eax
   push ecx
   mov esi,[num]
   cmp esi,'0'
   je blue
   mov ebx,3
   sub esi,'0'
   mov eax,esi
   div ebx
   cmp edx,0
   je red
   
green:
    write mes1,1
	jmp xit
blue:
    write mes2,1
	jmp xit
red:
    write mes3,1
xit:
   mov eax, [num]
   sub eax, '0'
   inc eax
   add eax, '0'
   pop ecx
loop l1
	
   mov eax,1            
   int 0x80           

section	.bss
	num resb 1

section .data
    
  mes1 db 'G: '
  mes2 db 'B: '
  mes3 db 'R: '

