//----------TEMPLATE 
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n" 

const int MOD = 1e9+7; // CHANGE ME 

signed main(){

    return 0; 
}

//----------SIEVE: find prime numbers from 1 to n
// O(nloglogn) 
vector<bool> sievePrime(int n){
    vector<bool> isPrime(n+1,true);
    isPrime[0] = isPrime[1] = false;
    isPrime[2] = true;
    for(int i = 4; i <= n; i+=2) isPrime[i] = false;
    for (int i = 3; i*i <= n; i+=2){
        if(isPrime[i]){
            for (int j = i*i; j <= n; j+=i){
                isPrime[j] = false;
            }
        }
    } 
    return isPrime;
}

//----------SIEVE FACTORIZATION
// (for large input up to 1e7)
// factorize number 
#define MAXN 1000001 // CHANGE ME 
int spf[MAXN];

void sieve(){
    spf[1] = 1; 
    for (int i = 2; i<MAXN; i++) spf[i] = i; 
    for (int i = 4; i<MAXN; i+=2) spf[i] = 2; 
    for (int i = 3; i*i<MAXN; i++){
        if (spf[i]==i){
            for (int j = i*i; j<MAXN; j+=i){
                if (spf[j]==j) spf[j] = i; 
            }
        }
    }
} 

vector<int> getFactorization(int x){
    vector<int> ret; 
    while(x!=1){
        ret.push_back(spf[x]); 
        x /= spf[x]; 
    }
    return ret; 
}

//----------FACTORIZE -- result has duplication 
// if only need unique prime factors: 
// also need to run the unique function 
// O(sqrt(n))
vector<int> primeFactorize(int n){
    vector<int> ans; 
    while(!(n&1)){
        ans.push_back(2); 
        n /= 2;
    }
    for (int i = 3; i*i<=n; i+=2){
        while(n%i==0){
            ans.push_back(i); 
            n /= i; 
        }
    }
    if (n>2) ans.push_back(n);
    return ans; 
}

vector<int> uniquePrimeFactor(int n){
    vector<int> v = primeFactorize(n);
    unordered_set<int> s;
    for (auto i:v) s.insert(i); 
    vector<int> ans; 
    ans.assign(s.begin(), s.end());
    return ans; 
}

//----------MODULAR ARITHMETIC 
const int N = 1e5+5; // CHANGE ME 
int fact[N]; 
const int m = 1e9+7;

int qexp(int a, int x, int m){
    if (x==0) return 1; 
    else if (x==1) return a; 
    int q = qexp(a, (x>>1), m); 
    if (x&1){
        return ((a%m * q%m)%m * q%m)%m;
    }
    else{
        return ((q%m * q%m)%m); 
    }
}

int inv(int b, int m){
    return qexp(b, m-2, m); 
}

// mod divide: (a/b) mod m = (a* b^-1) mod m
int modDiv(int a, int b, int m){
    return ((a%m) * (inv(b, m)% m))%m; 
}

// factorial mod m -- RUN THIS before modChoose()
// in-place function with global array fact[N]
void modFact(int fact[], int len, int m){
    fact[0] = 1; 
    for (int i = 1; i < len; i++){
        fact[i] = (i%m * fact[i-1]%m)%m; 
    }
}

// mod {n choose k} 
int modChoose(int n, int k, int m){
    int top = fact[n]; 
    int bot = (fact[k]%m * fact[n-k]%m)%m; 
    return modDiv(top, bot, m); 
}

//----------FIBONACCI 
// if we need to calculate fib[1] to fib[n], 
// dynamic programming is fastest: O(n)

// if only need fib[n], use the following for O(logn)
struct matrix {
    int mat[2][2];
    matrix friend operator *(const matrix &a, const matrix &b){
        matrix c;
        for (int i = 0; i < 2; i++) {
          for (int j = 0; j < 2; j++) {
              c.mat[i][j] = 0;
              for (int k = 0; k < 2; k++) {
                  c.mat[i][j] += a.mat[i][k] * b.mat[k][j];
              }
          }
        }
        return c;
    }
};

matrix matpow(matrix base, int n) {
    matrix ans{ {
      {1, 0},
      {0, 1}
    } };
    while (n) {
        if(n&1)
            ans = ans*base;
        base = base*base;
        n >>= 1;
    }
    return ans;
}

int fib(int n) {
    matrix base{ {
      {1, 1},
      {1, 0}
    } };
    return matpow(base, n).mat[0][1];
}

//----------EULER TOTIENT FUNCTION 
// euler totient function for single n 
// O(sqrt(n))
int phi(int n){
    int ans = n; 
    for(int i = 2; i*i <= n; i++){
        if(n%i == 0){
            while(n%i == 0){
                n /= i; 
            }
            ans -= ans/i; 
        }
    }
    if(n > 1){
        ans -= ans/n; 
    }
    return ans; 
}

