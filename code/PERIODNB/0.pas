uses math,sysutils;
type int=longint;
var n,first,last: int;
d,m: int64;
a,s: array[1..10000000] of int64;

procedure main();
var i,x: int;
p,q,kq: int64;
begin
    assign(input,'');
    reset(input);
    readln(n,d);
    readln(p,q,m);
    close(input);
    a[1]:=p mod m;
    for i:=2 to n do a[i]:=(a[i-1]+p) mod m;
    for i:=n+1 to n+n-1 do a[i]:=a[i-n];
    x:=n+n-1;
    for i:=1 to x do a[i]:=a[i]+d*i+q;
    first:=1;
    last:=0;
    kq:=high(int64);
    for i:=1 to x do begin
        while (first<=last)and(a[s[last]]<=a[i]) do dec(last);
        inc(last);
        s[last]:=i;
        if s[first]<i-n+1 then inc(first);
        if i>=n then kq:=min(kq,a[s[first]]-d*(i-n));
    end;
    writeln(kq);
end;

begin
    main();
end.
