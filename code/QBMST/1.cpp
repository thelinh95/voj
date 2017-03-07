#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

class JSet {
    vector<int> rank, cha;
    public:
    JSet(int size): rank(size, 0), cha(size) {
        for (int i=0; i<(int)cha.size(); i++) cha[i] = i;
    }
    int find(int u) {
        if (cha[u] != u) cha[u] = find(cha[u]);
        return cha[u];
    }
    bool merge(int u, int v) {
        u = find(u);
        v = find(v);
        if (u == v) return false;
        if (rank[u] == rank[v]) rank[u]++;
        if (rank[u] > rank[v]) cha[v] = u;
        else cha[u] = v;
        return true;
    }
};
struct Edge { int u, v, c; };
bool operator<(const Edge &x, const Edge &y) {
    return x.c < y.c;
}

int main() {
    int n, m;
    cin >> n >> m;
    vector<Edge> e(m);
    for (Edge &x: e) {
        cin >> x.u >> x.v >> x.c;
        x.u--;
        x.v--;
    }
    sort(e.begin(), e.end());
    int res = 0;
    JSet set(n);
    for (const Edge &x: e) if (set.merge(x.u, x.v)) res += x.c;
    cout << res;
}
