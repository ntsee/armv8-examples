.data
d_small: .double 5.0
d_large: .double 10.0
d_equal: .double 7.0
d_neg: .double -5.0
d_zero: .double 0.0
d_nan: .double NaN

s_small: .float 5.0
s_large: .float 10.0
s_equal: .float 7.0
s_neg: .float -5.0
s_zero: .float 0.0
s_nan: .float NaN

.text
.global _start
_start:
main:
    mov x0, 7

    ldur x10, =d_equal
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit

    fcmpd d0, d1
    b.eq L1
    b bad_exit
L1:
    fcmpd d0, d1
    b.le L2
    b bad_exit
L2:
    fcmpd d0, d1
    b.ge L3
    b bad_exit
L3:

    ldur x10, =d_small
    ldurd d0, [x10]
    ldur x10, =d_large
    ldurd d1, [x10]
    fcmpd d0, d1
    b.lt L4
    b bad_exit
L4:
    fcmpd d0, d1
    b.le L5
    b bad_exit
L5:
    fcmpd d0, d1
    b.ne L6
    b bad_exit
L6:
    fcmpd d0, d1
    b.mi L7
    b bad_exit
L7:

    fcmpd d1, d0
    b.gt L8
    b bad_exit
L8:
    fcmpd d1, d0
    b.ge L9
    b bad_exit
L9:
    fcmpd d1, d0
    b.pl L10
    b bad_exit
L10:

    ldur x10, =d_zero
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.pl L11
    b bad_exit
L11:

    ldur x10, =d_nan
    ldurd d0, [x10]
    ldur x10, =d_large
    ldurd d1, [x10]
    fcmpd d0, d1
    b.vs L12
    b bad_exit
L12:

    fcmpd d1, d0
    b.vs L13
    b bad_exit
L13:

    ldur x10, =d_small
    ldurd d0, [x10]
    ldur x10, =d_large
    ldurd d1, [x10]
    fcmpd d0, d1
    b.vc L14
    b bad_exit
L14:

    ldur x10, =d_equal
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.lt bad_exit
    fcmpd d0, d1
    b.gt bad_exit

    ldur x10, =s_equal
    ldurs s0, [x10]
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit

    fcmps s0, s1
    b.eq L15
    b bad_exit
L15:
    fcmps s0, s1
    b.le L16
    b bad_exit
L16:
    fcmps s0, s1
    b.ge L17
    b bad_exit
L17:

    ldur x10, =s_small
    ldurs s0, [x10]
    ldur x10, =s_large
    ldurs s1, [x10]
    fcmps s0, s1
    b.lt L18
    b bad_exit
L18:
    fcmps s0, s1
    b.le L19
    b bad_exit
L19:
    fcmps s0, s1
    b.ne L20
    b bad_exit
L20:

    fcmps s1, s0
    b.gt L21
    b bad_exit
L21:
    fcmps s1, s0
    b.ge L22
    b bad_exit
L22:

    ldur x10, =s_nan
    ldurs s0, [x10]
    ldur x10, =s_large
    ldurs s1, [x10]
    fcmps s0, s1
    b.vs L23
    b bad_exit
L23:

    ldur x10, =s_small
    ldurs s0, [x10]
    ldur x10, =s_large
    ldurs s1, [x10]
    fcmps s0, s1
    b.vc L24
    b bad_exit
L24:

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
