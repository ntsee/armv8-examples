.text
.global _start
_start:
main:
    mov x0, 7

    mov x0, 0
    mov x8, 214
    svc 0
    mov x10, x0

    mov x0, x10
    add x0, x0, 4096
    mov x8, 214
    svc 0

    cmp x0, x10
    b.le bad_exit

    mov x0, 7
    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
