import numpy as np

S = np.diag([1.0, -0.5, -0.5])
u1 = np.array([1.0, 0.0, 0.0])
u2 = np.array([0.0, 1.0, 0.0])

R1 = 0.5 * np.dot(u1, u1)
R2 = 0.5 * np.dot(u2, u2)
Pi1 = -u1 @ S @ u1
Pi2 = -u2 @ S @ u2

print(f"R1={R1} R2={R2} Pi1={Pi1} Pi2={Pi2}")
print(f"B2.9 matrix obstruction: R1==R2={R1 == R2} Pi1!=Pi2={Pi1 != Pi2}")

assert np.trace(S) == 0.0
assert R1 == R2
assert Pi1 != Pi2
