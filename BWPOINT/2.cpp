#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main() {
    int n;
    cin >> n;
    vector<int> a(2*n);
    for (int i=0; i<2*n; i++) {
        cin >> a[i];
        a[i] = a[i]*2 + i/n;
    }
    sort(a.begin(), a.end());
    int res = 0;
    int i = 0;
    n = 2*n;
    while (i < n-1) {
        if ((a[i]^a[i+1])&1) {
            res += 1;
            i += 2;
        } else i += 1;
    }
    cout << res;
}
