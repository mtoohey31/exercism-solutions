section .text
global distance
distance:
    mov rax, 0

.next:
    mov dl, byte [rdi]
    mov cl, byte [rsi]

    ; if dl & cl == 0; then return
    test dl, cl
    jz .ret_check_len

    inc rdi
    inc rsi

    ; if dl != cl; rax += 1
    cmp dl, cl
    je .next

.inc_next:
    inc rax
    jmp .next

.ret_check_len:
    ; if dl != cl (=> (dl == 0) != (cl != 0)); rax = -1
    cmp dl, cl
    je .ret

    mov rax, -1

.ret:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
