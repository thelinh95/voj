//*** CENTRE - CENTRE28
type int=longint;
link=^node;
node=record
    d, c: int;
    next: link;
end;
mang=array[1..30000] of int;
mang1=array[1..30000] of int64;

var n, m, l: int;
ke: array[1..30000] of link;
f1, fn: mang;
g1, gn: mang1;

free: array[1..30000] of shortint;
heap: mang;
stt, sh, kq: array[1..30000] of int;


procedure nhap;
var f: text;
t: link;
u, v, c: int;
m, i: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m);
    for i:=1 to m do begin
        readln(f, u, v, c);
        
        new(t);
        t^.c:=c;
        t^.d:=u;
        t^.next:=ke[v];
        ke[v]:=t;
        
        new(t);
        t^.c:=c;
        t^.d:=v;
        t^.next:=ke[u];
        ke[u]:=t;
    end;
    close(f);
end;

procedure get(var u, c: int);
var i, j, tmp: int;
begin
    c:=heap[1];
    u:=sh[1];
    
    heap[1]:=heap[m];
    sh[1]:=sh[m];
    stt[sh[1]]:=1;
    m:=m-1;
    i:=1;
    while i*2<=m do begin
        j:=i*2;
        if j<m then if heap[j+1]<heap[j] then j:=j+1;
        if heap[i]<=heap[j] then break;
        stt[sh[i]]:=j;
        stt[sh[j]]:=i;
        tmp:=heap[i];heap[i]:=heap[j];heap[j]:=tmp;
        tmp:=sh[i];sh[i]:=sh[j];sh[j]:=tmp;
        i:=j;
    end;
end;
procedure push(u, c: int);
var i, j, tmp: int;
begin
    m:=m+1;
    heap[m]:=c;
    sh[m]:=u;
    stt[u]:=m;
    
    i:=m;
    while i>1 do begin
        j:=i div 2;
        if heap[j]<=heap[i] then break;
        stt[sh[i]]:=j;
        stt[sh[j]]:=i;
        tmp:=heap[i];heap[i]:=heap[j];heap[j]:=tmp;
        tmp:=sh[i];sh[i]:=sh[j];sh[j]:=tmp;
        i:=j;
    end;
end;
procedure edit(i, c: int);
var j, tmp: int;
begin
    i:=stt[i];
    heap[i]:=c;
    
    while i>1 do begin
        j:=i div 2;
        if heap[j]<=heap[i] then break;
        stt[sh[i]]:=j;
        stt[sh[j]]:=i;
        tmp:=heap[i];heap[i]:=heap[j];heap[j]:=tmp;
        tmp:=sh[i];sh[i]:=sh[j];sh[j]:=tmp;
        i:=j;
    end;
end;

procedure dijs(s: int; var f: mang;var g: mang1);
var u, v, c: int;
t: link;
begin
    m:=0;
    for u:=1 to n do begin
        free[u]:=1;
        g[u]:=0;
    end;
    push(s, 0);
    free[s]:=0;
    g[s]:=1;
    
    while m>0 do begin
        get(u, c);
        f[u]:=c;
        free[u]:=-1;
        t:=ke[u];
        while t<>nil do begin
            v:=t^.d;
            c:=t^.c;
            if free[v]=1 then begin
                push(v, f[u]+c);
                free[v]:=0;
                g[v]:=g[u];
                free[v]:=0;
            end else if free[v]=0 then begin
                if heap[stt[v]]>f[u]+c then begin
                    edit(v, f[u]+c);
                    g[v]:=g[u];
                end else if heap[stt[v]]=f[u]+c then begin
                    g[v]:=g[v]+g[u];
                end;
            end else begin
                if f[v]=f[u]+c then g[v]:=g[v]+g[u];
            end;
            t:=t^.next;
        end;
    end;
end;

procedure xl;
var i: int;
begin
    dijs(1, f1, g1);
    dijs(n, fn, gn);
    
    l:=0;
    
    for i:=2 to n do begin
        if f1[i]+fn[i]>fn[1] then begin
            l:=l+1;
            kq[l]:=i;
        end else if g1[i]*gn[i]<gn[1] then begin
            l:=l+1;
            kq[l]:=i;
        end;
    end;
    
    writeln(l);
    for i:=1 to l do writeln(kq[i]);
end;

begin
    nhap;
    xl;
end.
