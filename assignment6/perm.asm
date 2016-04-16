    %macro read 2 
      push eax
      push ebx
      push ecx
      push edx

      mov   eax, 3
      mov   ebx, 0
      mov   ecx, %1
      mov   edx, %2
      int   80h 

      pop edx
      pop ecx
      pop ebx
      pop eax
   %endmacro

  %macro print 2 
      push eax
      push ebx
      push ecx
      push edx

      mov   eax, 4
      mov   ebx, 1
      mov   ecx, %1
      mov   edx, %2
      int   80h 

      pop edx
      pop ecx
      pop ebx
      pop eax
   %endmacro


section .data

	prompt2 db 'Enter the string: '
	userlen2 equ $ - prompt2
	
	newline db 0xa 
	len2 equ $ - newline    

section .bss
	cha resb 1
        string resb 10



section .text          ;Code Segment
   global _start

_start:

print prompt2,userlen2

;take input string
   mov edx,4
   mov eax,3
   mov ebx,0
   mov ecx,string
   int 80h


mov eax,0  	; l
mov ebx,3	; r 

call perm

mov    eax,1          ;system call number (sys_exit)
int    0x80           ;call kernel

perm:
	cmp eax, ebx        ; if (l==r)
	jne else 	 ; else condition
      	print string,4
	print newline,len2
      	ret  		 
else:
	push ebx 	 ; saving bl ( r  )
	sub ebx,eax 	 ; getting r - l (bl -al)
	mov ecx,ebx 	 ; moving the result in ecx (loop counter)
	pop ebx           ; getting bl back ( r )
	mov esi,eax
	inc ecx	

loop_str:
	push ecx
	mov cl,byte[string+eax]      ; swap string[l], string[i]
	mov dl,byte[string+esi]
	mov byte[string+esi],cl
	mov byte[string+eax],dl
	pop ecx
	
	push dword[string]


	push eax
	push ebx
	push ecx
	push edx
	push esi

	inc eax
	call perm           ; recursive call : perm (string, l+1,r)

	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax

	pop dword[string]
	
	push ecx
	mov cl,byte[string+eax]      ; swap string[l], string[i]
	mov dl,byte[string+esi]
	mov byte[string+esi],cl
	mov byte[string+eax],dl
	pop ecx
	inc esi

	loop loop_str

	ret
