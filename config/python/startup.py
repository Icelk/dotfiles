import math
from math import *

def lg(exp):
    return log(exp, 10)
def ln(exp):
    return log(exp, e)

def quad(a, b, c):
    def sqrt_cpx(a):
        return a**(1/2)
    root1 = (-b + sqrt_cpx(b**2 - 4*a*c)) / (2*a)
    root2 = (-b - sqrt_cpx(b**2 - 4*a*c)) / (2*a)
    same_distance_limit = abs(root1 * 1e-4)
    if (abs(root1 - root2) < same_distance_limit):
        return [root1]
    else:
        return [root1, root2]

g=9.8
atm=101.3e3
