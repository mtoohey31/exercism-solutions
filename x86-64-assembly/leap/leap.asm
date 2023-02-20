section .text
global leap_year
leap_year:
    ; rdx = rdi & 0b11
    mov rdx, rdi
    and rdx, 0b11

    ; if rdx == 0, jump
    test rdx, rdx
    jz check_100

    ; else if rdx != 0, return false
    xor rax, rax
    ret

check_100:
    ; rdx = rdi % 100
    ; only need to clear rdx on first div because on subsequent ones it must be
    ; 0 since the dividend must fit within 64 bits, thus the quotient must also
    xor rdx, rdx
    mov rax, rdi
    mov rsi, 100
    div rsi

    ; if rdx == 0, jump
    test rdx, rdx
    jz check_400

    ; else if rdx != 0, return true
    mov rax, 1
    ret

check_400:
    ; rdx = rdi % 400
    mov rax, rdi
    mov rsi, 400
    div rsi

    ; if rdx == 0, jump
    test rdx, rdx
    jz ret_true

    ; else if rdx != 0, return false
    xor rax, rax
    ret

ret_true:
    mov rax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
