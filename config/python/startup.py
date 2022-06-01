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
    same_distance_limit = (abs(root1) + 0.1) * 1e-4
    if (abs(root1 - root2) < same_distance_limit):
        return [root1]
    else:
        return [root1, root2]

def sind(v):
    return sin(radians(v))

def cosd(v):
    return cos(radians(v))

def tand(v):
    return tan(radians(v))

def asind(x):
    v=degrees(asin(x))
    return [v, 180-v]

def acosd(x):
    v=degrees(acos(x))
    return [v, 360-v]

def atand(x):
    v=degrees(atan(x))
    return [v, 360-v]

def cos_law(b, c, A):
    return sqrt(b**2+c**2-2*b*c*cosd(A))

g=9.8
atm=101.3e3
