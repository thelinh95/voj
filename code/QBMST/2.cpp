#include <iostream>
#include <vector>
#include <set>
#include <map>
using namespace std;

struct Edge { int u, c; };
bool operator<(const Edge &x, const Edge &y) {
    if (x.c < y.c) return true;
    else if (x.c > y.c) return false;
    else return x.u < y.u;
}

struct Graph {
    vector<vector<Edge>> ke;
    Graph(int size): ke(size) {}
    void add_edge(int u, int v, int c) {
        ke[u].push_back({v, c});
        ke[v].push_back({u, c});
    }
    int prim() {
        set<Edge> f;
        vector<bool> flag(ke.size(), true);
        vector<int> track(ke.size(), -1);
        track[0] = 0;
        f.insert({0, 0});
        while (!f.empty()) {
            Edge e = *f.begin();
            f.erase(f.begin());
            flag[e.u] = false;
            for (const Edge &e: ke[e.u]) if (flag[e.u]) {
                if (track[e.u] >= 0) {
                    f.erase({e.u, track[e.u]});
                    track[e.u] = min(track[e.u], e.c);
                    f.insert({e.u, track[e.u]});
                } else {
                    track[e.u] = e.c;
                    f.insert({e.u, track[e.u]});
                }
            }
        }
        int res = 0;
        for (int x: track) res += x;
        return res;
    }
};

int main() {
    int n, m;
    cin >> n >> m;
    Graph g(n);
    for (int i=m; i>0; i--) {
        int u, v, c;
        cin >> u >> v >> c;
        g.add_edge(u-1, v-1, c);
    }
    cout << g.prim();
}
