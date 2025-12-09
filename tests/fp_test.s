.data
// Double-precision test values for load/store
// 1. Positive precisely representable: 1.5 (exact in IEEE754)
d_pos_precise: .double 1.5
// 2. Negative precisely representable: -2.25 (exact in IEEE754)
d_neg_precise: .double -2.25
// 3. Positive NOT precisely representable: 0.1 (repeating in binary)
d_pos_imprecise: .double 0.1
// 4. Negative NOT precisely representable: -0.3 (repeating in binary)
d_neg_imprecise: .double -0.3

// Single-precision test values for load/store
// 1. Positive precisely representable: 0.25 (exact in IEEE754)
s_pos_precise: .float 0.25
// 2. Negative precisely representable: -0.125 (exact in IEEE754)
s_neg_precise: .float -0.125
// 3. Positive NOT precisely representable: 0.1 (repeating in binary)
s_pos_imprecise: .float 0.1
// 4. Negative NOT precisely representable: -0.7 (repeating in binary)
s_neg_imprecise: .float -0.7

// Result storage
d_result: .double 0.0
s_result: .float 0.0

// Arithmetic test values (fractional)
d_a: .double 3.75
d_b: .double 1.25
d_sum: .double 5.0
d_diff: .double 2.5
d_prod: .double 4.6875
d_quot: .double 3.0

s_a: .float 2.5
s_b: .float 0.5
s_sum: .float 3.0
s_diff: .float 2.0
s_prod: .float 1.25
s_quot: .float 5.0

// Comparison test values
d_smaller: .double 1.5
d_larger: .double 2.5
d_equal1: .double 3.14159
d_equal2: .double 3.14159

s_smaller: .float 0.75
s_larger: .float 1.75
s_equal1: .float 2.718
s_equal2: .float 2.718

