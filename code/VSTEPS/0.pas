var n, k, i, j: longint;
a, b: array[0..100000] of longint;
begin
    readln(n, k);
    for i:=1 to k do begin
        read(j);b[j]:=1;
    end;
    a[0]:=0;
    a[1]:=1;
    for i:=2 to n do if b[i]=0 then a[i]:=(a[i-2]+a[i-1])mod 14062008 else a[i]:=0;
    write(a[n]);
end.
