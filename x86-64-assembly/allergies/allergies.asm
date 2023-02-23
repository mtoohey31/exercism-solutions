section .text
global allergic_to
allergic_to:
    mov rax, 1
    mov cl, dil
    shl rax, cl
    and rax, rsi
    ret

global list
list:
    xor ecx, ecx ; current enum value being checked
    xor rdx, rdx ; length of enums found so far

.next:
    test rdi, rdi ; check if the score is at 0 yet
    jz .ret

    ; if rdi & 1 == 0; don't append
    test rdi, 1 ; check if the score's 1 bit is set
    jz .next_no_append

    inc rdx ; inc first to account for offset between size value
    mov [rsi + rdx * 4], ecx

.next_no_append:
    inc ecx

    ; if ecx & 8 == 0; return since we're at max items
    test ecx, 8
    jnz .ret

    shr rdi, 1
    jmp .next

.ret:
    mov [rsi], edx ; save size of items
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
