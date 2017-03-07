uses math;
type int=longint;
const inf=trunc(1e15);
var n,s,f: int;
g,a,c,d: array[0..100000] of int64;

function find(l,r: int; k: int64): int;
var i: int;
begin
    while l<=r do begin
        i:=(l+r) div 2;
        if a[i]>=k then r:=i-1
        else l:=i+1;
    end;
    exit(l);
end;

procedure main();
var i,j: int;
begin
    assign(input,''); reset(input);
    for i:=1 to 3 do read(d[i]);
    for i:=1 to 3 do read(c[i]);
    read(n);
    read(s,f);
    a[1]:=0;
    for i:=2 to n do read(a[i]);
    close(input);
    if s>f then begin
        i:=s; s:=f; f:=i;
    end;
    g[s]:=0;
    for i:=s+1 to f do begin
        g[i]:=inf;
        for j:=1 to 3 do begin
            g[i]:=min(g[i],g[find(s,i-1,a[i]-d[j])]+c[j]);
        end;
    end;
    writeln(g[f]);
end;

begin
    main();
end.
