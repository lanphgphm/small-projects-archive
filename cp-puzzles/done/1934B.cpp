#include<bits/stdc++.h> 
using namespace std; 
#define int long long 

int greedySolve(int n){
    int ans = 0; 
    ans += n/15; 
    n = n %15; 

    ans += n/6; 
    n = n %6; 

    ans += n/3; 
    n = n % 3; 

    ans += n; 

    return ans; 
}

signed main(){
    int t; cin >> t; 
    while(t--){
        int n; cin >> n; 

        if (n < 10) cout << greedySolve(n) << "\n"; 
        else if (n < 20) cout << min(greedySolve(n), greedySolve(n-10)+1) << "\n"; 
        else cout << min({greedySolve(n), greedySolve(n-10)+1, greedySolve(n-20)+2}) << "\n";
    }
    return 0; 
}