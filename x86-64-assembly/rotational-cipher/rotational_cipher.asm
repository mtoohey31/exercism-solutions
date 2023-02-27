section .text
global rotate
rotate:
    ; rdi = char *text
    ; rsi = shift_key
    ; rdx = char *buffer

    ; clear ax so that the upper section isn't defined when dividing
    mov ax, 0

    ; prepare bl as the divisor for wrapping
    mov bl, 26

    ; if *rdi == '\0'; return
    mov al, [rdi]
    test al, al
    jz .ret

    ; if al > 'z'; don't rotate
    cmp al, 'z'
    jg .no_rot

    ; if al < 'A'; don't rotate
    cmp al, 'A'
    jl .no_rot

    ; if al >= 'a'; rotate lowercase
    cmp al, 'a'
    jge .rot_low

    ; if al > 'Z'; don't rotate since it's between uppercase and lowercase
    cmp al, 'Z'
    jg .no_rot

    ; otherwise, rotate uppercase

.rot_up:
    sub al, 'A'
    add al, sil
    div bl ; ah = al % 26 (bl == 26)
    add ah, 'A'

    mov [rdx], ah

    inc rdi
    inc rdx
    jmp rotate

.rot_low:
    sub al, 'a'
    add al, sil
    div bl ; ah = al % 26 (bl == 26)
    add ah, 'a'

    mov [rdx], ah

    inc rdi
    inc rdx
    jmp rotate

.no_rot:
    mov [rdx], al

    inc rdi
    inc rdx
    jmp rotate

.ret:
    mov byte [rdx], 0 ; terminate buffer
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
