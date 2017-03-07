#include <iostream>
#include <stdint.h>
#include <stdio.h>
#include <algorithm>
#include <vector>

#define mod 1000000007

int e(int n, int p) {
    int tmp = p;
    int res = 0;
    while (n/tmp > 0) {
        res += n/tmp;
        tmp = tmp*p;
    }
    return res;
}

int64_t power(int64_t a, int b){
    if (b==0) return 1;
    int64_t res = power(a, b/2);
    if (b%2==0) {res = res*res % mod;}
    else {res = (res*res%mod *a) %mod;}
    return res;
}
int main() {
    using namespace std;
    int a, n;
    cin >> a >> n;
    vector<bool> sang(n+1, true);
    sang[1]=false;
    for (int64_t i=2; i<=n; i++) {
        if (sang[i]) {
            for(int64_t j = i*i; j<=n; j=j+i) sang[j] = false;
        }
    }
    for (int i=a; i<=n; i++) if (sang[i]) {
        cout << i << endl;
    }

    return 0;
}
