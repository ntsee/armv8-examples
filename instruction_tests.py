import armsim
'''
This procedure executes a single line in isolation and puts the result
(if any) in x0. This is checked against the result parameter. "Isolation"
means that we assume that we can't use the results in one test in another test
Thus the branch instructions can't be tested with this procedure.
Up to 3 values can be passed in to put into operand registers. These will
go in x1, x2, and x3. Additionally arguments for flags can be passed in.
Note that more complex instructions (i.e. ones that hit memory or ones
with dependencies on prior sequences will be tested with integration tests
'''
def check(line:str, result:int, x1=0,x2=0,x3=0, zeroFlag = False, negFlag = False):
	armsim.reg['x1'] = x1; armsim.reg['x2'] = x2; armsim.reg['x3'] = x3;
	armsim.execute(line)
	assert armsim.reg['x0'] == result, \
	"Expected result {} not equal to actual result {}\n\tLine executed: {}".format(result,armsim.reg['x0'],line)
	assert armsim.z_flag == zeroFlag, "Zero flag should not be {} after executing {}".format(zeroFlag,line) 
	assert armsim.n_flag == negFlag, "Negative flag should not be {} after executing {}".format(negFlag,line)
	armsim.reset()

def checkfp_double(line:str, result:float, d1=0.0, d2=0.0, d3=0.0, epsilon=1e-10):
	armsim.fp_reg['d1'] = d1; armsim.fp_reg['d2'] = d2; armsim.fp_reg['d3'] = d3;
	armsim.execute(line)
	actual = armsim.fp_reg['d0']
	assert abs(actual - result) < epsilon, \
	"Expected result {} not equal to actual result {}\n\tLine executed: {}".format(result, actual, line)
	armsim.reset()

def checkfp_single(line:str, result:float, s1=0.0, s2=0.0, s3=0.0, epsilon=1e-5):
	armsim.set_s_register('s1', s1)
	armsim.set_s_register('s2', s2)
	armsim.set_s_register('s3', s3)
	armsim.execute(line)
	actual = armsim.get_s_register('s0')
	assert abs(actual - result) < epsilon, \
	"Expected result {} not equal to actual result {}\n\tLine executed: {}".format(result, actual, line)
	armsim.reset()

def checkfp_cmp(line:str, d1:float, d2:float, expected_z:bool, expected_n:bool, expected_v:bool):
	armsim.fp_reg['d1'] = d1; armsim.fp_reg['d2'] = d2;
	armsim.execute(line)
	assert armsim.z_flag == expected_z, "Z flag should be {} after executing {}".format(expected_z, line)
	assert armsim.n_flag == expected_n, "N flag should be {} after executing {}".format(expected_n, line)
	assert armsim.v_flag == expected_v, "V flag should be {} after executing {}".format(expected_v, line)
	armsim.reset()

def checkfp_cmps(line:str, s1:float, s2:float, expected_z:bool, expected_n:bool, expected_v:bool):
	armsim.set_s_register('s1', s1)
	armsim.set_s_register('s2', s2)
	armsim.execute(line)
	assert armsim.z_flag == expected_z, "Z flag should be {} after executing {}".format(expected_z, line)
	assert armsim.n_flag == expected_n, "N flag should be {} after executing {}".format(expected_n, line)
	assert armsim.v_flag == expected_v, "V flag should be {} after executing {}".format(expected_v, line)
	armsim.reset()

check('mov x0, #1',result = 1)
check('mov x0, x1',result = 1, x1 = 1)
check('add x0, x1, x1', result = 2, x1 = 1)
check('adds x0, x1, x1', result = 0, x1 = 0, zeroFlag = True)
check('adds x0, x1, x1', result = -2, x1 = -1, negFlag = True)
check('add x0, x1, #1', result = 2, x1 = 1)
check('adds x0, x1, #0', result = 0, x1 = 0, zeroFlag = True)
check('adds x0, x1, #-1', result = -2, x1 = -1, negFlag = True)
check('sub x0, x1, x2', result = 1, x1 = 2, x2 = 1)
check('subs x0, x1, x1', result = 0, x1 = 1, zeroFlag = True)
check('subs x0, x1, x2', result = -1, x1 = 1, x2 = 2, negFlag = True)
check('sub x0, x1, #1', result = 1, x1 = 2)
check('subs x0, x1, #1', result = 0, x1 = 1, zeroFlag = True)
check('subs x0, x1, #2', result = -1, x1 = 1, negFlag = True)
check('and x0, x1, #1', result = 1, x1 = 1)
check('ands x0, x1, 0', result = 0, x1 = 99, zeroFlag = True)
check('and x0, x1, x2', result = 1, x1 = 1, x2 = 1)
check('ands x0, x1, x2', result = 0, x1 = 99, x2 = 0, zeroFlag = True)
check('orr x0, x1, #1', result = 3, x1 = 2)
check('orrs x0, x1, 0', result = 0, x1 = 0, zeroFlag = True)
check('orr x0, x1, x2', result = 3, x1 = 2, x2 = 1)
check('orrs x0, x1, x2', result = 0, x1 = 0, x2 = 0, zeroFlag = True)
check('asr x0, x1, #1', result = 1, x1 = 2)
check('asr x0, x1, #6', result = 1, x1 = 64)
check('lsl x0, x1, #1', result = 2, x1 = 1)
check('lsl x0, x1, #3', result = 80, x1 = 10)
check('mul x0, x1, x1', result = 100, x1 = 10)
check('udiv x0, x1, x2', result = 10, x1 = 100, x2 = 10)
check('udiv x0, x1, x2', result = 10, x1 = 101, x2 = 10)
check('cmp x1, #1',result = 0, x1 = 0, zeroFlag = False, negFlag = True)
check('cmp x1, #1',result = 0, x1 = 1, zeroFlag = True, negFlag = False)
check('cmp x1, #1',result = 0, x1 = 2, zeroFlag = False, negFlag = False)