// euler totient function from 1 to n 
// O(nloglogn)
vector<int> eulerTotient(int n){
    vector<int> phi(n+1); 
    for(int i = 1; i <= n; i++){
        phi[i] = i; 
    }
    for(int i = 2; i <= n; i++){
        if(phi[i] == i){
            for(int j = i; j <= n; j += i){
                phi[j] -= phi[j]/i; 
            }
        }
    }
    return phi; 
}

//---------CATALAN NUMBER 
const int MOD = 1e9+7; // CHANGE ME 
const int MAX = 1e5+5; // CHANGE ME 
int catalan[MAX];

void initCatalan(int n) {
    catalan[0] = catalan[1] = 1;
    for (int i=2; i<=n; i++) {
        catalan[i] = 0;
        for (int j=0; j < i; j++) {
            catalan[i] += (catalan[j] * catalan[i-j-1]) % MOD;
            if (catalan[i] >= MOD) {
                catalan[i] -= MOD;
            }
        }
    }
}

//---------GCD
// greatest common divisor 
__gcd(a, b); gcd(a, b); 
// if have to code: O(log(min(a, b)))
int gcd (int a, int b) {
    return b ? gcd (b, a % b) : a;
}

//----------LCM
// least common multiple: O(log(min(a, b)))
int lcm (int a, int b) {
    return a / gcd(a, b) * b;
}

//----------BINARY STRING 
// O(logn)
string intToBin(int n){
    string s = ""; 
    while(n){
        s += to_string(n%2); 
        n >>= 1; 
    }
    reverse(s.begin(), s.end()); 
    return s; 
}

int binToInt(string s){
    int ans = 0; 
    int n = s.size();
    for (int i = n-1; i >= 0; i--){
        if(s[i]=='1') ans += 1 << (n-i-1); 
    }
    return ans; 
}

//---------BINARY TRICKS 
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
 
//---------FREQUENTLY USED BUILTIN FUCNTIONS 
#include<vector> 
vector<int> v; 
// vector.push_back(value); -- add element at the end 
v.push_back(5);
// vector.pop_back() -- del last element 
v.pop_back();
// vector.insert(position, value, [number_of_copies])
v.insert(v.begin(), 100, 5);
//vector.erase(position) -- erase element, position is iterator
// to ersae 6th element: 
v.erase(v.begin()+5); 
//to erase first 3 elements:
v.erase(v.begin(), v.begin()+3); 


#include<map> 
map<int, int> m;
// 4 ways to insert pair into map 
m[0] = 42;
m.insert({0, 42}); // preferred
m.insert(pair<int, int>(0, 42));
m.find('key'); // return iterator if found, map.end() if not 


#include<algorithm> 
// find(vector.begin(), vector.end(), value)
// return iterator if found, vector.end() if not 
find(v.begin(), v.end(), 15); 

// unique(vector.begin(), vector.end())
// reoves duplicates ONLY if vector is sorted 
sort(v.begin(), v.end()); 
unique(v.begin(), v.end()); 

// sort vector  
sort(v.begin(), v.end()); // ascending
sort(v.rbegin(), v.rend()); //descending

// check if vector is sorted 
// returns boolean 
is_sorted(v.begin(), v.end()); 

// reverse vector elements 
reverse(v.begin(), v.end()); 

// min & max 
min(a, b); min(a, min(b, c)); 
max(a, b); max(a, max(b, c)); 

// greatest common divisor 
__gcd(a, b);

//----builtin functions 
// initialize STATIC array value
memset(a, 0, sizeof(a));

// count number of bits set in a number
__builtin_popcountll(n); 

// Checks the Parity of a number
// Returns true(1) if the number has odd number of set bits
// else it returns false(0) for even number of set bits
__builtin_parityll(n); 

// Counts the trailing number of zeros of long long int
__builtin_ctzll(n); 

// find index of least significant bit 
__builtin_ffs(n); 
// find index of most significant set bit 
// also computes log base 2 
__lg(x); 
 

#include<cmath> 
pow(b, x); 
sqrt(x); 
floor(x); 
ceil(x); 
log2(x); 

//---------CAPACITY OF DATA TYPES 
type name           bytes           range 
int                 4               (-2)^16 to 2^16 - 1
long long           8               (-2)^32 to 2^32 - 1
unsigned int        4               0 to 2^32
unsigned long long  8               0 to 2^64
float               4               3.4E +/- 38 (7 digits)
double              8               1.7E +/- 308 (15 digits)