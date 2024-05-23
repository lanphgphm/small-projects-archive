#include<bits/stdc++.h> 
using namespace std; 
#define int long long 

signed main(){
    int t; cin >> t; 
    while (t--){
        int n; cin >> n; 
        int a[n];
        
        for (int i = 0; i < n; i++)
            cin >> a[i]; 

        int year = a[0]; 
        for (int i = 1; i < n; i++){
            if (year % a[i] == 0) year += a[i]; 
            else{
                int m = ceil((1.0 * year)/a[i]); 
                if (m*a[i] == year) year = (m+1) * a[i]; 
                else year = m * a[i]; 
            }
        }    
        cout << year << "\n"; 
    }

    return 0; 
}