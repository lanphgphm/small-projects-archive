def linear_congruential():  
    '''
    a :     int multiplier  (0 < a < m)
    c :     int increment   (0 <= c < m)
    m :     int modulo      (m > 0)
    x[0]:   int seed        (0 <= x[0] < m)
    n :     int size of the output sequence 
    x :     the output sequence
    '''
    a = 5 
    c = 1 
    m = 16
    n = eval(input("enter size of sequence: "))
    x = [0] * n
    x[0] = eval(input("enter seed value (cannot be 0): "))
    for i in range(0, n - 1): 
        x[i + 1] = (a * x[i] + c) % m 
    print(f"LINEAR CONGRUENTIAL PRNG\nValue of m: {m}\nSeed value: {x[0]}")
    print(f"Random number sequence: {x[1:]}")
    return x

linear_congruential()