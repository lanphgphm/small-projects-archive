#include<bits/stdc++.h>
using namespace std; 
#define int long long 

signed main(){
    int t; cin >> t; 
    while(t--){
        int n; cin >> n; 
        string path; cin >> path;
        int ncoins = 0;  

        for (int i = 0; i < n; i++){
            if (path[i]=='.') continue; 
            else if (path[i]=='@') ncoins++; 
            else{ // thorns 
                if ((i+1 < n) && path[i+1]=='*') break;
                else continue; 
            }
        }

        cout << ncoins << "\n"; 
    }
    return 0; 
}