.text
.global _start
_start:
main:
    // ========================================
    // DOUBLE LOAD/STORE TESTS
    // ========================================
    
    // Test 1: Load positive precisely representable double
    ldur x10, =d_pos_precise
    ldurd d0, [x10]
    // Store and reload to verify
    ldur x11, =d_result
    sturd d0, [x11]
    ldurd d1, [x11]
    // Compare d0 and d1 (should be equal)
    fcmpd d0, d1
    b.ne bad_exit
    
    // Test 2: Load negative precisely representable double
    ldur x10, =d_neg_precise
    ldurd d0, [x10]
    sturd d0, [x11]
    ldurd d1, [x11]
    fcmpd d0, d1
    b.ne bad_exit
    
    // Test 3: Load positive imprecisely representable double
    ldur x10, =d_pos_imprecise
    ldurd d0, [x10]
    sturd d0, [x11]
    ldurd d1, [x11]
    fcmpd d0, d1
    b.ne bad_exit
    
    // Test 4: Load negative imprecisely representable double
    ldur x10, =d_neg_imprecise
    ldurd d0, [x10]
    sturd d0, [x11]
    ldurd d1, [x11]
    fcmpd d0, d1
    b.ne bad_exit
    
    // ========================================
    // SINGLE LOAD/STORE TESTS
    // ========================================
    
    // Test 5: Load positive precisely representable float
    ldur x10, =s_pos_precise
    ldurs s0, [x10]
    ldur x11, =s_result
    sturs s0, [x11]
    ldurs s1, [x11]
    fcmps s0, s1
    b.ne bad_exit
    
    // Test 6: Load negative precisely representable float
    ldur x10, =s_neg_precise
    ldurs s0, [x10]
    sturs s0, [x11]
    ldurs s1, [x11]
    fcmps s0, s1
    b.ne bad_exit
    
    // Test 7: Load positive imprecisely representable float
    ldur x10, =s_pos_imprecise
    ldurs s0, [x10]
    sturs s0, [x11]
    ldurs s1, [x11]
    fcmps s0, s1
    b.ne bad_exit
    
    // Test 8: Load negative imprecisely representable float
    ldur x10, =s_neg_imprecise
    ldurs s0, [x10]
    sturs s0, [x11]
    ldurs s1, [x11]
    fcmps s0, s1
    b.ne bad_exit
    
    // ========================================
    // DOUBLE ARITHMETIC TESTS (fractional)
    // ========================================
    
    // FADDD: 3.75 + 1.25 = 5.0
    ldur x10, =d_a
    ldurd d0, [x10]
    ldur x10, =d_b
    ldurd d1, [x10]
    faddd d2, d0, d1
    ldur x10, =d_sum
    ldurd d3, [x10]
    fcmpd d2, d3
    b.ne bad_exit
    
    // FSUBD: 3.75 - 1.25 = 2.5
    ldur x10, =d_a
    ldurd d0, [x10]
    ldur x10, =d_b
    ldurd d1, [x10]
    fsubd d2, d0, d1
    ldur x10, =d_diff
    ldurd d3, [x10]
    fcmpd d2, d3
    b.ne bad_exit
    
    // FMULD: 3.75 * 1.25 = 4.6875
    ldur x10, =d_a
    ldurd d0, [x10]
    ldur x10, =d_b
    ldurd d1, [x10]
    fmuld d2, d0, d1
    ldur x10, =d_prod
    ldurd d3, [x10]
    fcmpd d2, d3
    b.ne bad_exit
    
    // FDIVD: 3.75 / 1.25 = 3.0
    ldur x10, =d_a
    ldurd d0, [x10]
    ldur x10, =d_b
    ldurd d1, [x10]
    fdivd d2, d0, d1
    ldur x10, =d_quot
    ldurd d3, [x10]
    fcmpd d2, d3
    b.ne bad_exit
    
    // ========================================
    // SINGLE ARITHMETIC TESTS (fractional)
    // ========================================
    
    // FADDS: 2.5 + 0.5 = 3.0
    ldur x10, =s_a
    ldurs s0, [x10]
    ldur x10, =s_b
    ldurs s1, [x10]
    fadds s2, s0, s1
    ldur x10, =s_sum
    ldurs s3, [x10]
    fcmps s2, s3
    b.ne bad_exit
    
    // FSUBS: 2.5 - 0.5 = 2.0
    ldur x10, =s_a
    ldurs s0, [x10]
    ldur x10, =s_b
    ldurs s1, [x10]
    fsubs s2, s0, s1
    ldur x10, =s_diff
    ldurs s3, [x10]
    fcmps s2, s3
    b.ne bad_exit
    
    // FMULS: 2.5 * 0.5 = 1.25
    ldur x10, =s_a
    ldurs s0, [x10]
    ldur x10, =s_b
    ldurs s1, [x10]
    fmuls s2, s0, s1
    ldur x10, =s_prod
    ldurs s3, [x10]
    fcmps s2, s3
    b.ne bad_exit
    
    // FDIVS: 2.5 / 0.5 = 5.0
    ldur x10, =s_a
    ldurs s0, [x10]
    ldur x10, =s_b
    ldurs s1, [x10]
    fdivs s2, s0, s1
    ldur x10, =s_quot
    ldurs s3, [x10]
    fcmps s2, s3
    b.ne bad_exit
    
    // ========================================
    // DOUBLE COMPARISON TESTS
    // ========================================
    
    // Test FCMPD less than
    ldur x10, =d_smaller
    ldurd d0, [x10]
    ldur x10, =d_larger
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ge bad_exit
    
    // Test FCMPD greater than
    ldur x10, =d_larger
    ldurd d0, [x10]
    ldur x10, =d_smaller
    ldurd d1, [x10]
    fcmpd d0, d1
    b.le bad_exit
    
    // Test FCMPD equal
    ldur x10, =d_equal1
    ldurd d0, [x10]
    ldur x10, =d_equal2
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit
    
    // ========================================
    // SINGLE COMPARISON TESTS
    // ========================================
    
    // Test FCMPS less than
    ldur x10, =s_smaller
    ldurs s0, [x10]
    ldur x10, =s_larger
    ldurs s1, [x10]
    fcmps s0, s1
    b.ge bad_exit
    
    // Test FCMPS greater than
    ldur x10, =s_larger
    ldurs s0, [x10]
    ldur x10, =s_smaller
    ldurs s1, [x10]
    fcmps s0, s1
    b.le bad_exit
    
    // Test FCMPS equal
    ldur x10, =s_equal1
    ldurs s0, [x10]
    ldur x10, =s_equal2
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit
    
    // ========================================
    // LOAD WITH OFFSET TESTS
    // ========================================
    
    // Test LDURD with offset
    ldur x10, =d_pos_precise
    ldurd d0, [x10, 8]
    ldur x10, =d_neg_precise
    ldurd d1, [x10]
    fcmpd d0, d1
    b.ne bad_exit
    
    // Test LDURS with offset
    ldur x10, =s_pos_precise
    ldurs s0, [x10, 4]
    ldur x10, =s_neg_precise
    ldurs s1, [x10]
    fcmps s0, s1
    b.ne bad_exit

pass:
    mov x0, 7
    mov x8, 93
    svc 0

bad_exit:
    mov x0, -1
    mov x8, 93
    svc 0
