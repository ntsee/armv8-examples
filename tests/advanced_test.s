.data
atomic_var: .dword 0

.text
.global _start
_start:
main:
    // MOVK tests
    mov x0, 0
    movk x0, 0x1234, lsl 0
    mov x1, 0x1234
    cmp x0, x1
    b.ne bad_exit

    mov x0, 0
    movk x0, 0x5678, lsl 16
    mov x1, 0x56780000
    cmp x0, x1
    b.ne bad_exit

    mov x0, 0
    movk x0, 0xABCD, lsl 32
    mov x1, 0xABCD00000000
    cmp x0, x1
    b.ne bad_exit

    mov x0, 0
    movk x0, 0xEF01, lsl 48
    mov x2, 0xEF01
    lsl x1, x2, 48
    cmp x0, x1
    b.ne bad_exit

    // MOVK combined - build 64-bit value
    mov x0, 0
    movk x0, 0x1111, lsl 0
    movk x0, 0x2222, lsl 16
    movk x0, 0x3333, lsl 32
    movk x0, 0x4444, lsl 48
    mov x1, 0x4444333322221111
    cmp x0, x1
    b.ne bad_exit

    // MOVK preserve - only modifies 16 bits
    mov x0, 0xFFFFFFFFFFFFFFFF
    movk x0, 0x0000, lsl 16
    mov x1, 0xFFFFFFFF0000FFFF
    cmp x0, x1
    b.ne bad_exit

    // UMULH tests - unsigned multiply high
    mov x1, 100
    mov x2, 100
    umulh x0, x1, x2
    cmp x0, 0
    b.ne bad_exit

    mov x1, 0x100000000
    mov x2, 0x100000000
    umulh x0, x1, x2
    cmp x0, 1
    b.ne bad_exit

    mov x1, 0x8000000000000000
    mov x2, 2
    umulh x0, x1, x2
    cmp x0, 1
    b.ne bad_exit

    // SMULH tests - signed multiply high
    mov x1, 2
    mov x2, 3
    smulh x0, x1, x2
    cmp x0, 0
    b.ne bad_exit

    mov x1, 0x4000000000000000
    mov x2, 4
    smulh x0, x1, x2
    cmp x0, 1
    b.ne bad_exit

    // LDXR/STXR tests - load/store exclusive
    ldur x10, =atomic_var
    mov x1, 42
    stur x1, [x10]
    ldxr x2, [x10]
    cmp x2, 42
    b.ne bad_exit

    // STXR success after LDXR
    ldur x10, =atomic_var
    mov x1, 100
    stur x1, [x10]
    ldxr x2, [x10]
    mov x3, 200
    stxr x4, x3, [x10]
    cmp x4, 0
    b.ne bad_exit
    ldur x5, [x10]
    cmp x5, 200
    b.ne bad_exit

    // Atomic increment pattern
    ldur x10, =atomic_var
    mov x1, 500
    stur x1, [x10]
    ldxr x2, [x10]
    add x3, x2, 1
    stxr x4, x3, [x10]
    cmp x4, 0
    b.ne bad_exit
    ldur x5, [x10]
    cmp x5, 501
    b.ne bad_exit

pass:
    mov x0, 7
    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
