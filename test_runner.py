import armsim

'''
Test runner for floating point support PR
Exit code in x0 for all test cases should be 7
'''

# Test basic integer functionality still works
print("Running arithmetic_test.s...")
with open('tests/arithmetic_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x0'] == 7, "arithmetic_test returned incorrect value of {}".format(armsim.reg['x0'])
print("  PASSED")
armsim.reset()

print("Running branch_test.s...")
with open('tests/branch_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x0'] == 7, "branch_test returned incorrect value of {}".format(armsim.reg['x0'])
print("  PASSED")
armsim.reset()

print("Running brk_test.s...")
with open('tests/brk_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x0'] == 7, "brk_test returned incorrect value of {}".format(armsim.reg['x0'])
print("  PASSED")
armsim.reset()

print("Running load_store_test.s...")
with open('tests/load_store_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x1'] == 189
assert armsim.reg['x2'] == -67
assert armsim.reg['x3'] == 65254
assert armsim.reg['x4'] == -282
assert armsim.reg['x5'] == -100000
assert armsim.reg['x6'] == -88
assert armsim.reg['x7'] == 168
assert armsim.reg['x9'] == -88
assert armsim.reg['x10'] == 65448
print("  PASSED")
armsim.reset()

# Floating point tests
print("Running fp_test.s...")
with open('tests/fp_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x0'] == 7, "fp_test returned incorrect value of {}".format(armsim.reg['x0'])
print("  PASSED")
armsim.reset()

print("\nAll tests passed!")
