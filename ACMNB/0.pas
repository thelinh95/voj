type int=longint;
var n: int;
a,b,c: array[1..800000] of int;

procedure sort(l,r: int);
var i,j,x,tmp: int;
begin
    i:=l; j:=r;
    x:=c[l+random(r-l+1)];
    while i<=j do begin
        while c[i]<x do inc(i);
        while c[j]>x do dec(j);
        if i<=j then begin
            tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp;
            inc(i); dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;

procedure main();
var i,kq: int;
begin
    readln(n);
    for i:=1 to 2*n do readln(a[i],b[i]);
    kq:=0;
    for i:=1 to 2*n do begin
        kq:=kq+b[i];
        c[i]:=a[i]-b[i];
    end;
    sort(1,2*n);
    for i:=1 to n do kq:=kq+c[i];
    writeln(kq);
end;

begin
    randomize();
    main();
end.
