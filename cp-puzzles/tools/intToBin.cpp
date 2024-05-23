#include<bits/stdc++.h>
using namespace std; 
#define int long long 
#define el "\n"

// convert a long long int to binary string 
string intToBin(int n){
    string s = ""; 
    while(n){
        s += to_string(n%2); 
        n >>= 1; 
    }
    reverse(s.begin(), s.end()); 
    return s; 
}

int binToInt(string s){
    int ans = 0; 
    int n = s.size();
    for (int i = n-1; i >= 0; i--){
        if(s[i]=='1') ans += 1 << (n-i-1); 
    }
    return ans; 
}

signed main(){
    int x; cin >> x; 
    cout << "binary of " << x<< " is " << intToBin(x) << el;
    cout << "int of " << intToBin(x) << " is " << binToInt(intToBin(x)) << el;
    return 0; 
} 