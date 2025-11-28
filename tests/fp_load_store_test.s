.data
d_pi: .double 3.14159265358979
d_e: .double 2.71828182845905
d_zero: .double 0.0
d_neg: .double -123.456
d_large: .double 1.7976931348623157e+308
d_small: .double 2.2250738585072014e-308
d_arr: .double 10.0, 20.0, 30.0, 40.0
d_buf: .double 0.0, 0.0, 0.0, 0.0

s_pi: .float 3.14159
s_e: .float 2.71828
s_zero: .float 0.0
s_neg: .float -123.456
s_arr: .float 10.0, 20.0, 30.0, 40.0
s_buf: .float 0.0, 0.0, 0.0, 0.0

.text
.global _start
_start:
main:
    mov x0, 7

    ldur x10, =d_pi
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_arr
    ldurd d0, [x10]
    ldurd d1, [x10, 8]
    ldurd d2, [x10, 16]
    ldurd d3, [x10, 24]

    ldur x10, =d_buf
    sturd d0, [x10]
    sturd d1, [x10, 8]
    sturd d2, [x10, 16]
    sturd d3, [x10, 24]

    ldurd d4, [x10]
    ldurd d5, [x10, 8]
    ldurd d6, [x10, 16]
    ldurd d7, [x10, 24]

    fcmpd d0, d4
    b.ne bad_exit
    fcmpd d1, d5
    b.ne bad_exit
    fcmpd d2, d6
    b.ne bad_exit
    fcmpd d3, d7
    b.ne bad_exit

    ldur x10, =d_arr
    add x10, x10, 16
    ldurd d0, [x10, -8]
    ldur x10, =d_arr
    ldurd d1, [x10, 8]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_pi
    ldurd d0, [x10]
    ldur x10, =d_buf
    add x10, x10, 24
    sturd d0, [x10, -8]
    ldur x10, =d_buf
    ldurd d1, [x10, 16]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_zero
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_neg
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_large
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =d_small
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    ldur x10, =s_pi
    ldurs s0, [x10]
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit

    ldur x10, =s_arr
    ldurs s0, [x10]
    ldurs s1, [x10, 4]
    ldurs s2, [x10, 8]
    ldurs s3, [x10, 12]

    ldur x10, =s_buf
    sturs s0, [x10]
    sturs s1, [x10, 4]
    sturs s2, [x10, 8]
    sturs s3, [x10, 12]

    ldurs s4, [x10]
    ldurs s5, [x10, 4]
    ldurs s6, [x10, 8]
    ldurs s7, [x10, 12]

    fcmps s0, s4
    b.ne bad_exit
    fcmps s1, s5
    b.ne bad_exit
    fcmps s2, s6
    b.ne bad_exit
    fcmps s3, s7
    b.ne bad_exit

    ldur x10, =s_arr
    add x10, x10, 8
    ldurs s0, [x10, -4]
    ldur x10, =s_arr
    ldurs s1, [x10, 4]
    fcmps s0, s1
    b.ne bad_exit

    ldur x10, =s_zero
    ldurs s0, [x10]
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit

    ldur x10, =s_neg
    ldurs s0, [x10]
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit

    ldur x10, =d_pi
    ldurd d0, [x10]
    ldur x10, =d_e
    ldurd d1, [x10]
    faddd d2, d0, d1
    ldur x10, =d_buf
    sturd d2, [x10]
    ldurd d3, [x10]
    fcmpd d2, d3
    b.ne bad_exit

    ldur x10, =s_pi
    ldurs s0, [x10]
    ldur x10, =s_e
    ldurs s1, [x10]
    fadds s2, s0, s1
    ldur x10, =s_buf
    sturs s2, [x10]
    ldurs s3, [x10]
    fcmps s2, s3
    b.ne bad_exit

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
