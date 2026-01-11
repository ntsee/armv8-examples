.data
test_byte: .byte 127
test_hword: .hword 4660
test_word: .word 305419896
test_dword: .dword 1000000
string_test: .asciz "Hello"
string_len = . - string_test
buffer: .space 16

.text
.global _start
_start:
main:
    mov x0, 42
    cmp x0, 42
    b.ne bad_exit

    mov x1, 100
    mov x0, x1
    cmp x0, 100
    b.ne bad_exit

    mov x1, 10
    add x0, x1, 5
    cmp x0, 15
    b.ne bad_exit

    mov x1, 20
    mov x2, 30
    add x0, x1, x2
    cmp x0, 50
    b.ne bad_exit

    mov x1, 0
    adds x0, x1, 0
    b.ne bad_exit

    mov x1, -5
    adds x0, x1, 0
    b.pl bad_exit

    mov x1, 50
    sub x0, x1, 20
    cmp x0, 30
    b.ne bad_exit

    mov x1, 100
    mov x2, 40
    sub x0, x1, x2
    cmp x0, 60
    b.ne bad_exit

    mov x1, 5
    subs x0, x1, 5
    b.ne bad_exit

    mov x1, 5
    subs x0, x1, 10
    b.pl bad_exit

    mov x1, 7
    mov x2, 8
    mul x0, x1, x2
    cmp x0, 56
    b.ne bad_exit

    mov x1, 100
    mov x2, 10
    udiv x0, x1, x2
    cmp x0, 10
    b.ne bad_exit

    mov x1, 255
    and x0, x1, 15
    cmp x0, 15
    b.ne bad_exit

    mov x1, 240
    mov x2, 63
    and x0, x1, x2
    cmp x0, 48
    b.ne bad_exit

    mov x1, 240
    orr x0, x1, 15
    cmp x0, 255
    b.ne bad_exit

    mov x1, 170
    mov x2, 85
    orr x0, x1, x2
    cmp x0, 255
    b.ne bad_exit

    mov x1, 1
    lsl x0, x1, 4
    cmp x0, 16
    b.ne bad_exit

    mov x1, 64
    asr x0, x1, 3
    cmp x0, 8
    b.ne bad_exit

    ldur x10, =buffer
    mov x1, 12345678
    stur x1, [x10]
    ldur x0, [x10]
    cmp x0, 12345678
    b.ne bad_exit

    ldur x10, =test_byte
    ldurb x0, [x10]
    cmp x0, 127
    b.ne bad_exit

    ldur x10, =test_hword
    ldurh x0, [x10]
    cmp x0, 4660
    b.ne bad_exit

    ldur x10, =test_word
    ldursw x0, [x10]
    mov x1, 305419896
    cmp x0, x1
    b.ne bad_exit

    ldur x10, =buffer
    mov x1, 171
    sturb x1, [x10]
    ldurb x0, [x10]
    cmp x0, 171
    b.ne bad_exit

    ldur x10, =buffer
    mov x1, 52719
    sturh x1, [x10]
    ldurh x0, [x10]
    cmp x0, 52719
    b.ne bad_exit

    b skip_test
    b bad_exit
skip_test:

    mov x0, 5
    cmp x0, 5
    b.eq eq_pass
    b bad_exit
eq_pass:

    mov x0, 5
    cmp x0, 10
    b.ne ne_pass
    b bad_exit
ne_pass:

    mov x0, 5
    cmp x0, 10
    b.lt lt_pass
    b bad_exit
lt_pass:

    mov x0, 10
    cmp x0, 5
    b.gt gt_pass
    b bad_exit
gt_pass:

    mov x0, 5
    cmp x0, 5
    b.le le_pass
    b bad_exit
le_pass:

    mov x0, 5
    cmp x0, 5
    b.ge ge_pass
    b bad_exit
ge_pass:

    mov x0, 0
    cbz x0, cbz_pass
    b bad_exit
cbz_pass:

    mov x0, 1
    cbnz x0, cbnz_pass
    b bad_exit
cbnz_pass:

    bl test_func
    cmp x0, 99
    b.ne bad_exit
    b bl_done
test_func:
    mov x0, 99
    br lr
bl_done:

pass:
    mov x0, 7
    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
