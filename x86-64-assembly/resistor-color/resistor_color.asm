default rel

section .data
black db "black", 0
brown db "brown", 0
red db "red", 0
orange db "orange", 0
yellow db "yellow", 0
green db "green", 0
blue db "blue", 0
violet db "violet", 0
grey db "grey", 0
white db "white", 0
arr dq black, brown, red, orange, yellow, green, blue, violet, grey, white, 0

section .text
global color_code
color_code: ; rdi = color pointer
    lea rsi, [arr] ; rsi = arr pointer
    mov rax, 0 ; rax = arr offset

.cmp_color:
    ; if arr[rax] == NULL; return -1 because we found no match
    cmp qword [rsi + rax*8], 0
    je .ret_neg_one

    mov rcx, [rsi + rax*8] ; rcx = arr color pointer

    ; initialize string offsets
    mov r8, 0 ; r8 = color offset
    mov r9, 0 ; r9 = arr color offset

.cmp_char:
    mov dl, byte [rdi + r8]
    mov r10b, byte [rcx + r9]

    ; if dl | r10b == 0 (=> dl == 0 && r10b == 0) then return current rax
    or dl, r10b
    jz .ret_rax

    mov dl, byte [rdi + r8]

    inc r8
    inc r9

    ; if dl == r10b; compare the next char
    cmp dl, r10b
    je .cmp_char

    ; else; compare next string
    inc rax
    jmp .cmp_color

.ret_neg_one:
    mov rax, -1
.ret_rax:
    ret

global colors
colors:
    lea rax, [arr]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
