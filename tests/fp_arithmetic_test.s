.data
d_2_0: .double 2.0
d_3_0: .double 3.0
d_4_0: .double 4.0
d_5_0: .double 5.0
d_6_0: .double 6.0
d_8_0: .double 8.0
d_10_0: .double 10.0
d_2_5: .double 2.5
d_0_5: .double 0.5
d_0_25: .double 0.25
d_0_75: .double 0.75
d_1_5: .double 1.5
d_0_1: .double 0.1
d_0_2: .double 0.2
d_0_3: .double 0.3
d_1_0: .double 1.0
d_0_0: .double 0.0
d_n1_0: .double -1.0
d_eps: .double 0.0000001
d_inf: .double Infinity

s_2_0: .float 2.0
s_3_0: .float 3.0
s_4_0: .float 4.0
s_5_0: .float 5.0
s_6_0: .float 6.0
s_8_0: .float 8.0
s_10_0: .float 10.0
s_2_5: .float 2.5
s_0_5: .float 0.5
s_0_1: .float 0.1
s_0_2: .float 0.2
s_0_3: .float 0.3
s_1_0: .float 1.0
s_0_0: .float 0.0
s_eps: .float 0.00001

.text
.global _start
_start:
main:
    mov x0, 7

    ldur x10, =d_2_0
    ldurd d0, [x10]
    ldur x10, =d_3_0
    ldurd d1, [x10]
    ldur x10, =d_5_0
    ldurd d2, [x10]
    faddd d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_8_0
    ldurd d0, [x10]
    ldur x10, =d_3_0
    ldurd d1, [x10]
    ldur x10, =d_5_0
    ldurd d2, [x10]
    fsubd d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_4_0
    ldurd d0, [x10]
    ldur x10, =d_2_5
    ldurd d1, [x10]
    ldur x10, =d_10_0
    ldurd d2, [x10]
    fmuld d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_10_0
    ldurd d0, [x10]
    ldur x10, =d_4_0
    ldurd d1, [x10]
    ldur x10, =d_2_5
    ldurd d2, [x10]
    fdivd d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_0_5
    ldurd d0, [x10]
    ldur x10, =d_0_25
    ldurd d1, [x10]
    ldur x10, =d_0_75
    ldurd d2, [x10]
    faddd d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_2_0
    ldurd d0, [x10]
    ldur x10, =d_3_0
    ldurd d1, [x10]
    ldur x10, =d_6_0
    ldurd d2, [x10]
    fmuld d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_0_1
    ldurd d0, [x10]
    ldur x10, =d_0_2
    ldurd d1, [x10]
    ldur x10, =d_0_3
    ldurd d2, [x10]
    ldur x10, =d_eps
    ldurd d4, [x10]
    faddd d3, d0, d1
    fsubd d5, d3, d2
    fsubd d6, d2, d3
    fcmpd d5, d4
    b.ge check_d7_neg
    b d7_ok
check_d7_neg:
    fcmpd d6, d4
    b.ge bad_exit
d7_ok:

    ldur x10, =d_1_0
    ldurd d0, [x10]
    ldur x10, =d_3_0
    ldurd d1, [x10]
    ldur x10, =d_eps
    ldurd d4, [x10]
    fdivd d2, d0, d1
    fmuld d3, d2, d1
    fsubd d5, d3, d0
    fsubd d6, d0, d3
    fcmpd d5, d4
    b.ge check_d8_neg
    b d8_ok
check_d8_neg:
    fcmpd d6, d4
    b.ge bad_exit
d8_ok:

    ldur x10, =d_1_0
    ldurd d0, [x10]
    ldur x10, =d_0_0
    ldurd d1, [x10]
    ldur x10, =d_inf
    ldurd d2, [x10]
    fdivd d3, d0, d1
    fcmpd d3, d2
    b.ne bad_exit

    ldur x10, =d_n1_0
    ldurd d0, [x10]
    ldur x10, =d_0_0
    ldurd d1, [x10]
    fdivd d3, d0, d1
    ldur x10, =d_0_0
    ldurd d4, [x10]
    fcmpd d3, d4
    b.ge bad_exit

    ldur x10, =d_0_0
    ldurd d0, [x10]
    ldurd d1, [x10]
    fdivd d3, d0, d1
    fcmpd d3, d3
    b.vc bad_exit

    ldur x10, =d_1_0
    ldurd d0, [x10]
    ldur x10, =d_0_0
    ldurd d1, [x10]
    fdivd d2, d0, d1
    fdivd d3, d0, d1
    fsubd d4, d2, d3
    fcmpd d4, d4
    b.vc bad_exit

    ldur x10, =s_2_0
    ldurs s0, [x10]
    ldur x10, =s_3_0
    ldurs s1, [x10]
    ldur x10, =s_5_0
    ldurs s2, [x10]
    fadds s3, s0, s1
    fcmps s3, s2
    b.ne bad_exit

    ldur x10, =s_8_0
    ldurs s0, [x10]
    ldur x10, =s_3_0
    ldurs s1, [x10]
    ldur x10, =s_5_0
    ldurs s2, [x10]
    fsubs s3, s0, s1
    fcmps s3, s2
    b.ne bad_exit

    ldur x10, =s_4_0
    ldurs s0, [x10]
    ldur x10, =s_2_5
    ldurs s1, [x10]
    ldur x10, =s_10_0
    ldurs s2, [x10]
    fmuls s3, s0, s1
    fcmps s3, s2
    b.ne bad_exit

    ldur x10, =s_10_0
    ldurs s0, [x10]
    ldur x10, =s_4_0
    ldurs s1, [x10]
    ldur x10, =s_2_5
    ldurs s2, [x10]
    fdivs s3, s0, s1
    fcmps s3, s2
    b.ne bad_exit

    ldur x10, =s_0_1
    ldurs s0, [x10]
    ldur x10, =s_0_2
    ldurs s1, [x10]
    ldur x10, =s_0_3
    ldurs s2, [x10]
    ldur x10, =s_eps
    ldurs s4, [x10]
    fadds s3, s0, s1
    fsubs s5, s3, s2
    fsubs s6, s2, s3
    fcmps s5, s4
    b.ge check_s5_neg
    b s5_ok
check_s5_neg:
    fcmps s6, s4
    b.ge bad_exit
s5_ok:

    ldur x10, =s_0_0
    ldurs s0, [x10]
    ldurs s1, [x10]
    fdivs s3, s0, s1
    fcmps s3, s3
    b.vc bad_exit

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
