#include<bits/stdc++.h>
using namespace std;
#define int long long 
#define el "\n"

// sieve of eratosthenes
// find all primes number from 1 to n 
// O(nloglogn)

vector<bool> sievePrime(int n){
    vector<bool> isPrime(n+1,true);
    isPrime[0] = isPrime[1] = false;
    isPrime[2] = true;
    for(int i = 4; i <= n; i+=2) isPrime[i] = false;
    for (int i = 3; i*i <= n; i+=2){
        if(isPrime[i]){
            for (int j = i*i; j <= n; j+=i){
                isPrime[j] = false;
            }
        }
    } 
    return isPrime;
}

signed main(){
    int n;
    cin >> n;
    vector<bool> isPrime = sievePrime(n);
    cout << "prime numbers until n are: " << el;
    for (int i = 0; i <= n; i++){
        if(isPrime[i]) cout << i << " ";
    }
    cout << el;
    return 0;
}