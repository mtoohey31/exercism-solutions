section .rodata
.prefix db "One for "
.suffix db ", one for me.", 0x0
.you    db "you"

section .text
global two_fer
two_fer:
    ; rdi = char* name
    ; rsi = char* buffer

    ; copy prefix
    mov rdx, [rel .prefix]
    mov [rsi], rdx
    add rsi, 8

    ; if rdi == NULL, copy "you" instead of *name
    test rdi, rdi
    jz .copy_you

.copy_name:
    mov dh, [rdi] ; move the current char pointed to by rdi to dh

    ; if dh == '\0', jump to adding the suffix
    test dh, dh
    jz .copy_suffix

    ; otherwise, append the char to the buffer, inc both pointers, and loop
    mov [rsi], dh
    inc rdi
    inc rsi
    jmp .copy_name

.copy_you:
    mov rdx, [rel .you]
    mov [rsi], rdx
    add rsi, 3

.copy_suffix:
    mov rdx, [rel .suffix]
    mov [rsi], rdx
    mov rdx, [rel .suffix + 8]
    mov [rsi + 8], rdx

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
