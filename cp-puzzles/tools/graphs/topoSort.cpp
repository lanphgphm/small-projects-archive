#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n"

int n; // number of vertices
vector<vector<int>> adj; // adjacency list of graph
vector<bool> visited;
vector<int> ans;

void dfs(int v) {
    visited[v] = true;
    for (int u : adj[v]) {
        if (!visited[u])
            dfs(u);
    }
    ans.push_back(v);
}

void topological_sort() {
    visited.assign(n, false);
    ans.clear();
    for (int i = 0; i < n; ++i) {
        if (!visited[i])
            dfs(i);
    }
    reverse(ans.begin(), ans.end());
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