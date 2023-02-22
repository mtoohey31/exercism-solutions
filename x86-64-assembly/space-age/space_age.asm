default rel

section .rodata
.earth_seconds: dd 31557600.0
.periods: dd 0.2408467, 0.61519726, 1.0, 1.8808158, 11.862615, 29.447498, 84.016846, 164.79132

section .text
global age
age: ; res = seconds / earth seconds / periods
    ; rdi = enum planet
    ; rsi = int seconds

    push rsi
    movss xmm0, dword [rsp] ; xmm0 = int seconds
    add rsp, 8
    cvtdq2ps xmm0, xmm0 ; xmm0 = float seconds

    movss xmm1, [.earth_seconds] ; xmm1 = float earth seconds
    divss xmm0, xmm1 ; xmm0 = seconds / earth seconds

    lea rax, [.periods]
    movss xmm1, [rax + rdi*4] ; xmm1 = float period
    divss xmm0, xmm1 ; xmm0 = (seconds / earth seconds) / period

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
