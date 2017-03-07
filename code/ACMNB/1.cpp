#include <iostream>
#include <queue>
using namespace std;

int main() {
    int n;
    cin >> n;
    priority_queue<int, vector<int>, greater<int>> heap;
    int res = 0;
    for (int i=2*n; i>0; i--) {
        int a, b;
        cin >> a >> b;
        res += b;
        heap.push(a-b);
    }
    for (int i=n; i>0; i--) {
        res += heap.top();
        heap.pop();
    }
    cout << res;
}
