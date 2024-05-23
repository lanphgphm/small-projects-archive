// is now correct, needs more documentation 
#include<bits/stdc++.h> 
using namespace std; 
#define int long long
#define el "\n"
#define N 1000005

int fact[N]; 
const int m = 1e9+7;

// mod quick exponentiation: a^x mod m
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
// mod multiplicative inverse: b^-1 mod m 
// using fermat's little theorem
int inv(int b, int m){
    return qexp(b, m-2, m); 
}

// mod divide: (a/b) mod m = (a* b^-1) mod m
int modDiv(int a, int b, int m){
    return ((a%m) * (inv(b, m)% m))%m; 
}

// factorial mod m 
// in-place function with global array fact[N]
void modFact(int fact[], int len, int m){
    fact[0] = 1; 
    for (int i = 1; i < len; i++){
        fact[i] = (i%m * fact[i-1]%m)%m; 
    }
}

// mod choose 
int modChoose(int n, int k, int m){
    int top = fact[n]; 
    int bot = (fact[k]%m * fact[n-k]%m)%m; 
    return modDiv(top, bot, m); 
}

// driver's code 
signed main(){
    int t; cin >> t; 
    while(t--){
        int n, k; cin >> n >> k;
        modFact(fact, N, m);
        cout << modChoose(n, k, m) << el; 
    }
    return 0; 
} 