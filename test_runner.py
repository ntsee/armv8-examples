import armsim

'''
Test runner for advanced instructions PR
Tests: MOVK, SMULH, UMULH, LDXR, STXR
Exit code in x0 should be 7
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

print("Running load_store_test.s...")
with open('tests/load_store_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x1'] == 189
assert armsim.reg['x2'] == -67
assert armsim.reg['x3'] == 65254
print("  PASSED")
armsim.reset()

# Advanced instructions test
print("Running advanced_test.s...")
with open('tests/advanced_test.s', 'r') as f:
    armsim.parse(f.readlines())
armsim.run()
assert armsim.reg['x0'] == 7, "advanced_test returned incorrect value of {}".format(armsim.reg['x0'])
print("  PASSED")
armsim.reset()

print("\nAll tests passed!")
