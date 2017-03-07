const inf=2100000000;
var f:text;
n, kq, i, j, k, min: longint;
a: array[1..300,1..300] of longint;
d, free: array[1..300] of longint;

begin
    assign(f, '');
    reset(f);
    readln(f, n);
    kq:=0;
    for i:=1 to n do readln(f, d[i]);
    for i:=1 to n do begin
        for j:=1 to n do read(f, a[i, j]);
        readln(f);
        free[i]:=0;
    end;
    close(f);
    for i:=1 to n do begin
        min:=inf;
        for j:=1 to n do if (free[j]=0)and(d[j]<min) then begin
            min:=d[j];
            k:=j;
        end;
        free[k]:=1;
        kq:=kq+d[k];
        for j:=1 to n do if (free[j]=0)and(a[k, j]<d[j]) then d[j]:=a[k, j];
    end;
    writeln(kq);
end.
