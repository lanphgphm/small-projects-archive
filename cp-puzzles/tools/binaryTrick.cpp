// if bit at position k is set then 
a&(1<<k)==1

// if a even then (if last bit is not set)
a&1==0

// check if number a is power of 2 
a&(a-1)==0 

// 2^k 
1<<k 
// multiply a by 2^k
a<<k 

// 1/(2^k) 
1>>k 
// divide a by power of 2 
a>>k 

// addition is the same as OR gate 
a + b = a | b 

// other tricks 
// quickest way to swap 2 numbers
// swap(a, b) 
a = a^b;
b = b^a;
a = a^b;
 