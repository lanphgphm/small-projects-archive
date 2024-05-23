// correct, needs documentation 
// time complexity is O(sqrt(n))
// if find unique, time complexity is O(n)
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n"

// factorize a number into prime factors
// result contains repetition 
vector<int> primeFactorize(int n){
    vector<int> ans; 
    while(!(n&1)){
        ans.push_back(2); 
        n /= 2;
    }
    for (int i = 3; i*i<=n; i+=2){
        while(n%i==0){
            ans.push_back(i); 
            n /= i; 
        }
    }
    if (n>2) ans.push_back(n);
    return ans; 
}

// find unique prime factors 
// result is unsorted vector 
vector<int> uniquePrimeFactor(int n){
    vector<int> v = primeFactorize(n);
    unordered_set<int> s;
    for (auto i:v) s.insert(i); 
    vector<int> ans; 
    ans.assign(s.begin(), s.end());
    return ans; 
}

signed main(){
    int n; cin >> n; 
    vector<int> ans = primeFactorize(n);
    cout << "factorization of " << n << " is: " << el;
    for (auto i: ans) cout << i << " ";
    cout << el;

    vector<int> ansUniq = uniquePrimeFactor(n);
    cout << el << "unique prime factors of " << n << " is: " << el;
    for (auto i: ansUniq) cout << i << " ";

    return 0; 
} 