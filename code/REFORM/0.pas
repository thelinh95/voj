uses math;
type int = longint;
link = ^node;
node = record u: int; next: link; end;

var ke: array[1..100000] of link;
p, p1, a, b, mm, trc: array[1..100000] of int;
m, n, m1, m2: int;
lt: int;
kq: int64;
s: int;
w: int;

procedure sl1(mm, z: int);
var a, b: int64;
begin
    a:=mm;
    b:=z;
    kq:=kq-1+(a+1)*(b-a-1);
end;
procedure sl2();
var a,b,c,d,e: int64;
begin
    a:=w;
    b:=m1;
    c:=m2;
    d:=n;
    e:=m;
    if lt=2 then kq:=kq+a*b*c
    else kq:=kq+a*(d*(d-1) div 2-e);
end;

procedure dfs1(u: int);
var t: link;
begin
    p[u]:=lt;
    t:=ke[u];
    while t<>nil do begin
        if p[t^.u]=0 then dfs1(t^.u);
        t:=t^.next;
    end;
end;

procedure dfs(u, z: int);
var t: link;
v: int;
begin
    mm[u]:=0;
    p1[u]:=1998;
    inc(s);
    a[u]:=s;
    b[u]:=s;
    t:=ke[u];
    while t<>nil do begin
        v:=t^.u;
        if p1[v]=0 then begin
            trc[v]:=u;
            dfs(v, z);
            mm[u]:=mm[u]+mm[v]+1;
            b[u]:=min(b[u], b[v]);
            if b[v]>a[u] then begin
                dec(w);
                if lt=1 then begin
                    sl1(mm[v], z);
                end;
            end;
        end else if v<>trc[u] then begin
            b[u]:=min(b[u], a[v]);
        end;
        t:=t^.next;
    end;
end;

procedure xl();
var u,v,i: int;
t: link;
begin
    kq:=0;
    readln(n, m);
    for i:=1 to n do ke[i]:=nil;
    for i:=1 to m do begin
        readln(u, v);
        new(t);
        t^.u:=v;
        t^.next:=ke[u];
        ke[u]:=t;
        new(t);
        t^.u:=u;
        t^.next:=ke[v];
        ke[v]:=t;
    end;
    
    fillchar(p, sizeof(p), 0);
    lt:=0;
    for i:=1 to n do if p[i]=0 then begin
        inc(lt);
        dfs1(i);
    end;
    if lt>2 then begin
        writeln(0);
        exit();
    end;
    if lt=2 then begin
        m1:=0;
        m2:=0;
        for i:=1 to n do begin
            if p[i]=1 then inc(m1)
            else if p[i]=2 then inc(m2)
            else writeln('FUCK!!!1');
        end;
    end else if lt=1 then begin
        m1:=n;
        m2:=0;
    end;
    
    fillchar(p1, sizeof(p1), 0);
    s:=0;
    w:=m;
    for i:=1 to n do if p1[i]=0 then begin
        if p[i]=1 then dfs(i,m1)
        else if p[i]=2 then dfs(i, m2)
        else writeln('FUCK!!!2');
    end;
    
    sl2();
    
    writeln(kq);
end;

begin
    xl();
end.
