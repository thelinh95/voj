n = int(input())
res = 0
c = [0]*2*n
for i in range(2*n):
    a, b = map(int, input().split())
    res += b
    c[i] = a - b
c.sort()
res += sum(c[:n])
print(res)