check('movk x0, 0x1234, lsl 0', result = 0x1234, x1 = 0)
check('movk x0, 0x5678, lsl 16', result = 0x56780000, x1 = 0)

check('smulh x0, x1, x2', result = 0, x1 = 2, x2 = 3)
check('smulh x0, x1, x2', result = 1, x1 = 0x4000000000000000, x2 = 4)

check('umulh x0, x1, x2', result = 0, x1 = 100, x2 = 100)
check('umulh x0, x1, x2', result = 1, x1 = 0x100000000, x2 = 0x100000000)

checkfp_double('faddd d0, d1, d2', result = 5.0, d1 = 2.0, d2 = 3.0)
checkfp_double('faddd d0, d1, d2', result = 0.0, d1 = -1.0, d2 = 1.0)
checkfp_double('faddd d0, d1, d2', result = 0.75, d1 = 0.5, d2 = 0.25)

checkfp_double('fsubd d0, d1, d2', result = 5.0, d1 = 8.0, d2 = 3.0)
checkfp_double('fsubd d0, d1, d2', result = -2.0, d1 = 1.0, d2 = 3.0)
checkfp_double('fsubd d0, d1, d2', result = 0.0, d1 = 1.0, d2 = 1.0)

checkfp_double('fmuld d0, d1, d2', result = 6.0, d1 = 2.0, d2 = 3.0)
checkfp_double('fmuld d0, d1, d2', result = 10.0, d1 = 4.0, d2 = 2.5)
checkfp_double('fmuld d0, d1, d2', result = -6.0, d1 = -2.0, d2 = 3.0)

checkfp_double('fdivd d0, d1, d2', result = 2.5, d1 = 10.0, d2 = 4.0)
checkfp_double('fdivd d0, d1, d2', result = 2.0, d1 = 6.0, d2 = 3.0)
checkfp_double('fdivd d0, d1, d2', result = -2.0, d1 = 6.0, d2 = -3.0)

checkfp_single('fadds s0, s1, s2', result = 5.0, s1 = 2.0, s2 = 3.0)
checkfp_single('fadds s0, s1, s2', result = 0.0, s1 = -1.0, s2 = 1.0)
checkfp_single('fadds s0, s1, s2', result = 0.75, s1 = 0.5, s2 = 0.25)

checkfp_single('fsubs s0, s1, s2', result = 5.0, s1 = 8.0, s2 = 3.0)
checkfp_single('fsubs s0, s1, s2', result = -2.0, s1 = 1.0, s2 = 3.0)
checkfp_single('fsubs s0, s1, s2', result = 0.0, s1 = 1.0, s2 = 1.0)

checkfp_single('fmuls s0, s1, s2', result = 6.0, s1 = 2.0, s2 = 3.0)
checkfp_single('fmuls s0, s1, s2', result = 10.0, s1 = 4.0, s2 = 2.5)
checkfp_single('fmuls s0, s1, s2', result = -6.0, s1 = -2.0, s2 = 3.0)

checkfp_single('fdivs s0, s1, s2', result = 2.5, s1 = 10.0, s2 = 4.0)
checkfp_single('fdivs s0, s1, s2', result = 2.0, s1 = 6.0, s2 = 3.0)
checkfp_single('fdivs s0, s1, s2', result = -2.0, s1 = 6.0, s2 = -3.0)

checkfp_cmp('fcmpd d1, d2', d1 = 5.0, d2 = 5.0, expected_z = True, expected_n = False, expected_v = False)
checkfp_cmp('fcmpd d1, d2', d1 = 3.0, d2 = 5.0, expected_z = False, expected_n = True, expected_v = False)
checkfp_cmp('fcmpd d1, d2', d1 = 7.0, d2 = 5.0, expected_z = False, expected_n = False, expected_v = False)
checkfp_cmp('fcmpd d1, d2', d1 = float('nan'), d2 = 5.0, expected_z = False, expected_n = False, expected_v = True)

checkfp_cmps('fcmps s1, s2', s1 = 5.0, s2 = 5.0, expected_z = True, expected_n = False, expected_v = False)
checkfp_cmps('fcmps s1, s2', s1 = 3.0, s2 = 5.0, expected_z = False, expected_n = True, expected_v = False)
checkfp_cmps('fcmps s1, s2', s1 = 7.0, s2 = 5.0, expected_z = False, expected_n = False, expected_v = False)
checkfp_cmps('fcmps s1, s2', s1 = float('nan'), s2 = 5.0, expected_z = False, expected_n = False, expected_v = True)

print("All instruction tests passed")
