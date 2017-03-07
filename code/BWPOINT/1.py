n = int(input())*2
a = []
a += [int(x)*2 for x in input().split()]
a += [int(x)*2+1 for x in input().split()]
a.sort()
i = 0
res = 0
while i < n-1:
    if a[i]%2 != a[i+1]%2:
        res += 1
        i += 2
    else:
        i += 1
print(res)
