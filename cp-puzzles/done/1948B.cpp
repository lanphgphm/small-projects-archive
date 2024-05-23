#include<bits/stdc++.h> 
using namespace std; 
#define int long long 

signed main(){
    int t; cin >> t; 
    while(t--){
        int n; cin >> n; 
        int a[n]; 
        for (int i = 0; i < n; i++) cin >> a[i];

        vector<int> ans; 
        ans.push_back(a[n-1]); // number as big as can be :) 
        // cout << ans.back() << " ";
        for (int i = n-2; i >= 0; i--){
            if (a[i] > 10){
                if (a[i] > ans.back()){
                    int sec = a[i]%10; 
                    int first = a[i]/10; 
                    ans.push_back(sec); 
                    // cout << ans.back() << " ";
                    ans.push_back(first); 
                    // cout << ans.back() << " ";
                }
            }
            else ans.push_back(a[i]);
        }
        // cout << "\n"; 

        bool allDec = true; 
        for (int i = 0; i < ans.size()-1; i++){
            if (ans[i] < ans[i+1]) allDec = false; 
        }
        if (allDec) cout << "YES\n"; 
        else cout << "NO\n"; 
    }
    return 0; 
}