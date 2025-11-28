.data
d_small: .double 5.0
d_large: .double 10.0
d_equal: .double 7.0
d_nan: .double NaN
s_small: .float 5.0
s_large: .float 10.0
s_equal: .float 7.0
s_nan: .float NaN

.text
.global _start
_start:
main:
    mov x0, 7

    mov x1, 7
    cmp x0, x1
    b.le L1
    b bad_exit
L1:
    b.ge L2
    b bad_exit
L2:
    b.eq L3
    b bad_exit
L3:
    mov x1, 8
    cmp x0, x1
    b.lt L4
    b bad_exit
L4:
    b.le L5
    b bad_exit
L5:
    b.ne L6
    b bad_exit
L6:
    mov x1, 6
    cmp x0, x1
    b.gt L7
    b bad_exit
L7:
    b.ge L8
    b bad_exit
L8:
    b.ne L9
    b bad_exit
L9:
    mov x1, 8
    subs x2, x0, x1
    b.mi L10
    b bad_exit
L10:
    adds x2, x0, x1
    subs x2, x1, x0
    b.pl L11
    b bad_exit
L11:
    subs x2, x0, 7
    b.pl L12
    b bad_exit
L12:
    subs x1, x0, 7
    cbz x1, L13
    b bad_exit
L13:
    subs x1, x0, 6
    cbnz x1, L14
    b bad_exit
L14:

    ldur x10, =d_equal
    ldurd d0, [x10]
    ldurd d1, [x10]
    fcmpd d0, d1
    b.eq L15
    b bad_exit
L15:
    b.le L16
    b bad_exit
L16:
    b.ge L17
    b bad_exit
L17:
    ldur x10, =d_small
    ldurd d0, [x10]
    ldur x10, =d_large
    ldurd d1, [x10]
    fcmpd d0, d1
    b.lt L18
    b bad_exit
L18:
    b.le L19
    b bad_exit
L19:
    b.ne L20
    b bad_exit
L20:
    fcmpd d1, d0
    b.gt L21
    b bad_exit
L21:
    b.ge L22
    b bad_exit
L22:
    ldur x10, =d_nan
    ldurd d0, [x10]
    ldur x10, =d_large
    ldurd d1, [x10]
    fcmpd d0, d1
    b.vs L23
    b bad_exit
L23:
    ldur x10, =d_small
    ldurd d0, [x10]
    fcmpd d0, d1
    b.vc L24
    b bad_exit
L24:

    ldur x10, =s_equal
    ldurs s0, [x10]
    ldurs s1, [x10]
    fcmps s0, s1
    b.eq L25
    b bad_exit
L25:
    ldur x10, =s_small
    ldurs s0, [x10]
    ldur x10, =s_large
    ldurs s1, [x10]
    fcmps s0, s1
    b.lt L26
    b bad_exit
L26:
    fcmps s1, s0
    b.gt L27
    b bad_exit
L27:
    ldur x10, =s_nan
    ldurs s0, [x10]
    ldur x10, =s_large
    ldurs s1, [x10]
    fcmps s0, s1
    b.vs L28
    b bad_exit
L28:
    ldur x10, =s_small
    ldurs s0, [x10]
    fcmps s0, s1
    b.vc L29
    b bad_exit
L29:

    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
