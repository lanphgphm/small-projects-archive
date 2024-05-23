#include<bits/stdc++.h> 
using namespace std; 
#define int long long
#define el "\n"

// O(sqrt(n))
bool isPrime(int number){
    if(number < 2) return false;
    if(number == 2) return true;
    if(number % 2 == 0) return false;
    for(int i=3; (i*i)<=number; i+=2){
        if(number % i == 0 ) return false;
    }
    return true;
}

signed main(){ 
    int n; cin >> n; 
    cout << isPrime(n) << el; 
    return 0 
}