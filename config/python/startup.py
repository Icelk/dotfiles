import math
from math import *

def choose(n, r):
    return factorial(n)//(factorial(n-r)*factorial(r))

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
c=299792458
# Imprecise when using floats (c**2)
c2=c*c
kg_per_u=1.6605390666050e-27
avogadro=6.02214076e23
mev_per_u=931.4941024228
me=0.000548580
mp=1.00727655
mn=1.00866492
boltzmann=1.380649e-23
elementary_charge=1.602176634e-19
planck=6.62607015e-34

def u_to_J(u):
    return u * kg_per_u * c2
def mev_to_J(Q):
    return u_to_J(Q/mev_per_u)
