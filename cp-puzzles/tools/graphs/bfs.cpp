// O(|V|+|E|)
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n"

vector<vector<int>> adj;  // adjacency list representation
int n; // number of nodes
int s; // source vertex

queue<int> q;
vector<bool> used(n);
vector<int> d(n), p(n);

// bfs that returns nothing 
void bfs(){
    q.push(s);
    used[s] = true;
    p[s] = -1;
    while (!q.empty()) {
        int v = q.front();
        q.pop();
        for (int u : adj[v]) {
            if (!used[u]) {
                used[u] = true;
                q.push(u);
                d[u] = d[v] + 1;
                p[u] = v;
            }
        }
    }
}

signed main(){
    // n = number of vertices 
    int n; cin >> n; 

    // getting edge information & store in adj[][]
    // getting graph input MUST BE TAILORED
    // to each problem, no general way
    for (int i = 0; i < n; i++){
        int u, v; cin >> u >> v; 
        u--; v--;
        adj[u].push_back(v); 
        adj[v].push_back(u); 
    }
}