// O(|V|+|E|)
#include<bits/stdc++.h> 
using namespace std; 
#define int long long 
#define el "\n"

vector<vector<int>> adj;
vector<bool> visited;

// dfs with no return value 
void dfs(int v) {
    visited[v] = true;
    for (int u : adj[v]) {
        if (!visited[u])
            dfs(u);
    }
}

// dfs with global timer
vector<int> color;
vector<int> time_in, time_out;
int dfs_timer = 0;

void dfs(int v) {
    time_in[v] = dfs_timer++;
    color[v] = 1;
    for (int u : adj[v])
        if (color[u] == 0)
            dfs(u);
    color[v] = 2;
    time_out[v] = dfs_timer++;
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