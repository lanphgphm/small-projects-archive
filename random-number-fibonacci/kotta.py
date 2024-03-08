from cmath import sqrt 
from decimal import * 

def fibonacci(n): 
    fib = [0] * n 
    fib[1] = 1 
    for i in range(2, n): 
        fib[i] = fib[i - 1] + fib[i - 2]
    return fib

def kotta():
    a = 5  
    c = 1
    m = 16
    n = eval(input("enter size of the sequence (cannot be negative): ")) 
    f = fibonacci(n)
    x = [0] * n
    # choose x[0] as seed, kotta says use random.randint()
    # but we will ask user for seed value
    # because it's kinda dumb to use random.randint() in a random number generator
    x[0] = eval(input("enter seed value (cannot be 0): "))
    for i in range(0, n - 1):
        x[i + 1] = (a * x[i] + c + int(f[i] / x[0])) % m
    # checking accuracy 
    x1 = x.copy()
    x1.sort() 
    if (n + 1) % 2 == 0: 
        median = (x1[int((n + 1)/2)] + x1[int(((n + 1)/2)) + 1]) / 2 
    elif (n + 1) % 2 == 1: 
        median = x1[int(((n + 1) + 1)/ 2)] 
    lu = []
    for i in x: 
        if i < median: 
            lu.append('l')
        elif i >= median: 
            lu.append('u')
    R = 1 # because runs = differences + 1
    for i in range(1, len(lu)):
        if lu[i] != lu[i - 1]:
            R = R + 1
    mean = ((n + 1) + 2) / 2
    var = ((n + 1) * ((n + 1) - 2)) / (4 * ((n + 1) - 1))
    Z = (R - mean) / (sqrt(var))
    absZ = abs(Z)
    print(f"KOTTA PRNG\nValue of m: {m}\nSeed value: {x[0]}")
    print(f"Random number sequence: {x[1:]}")
    # print(f"Median: {median}\nLU sequence: {lu}\nNumber of runs: {R}, mean E(R) = {mean}, variance = {var}")
    if absZ < 1.96: 
        return True
    return False 

n = kotta()
# print(f"|Z| < 1.96? {n}")