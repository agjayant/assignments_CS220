section .data
prompt:         db      "enter the value of N (number of integers): "
len1:         equ     $ - prompt
prompt2:        db      "Enter the N numbers (one by one separated by newline)", 10
len2:         equ     $ - prompt2
res:        db      "The result (Sorted array): "
len3:         equ     $ - res

section .bss
num1:          resb    4
nstr:        resb    4
arr:        resd    64

section .text
        global _start

;converting to integer
intof:
        push    ebx
        mov     eax,0
        mov     ebx,0
    .loop1:
        call    mulby10
        push    edx
        mov     edx,0
        mov     dl,byte[ecx+ebx]
        sub     dl,0x30
        add     eax,edx
        pop     edx
        inc     ebx
        cmp     byte[ecx+ebx],0xa
        jle     .ret
        cmp     ebx,edx
        jge     .ret
        jmp     .loop1
    .ret:
        pop     ebx
        ret

mulby10:
        push    ebx
        mov     ebx,eax
        shl     eax,2
        add     eax,ebx
        shl     eax,1
        pop     ebx
        ret

divby10:
        push    edx
        push    ecx
        mov     edx,0
        mov     ecx,10
        div     ecx
        mov     ebx,edx
        pop     ecx
        pop     edx
        ret

; converting to string

strof:
        push    ebx
        push    eax
        mov     ebx,0
        push    0
    .loop2:
        call    divby10
        add     ebx,0x30
        push    ebx
        cmp     eax,0
        jg      .loop2
        mov     ebx,0
    .loop1:
        pop     eax
        cmp     eax,0
        je      .loop3
        cmp     ebx,edx
        je      .loop1
        mov     byte[ecx+ebx],al
        inc     ebx
        jmp     .loop1
    .loop3:
        cmp     ebx,edx
        je      .ret
        mov     byte[ecx+ebx],0
        inc     ebx
        jmp     .loop3
    .ret:
        pop     eax
        pop     ebx
        ret


scan_str:
        push    ebx
        push    eax
        mov     eax,3
        mov     ebx,0
        int     0x80
        pop     eax
        pop     ebx
        ret


 ; insertion sort 

ins_sort:
        push    eax
        push    edi 
        push    esi
        mov     edi,ecx
        shl     edi,2
    .loop3:
        sub     edi,4
        mov     eax,dword[ebx+edi]
        mov     esi,edi
    .loop4:
        sub     esi,4
        cmp     eax,dword[ebx+esi]
        jg      .swap
        jmp     .here
    .swap:
        push    dword[ebx+esi]
        push    dword[ebx+edi]
        pop     dword[ebx+esi]
        pop     dword[ebx+edi]
        mov     eax,dword[ebx+edi]
    .here:
        cmp     esi,0
        jg      .loop4
        cmp     edi,4
        jg      .loop3

        pop     esi
        pop     edi
        pop     eax
        ret

print_msg:
        push    ebx
        push    eax
        mov     eax,4
        mov     ebx,1
        int     0x80
        pop     eax
        pop     ebx
        ret

_start:
    .main_loop:
        mov     ecx,prompt    ;prompt the user for the length of array
        mov     edx,len1
        call    print_msg

        mov     ecx,num1 
        mov     edx,4
        call    scan_str

        call    intof ;converting to integer and saving in ebx
        push    eax
        mov     ebx,eax

        mov     ecx,prompt2 ;prompt the user for array
        mov     edx,len2
        call    print_msg

          ; Store the number in reverse order

    .loop3_1: ;scan the array
        dec     ebx
        ;storing it in arr+ebx*4
        mov     ecx,nstr
        mov     edx,4
        call    scan_str
        call    intof
        mov     edx,ebx
        shl     edx,2 ;edx = edx*4
        mov     dword[arr+edx], eax
        cmp     ebx,0
        jne     .loop3_1

        mov     ebx,arr
        pop     ecx ;pop the value of N to ecx
        call    ins_sort              ; calling the main sorting function
        mov     ebx,ecx

        mov     ecx,res                 ; printing the result prompt
        mov     edx,len3
        call    print_msg

	; Th numbers are printed in reverse order , so the decreasing order is converted to increasing order

    .loop3_2: ; the number in sorted order
        dec     ebx
        mov     edx,ebx
        shl     edx,2
        mov     eax, dword[arr+edx]
        mov     ecx,nstr
        mov     edx,4
        call    strof
        mov     byte[nstr+3],0x20 ;space
        call    print_msg
        cmp     ebx,0
        jne     .loop3_2 

	;exit

        mov     ebx,0
        mov     eax,1
        int     0x80
