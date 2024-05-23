// O(n)
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n"

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

signed main(){
    int n; cin >> n; 
    initCatalan(n); 
    cout << catalan[n-1]; 
    return 0; 
} 