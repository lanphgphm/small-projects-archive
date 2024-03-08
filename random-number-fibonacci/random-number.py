'''
this program contains 3 functions: 
    fibonacci(n):           generate fibonacci number at index n, helper to kotta()
    kotta():                the kotta algorithm in question 
    kotta_tester():         contains the necessary calculations to checks the 
                            validity / accuracy of the sequence kotta() generated 
    linear_congruential():  the linear congruential pseudo-random number generator, 
                            one of the most popular PRNGs used today 
'''
from cmath import sqrt

def fibonacci(n): 
    fib = [0] * n 
    fib[1] = 1 
    for i in range(2, n): 
        fib[i] = fib[i - 1] + fib[i - 2]
    return fib

def kotta():
    '''
    the kotta algorithm to generate pseudo-random number  

    parameters: 
        none
    
    outputs: 
        random-looking sequence, whose size is the input value n from user 

    variables: 
        a, c, m:    predefined numbers, constants in the given kotta formula
                    (m and a must be coprime)
        n :         number of elements wanted in the output sequence 
        f :         fibonacci sequence with n elements 
        x :         output sequence
    '''
    a = 5  
    c = 1
    m = 16
    n = eval(input("enter size of the sequence (cannot be negative): ")) 
    f = fibonacci(n)
    x = [0] * n
    # choose x[0] as seed, kotta says use random.randint() but we will ask user 
    # for seed value because it's kinda dumb to use random module 
    # in a random number generator
    x[0] = eval(input("enter seed value (cannot be 0): "))
    for i in range(0, n - 1):
        x[i + 1] = (a * x[i] + c + int(f[i] / x[0])) % m
    print(f"\nKOTTA PRNG\n\nValue of m: {m}\nSeed value: {x[0]}\n")
    print(f"Random number sequence: {x[1:]}")
    return x, n

def kotta_tester(): 
    '''
    function to test the accuracy(?) of kotta prng.   

    parameters: 
        none
    
    outputs: 
        a boolean value indicating the validity of the output of the kotta 
        algorithm 

    variables: 
        x1 :        a copy of x, to sort & find median 
        R :         number of runs in the LU sequence, capitalized to stay 
                    consistent with the paper 
        mean,var,Z: values used to check if the generated sequence satisfy the
                    p-value
    '''
    x, n = kotta()
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
        if i >= median: 
            lu.append('u')
    R = 1 # because runs = differences + 1
    for i in range(1, len(lu)):
        if lu[i] != lu[i - 1]:
            R = R + 1
    mean = ((n + 1) + 2) / 2
    var = ((n + 1) * ((n + 1) - 2)) / (4 * ((n + 1) - 1))
    Z = (R - mean) / (sqrt(var))
    absZ = abs(Z)
    if absZ < 1.96: 
        return True
    return False

def linear_congruential(): 
    '''
    the linear congruential algorithm to generate pseudo-random number  

    parameters: 
        none
    
    outputs: 
        random-looking sequence, whose size is the input value n from user 

    variables: 
        a, c, m:    predefined numbers, constants in the given kotta formula
                    (m and a must be coprime)
        n :         number of elements wanted in the output sequence 
        x :         array storing the generated values / output sequence 
        R :         number of runs in the LU sequence, capitalized to stay 
                    consistent with the paper 
        mean,var,Z: values used to check if the generated sequence satisfy the
                    p-value
    ''' 
    a = 5 
    c = 1 
    m = 16
    n = eval(input("enter size of sequence: "))
    x = [0] * n
    x[0] = eval(input("enter seed value (cannot be 0): "))
    for i in range(0, n - 1): 
        x[i + 1] = (a * x[i] + c) % m 
    print(f"\nLINEAR CONGRUENTIAL PRNG\n\nValue of m: {m}\nSeed value: {x[0]}\n")
    print(f"Random number sequence: {x[1:]}\n")
    return x

print("Please enter the same inputs both times you are asked to compare the differences between algorithms.")
n = kotta_tester()
print()
print(n)
linear_congruential()