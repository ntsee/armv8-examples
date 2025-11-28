.data
atomic_var: .dword 0

.text
.global _start
_start:
main:
    mov x0, 7

    mov x1, 0x1234
    movk x1, 0x5678, lsl 16
    mov x2, 0x56781234
    cmp x1, x2
    b.ne bad_exit

    mov x1, 0
    movk x1, 0xABCD, lsl 0
    mov x2, 0xABCD
    cmp x1, x2
    b.ne bad_exit

    mov x1, 0
    movk x1, 0x1111, lsl 48
    movk x1, 0x2222, lsl 32
    movk x1, 0x3333, lsl 16
    movk x1, 0x4444, lsl 0
    mov x2, 0x1111222233334444
    cmp x1, x2
    b.ne bad_exit

    mov x1, 0x100000000
    mov x2, 0x100000000
    umulh x3, x1, x2
    mov x4, 1
    cmp x3, x4
    b.ne bad_exit

    mov x1, 0x8000000000000000
    mov x2, 2
    umulh x3, x1, x2
    mov x4, 1
    cmp x3, x4
    b.ne bad_exit

    mov x1, 1000000000
    mov x2, 1000000000
    mul x3, x1, x2
    umulh x4, x1, x2
    cmp x4, 0
    b.ne bad_exit

    mov x1, 2
    mov x2, 3
    smulh x3, x1, x2
    cmp x3, 0
    b.ne bad_exit

    mov x1, 0x4000000000000000
    mov x2, 4
    smulh x3, x1, x2
    mov x4, 1
    cmp x3, x4
    b.ne bad_exit

    ldur x10, =atomic_var
    mov x1, 42
    stur x1, [x10]

    ldxr x2, [x10]
    mov x3, 42
    cmp x2, x3
    b.ne bad_exit

    mov x4, 100
    stxr x5, x4, [x10]
    cmp x5, 0
    b.ne bad_exit

    ldur x6, [x10]
    mov x7, 100
    cmp x6, x7
    b.ne bad_exit

    ldxr x2, [x10]
    mov x4, 200
    stxr x5, x4, [x10]
    cmp x5, 0
    b.ne bad_exit

    ldur x6, [x10]
    mov x7, 200
    cmp x6, x7
    b.ne bad_exit

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
