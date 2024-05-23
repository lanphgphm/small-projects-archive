#include<bits/stdc++.h> 
using namespace std; 
// #define int unsigned long long 

signed main(){
    int t; cin >> t; 
    while(t--){
        int n, m;
        cin >> n >> m; 
        int a[n]; 
        int b[n]; 
        for (int i = 0; i < n; i++){
            cin >> a[i]; 
            b[i] = a[i] % m; 
        }
        string s; cin >> s; 


        unsigned long long p=1; 
        for (int i = 0; i < n; i++){
            if (b[i]==0) b[i] = m; 
            p *= b[i]; 
        }

        int out[n]; 
        int l=0, r=n-1; 

        for (int i = 0; i < n; i++){
            out[i] = (p % m); 
            if (s[i] == 'L') {
                p /= b[l]; 
                l++; 
            }
            else{
                p /= b[r]; 
                r--; 
            }
        }

        for (int i = 0; i < n; i++){
            cout << out[i] << " ";
        }
        cout << "\n"; 
    }
    return 0; 
}