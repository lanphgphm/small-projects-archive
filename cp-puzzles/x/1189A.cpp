#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define endl "\n"

bool good(string s){
    int n = s.size(); 
    for(int i = 0; i < n/2; i++){
        if (s[i] == s[n-i+1]) return false; 
    }
    return true; 
}

signed main(){
    ios_base::sync_with_stdio(false); cin.tie(0);

    int t; cin >> t; 
    while(t--){
        int n; cin >> n; 
        string s; cin >> s; 
    }
    return 0; 
}