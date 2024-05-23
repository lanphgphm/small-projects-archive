#include<bits/stdc++.h> 
using namespace std;
#define int long long
#define el "\n"

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

signed main(){
    int n; 
    cin >> n; 
    vector<int> phiArr = eulerTotient(n); 
    for(int i = 1; i <= n; i++){
        cout << phiArr[i] << " "; 
    }
    cout << el; 

    int m; cin >> m; 
    cout << phi(m) << el;
    return 0;
} 