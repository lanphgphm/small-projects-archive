// TLE 10^14 
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 

signed main(){
    int t; cin >> t; 
    while(t--){
        int n, q; cin >> n >> q; 
        int a[n]; 
        for (int i = 0; i < n; i++){
            cin >> a[i]; 
        }
        int x[q]; 
        for (int i = 0; i < q; i++){
            cin >> x[i]; 
        }
        
        for (int i = 0; i < q; i++){
            for (int j = 0; j < n; j++){
                if ((a[j] & (1<<x[i])-1)==0){
                    a[j] = ((1<<(x[i]-1)) | a[j]);
                }
            }
        }

        for (int i = 0; i < n; i++) cout << a[i] << " ";
        cout << "\n"; 
    }
    return 0; 
}