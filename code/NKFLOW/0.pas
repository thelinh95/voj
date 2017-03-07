//*** find max-flow in network
//*** spoj: NKFLOW
type int=longint;

const inf=2100000000;

var a, f: array[1..1000, 1..1000] of int;
n, s, t: int;

var q, cc, trc: array[1..1000] of int;
first, last: int;

function min(a, b: int): int;
begin
    if a>b then exit(b) else exit(a);
end;

procedure nhap;
var f: text;
m, i, u, v, c: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m, s, t);
    for u:=1 to n do for v:=1 to n do begin
        a[u, v]:=0;
    end;
    for i:=1 to m do begin
        readln(f, u, v, c);
        a[u, v]:=c;
    end;
    close(f);
end;

function find: boolean;
var u, v: int;
begin
    for u:=1 to n do begin
        trc[u]:=0;
        cc[u]:=inf;
    end;
    
    first:=1;
    last:=1;
    q[last]:=s;
    trc[s]:=s;
    while first<=last do begin
        u:=q[first];
        first:=first+1;
        for v:=1 to n do if trc[v]=0 then begin
            if f[u, v]<a[u, v] then begin
                trc[v]:=u;
                cc[v]:=min(cc[u], a[u, v]-f[u, v]);
            end else if f[v, u]>0 then begin
                trc[v]:=-u;
                cc[v]:=min(cc[u], f[v, u]);
            end;
            
            if trc[v]<>0 then begin
                if v=t then exit(true);
                last:=last+1;
                q[last]:=v;
            end;
        end;
    end;
    exit(false);
end;

procedure fix;
var u, v: int;
begin
    u:=t;
    while u<>s do begin
        v:=trc[u];
        if v>0 then begin
            f[v, u]:=f[v, u]+cc[t];
        end else begin
            v:=-v;
            f[u, v]:=f[u, v]-cc[t];
        end;
        u:=v;
    end;
end;

procedure main;
var u, v, kq: int;
begin
    for u:=1 to n do for v:=1 to n do f[u, v]:=0;
    
    while find do fix;
    
    kq:=0;
    for u:=1 to n do kq:=kq+f[s, u];
    writeln(kq);
end;

begin
    nhap;
    main;
end.
