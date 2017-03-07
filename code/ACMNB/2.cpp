#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    int n;
    cin >> n;
    vector<int> c(2*n);
    int res = 0;
    for (int i=0; i<2*n; i++) {
        static int a, b;
        cin >> a >> b;
        res += b;
        c[i] = a - b;
    }
    sort(c.begin(), c.end());
    for (int i=0; i<n; i++) res += c[i];
    cout << res;
}
