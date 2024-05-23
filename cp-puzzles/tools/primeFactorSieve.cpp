// works for n up to 1e7 
// precomputation of spf[] is O(nlogn) 
// query is O(logn)
// --> overall complexity is O(nlogn + qlogn)

#include<bits/stdc++.h>
using namespace std;
#define int long long
#define el "\n"

// prime factor using prime sieve 
// for multiple queries 
// https://www.geeksforgeeks.org/prime-factorization-using-sieve-olog-n-multiple-queries/ 
#define MAXN 1000001
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

signed main(){
    sieve(); 
    int x; cin >> x; 
    cout << "prime factorization for " << x << " is: " << el;
    vector<int> p = getFactorization(x);

    for (auto i: p) cout << i << " ";

    return 0; 
}