.data
d_val1: .double 100.0
d_val2: .double 25.0
d_val4: .double 4.0
d_result: .double 0.0
s_val1: .float 50.0
s_val2: .float 10.0
s_val5: .float 5.0
s_result: .float 0.0

.text
.global _start
_start:
main:
    mov x0, 7
    mov x1, x0

    add x0, x0, 1234
    sub x0, x0, 1200
    sub x0, x0, 34

    mov x2, 0xffffffff
    mul x0, x0, x2
    udiv x0, x0, x2

    lsl x0, x0, 6
    lsl x0, x0, 6
    asr x0, x0, 3
    asr x0, x0, 9

    cmp x0, x1
    b.ne bad_exit

    ldur x10, =d_val1
    ldurd d0, [x10]
    ldur x10, =d_val2
    ldurd d1, [x10]
    ldur x10, =d_val4
    ldurd d2, [x10]

    faddd d3, d0, d1
    fsubd d3, d3, d1
    fcmpd d3, d0
    b.ne bad_exit

    fmuld d3, d0, d2
    fdivd d3, d3, d2
    fcmpd d3, d0
    b.ne bad_exit

    ldur x10, =s_val1
    ldurs s0, [x10]
    ldur x10, =s_val2
    ldurs s1, [x10]
    ldur x10, =s_val5
    ldurs s2, [x10]

    fadds s3, s0, s1
    fsubs s3, s3, s1
    fcmps s3, s0
    b.ne bad_exit

    fmuls s3, s0, s2
    fdivs s3, s3, s2
    fcmps s3, s0
    b.ne bad_exit

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
