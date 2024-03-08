# Pseudo-random number generator using Fibonacci numbers 

One of the most well known algorithms for generating pseudorandom numbers is the linear congruential method, defined by the following formula:

$$ N_i ≡ aN_i−1 + c (mod m) $$ 

which generates a string of pseudorandom numbers, where $$m$$ is the modulus, $$a$$ the multiplier, $$c$$ the increment, and $$N_0$$ the seed.

However the problem with linear congruential generators is cyclicity - under suboptimal choices of $$a, c, m$$ and the seed, the algorithm can yield only short cycles
of “random” numbers that are somewhat predictable.

Kotta and Soubhik utilized the Fibonacci numbers to remove cyclicity and thus make the generated number appears more random.  The article by Kotta and Soubhik can be found here: http://www.ascent-journals.com/IJMSEA/Vol11No1/18-kotta.pdf

This is a program that implements both linear congruential generator and the new method. 