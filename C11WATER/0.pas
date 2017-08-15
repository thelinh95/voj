type long=longint;
link=^node;
node=record
    c, d: long;
    next: link;
end;

var n, m, s: long;
ke, pt: array[0..1000000] of link;
ctrc, trc, h: array[0..1000000] of long;
free: array[0..1000000] of shortint;

heap, sh: array[1..1000001] of long;
stt: array[0..1000000] of long;

function fmax(a, b: long): long;
begin
    if a>b then exit(a) else exit(b);
end;

procedure nhap;
var i, j, c, r, u, v: long;
f: text;
a: array[0..999, 0..999] of long;
t: link;
begin
    assign(f, '');
    reset(f);
    readln(f, c, r);
    for i:=0 to c-1 do begin
        for j:=0 to r-1 do begin
            read(f, a[i, j]);
            u:=i*r+j;
            h[u]:=a[i, j];
            
            ke[u]:=nil;
            free[u]:=1;
            
            if i>0 then begin
                v:=(i-1)*r+j;
                new(t);
                t^.d:=v;
                t^.c:=fmax(a[i, j], a[i-1, j]);
                t^.next:=ke[u];
                ke[u]:=t;
                new(t);
                t^.d:=u;
                t^.c:=fmax(a[i, j], a[i-1, j]);
                t^.next:=ke[v];
                ke[v]:=t;
            end;
            if j>0 then begin
                v:=i*r+j-1;
                new(t);
                t^.d:=v;
                t^.c:=fmax(a[i, j], a[i, j-1]);
                t^.next:=ke[u];
                ke[u]:=t;
                new(t);
                t^.d:=u;
                t^.c:=fmax(a[i, j], a[i, j-1]);
                t^.next:=ke[v];
                ke[v]:=t;
            end;
        end;
        readln(f);
    end;
    close(f);
    
    s:=c*r;
    ke[s]:=nil;
    for i:=0 to c-1 do begin
        v:=i*r;
        new(t);
        t^.d:=v;
        t^.c:=a[i, 0];
        t^.next:=ke[s];
        ke[s]:=t;
        new(t);
        t^.d:=s;
        t^.c:=a[i, 0];
        t^.next:=ke[v];
        ke[v]:=t;
        
        v:=i*r+r-1;
        new(t);
        t^.d:=v;
        t^.c:=a[i, r-1];
        t^.next:=ke[s];
        ke[s]:=t;
        new(t);
        t^.d:=s;
        t^.c:=a[i, r-1];
        t^.next:=ke[v];
        ke[v]:=t;
    end;
    for i:=1 to r-2 do begin
        v:=i;
        new(t);
        t^.d:=v;
        t^.c:=a[0, i];
        t^.next:=ke[s];
        ke[s]:=t;
        new(t);
        t^.d:=s;
        t^.c:=a[0, i];
        t^.next:=ke[v];
        ke[v]:=t;
        
        v:=(c-1)*r+i;
        new(t);
        t^.d:=v;
        t^.c:=a[c-1, i];
        t^.next:=ke[s];
        ke[s]:=t;
        new(t);
        t^.d:=s;
        t^.c:=a[c-1, i];
        t^.next:=ke[v];
        ke[v]:=t;
    end;
end;

function get(var u: long): long; //u return a vertex, get return a weight
var i, j, tmp: long;
begin
    get:=heap[1];
    u:=sh[1];
    
    heap[1]:=heap[m];
    sh[1]:=sh[m];
    stt[sh[1]]:=1;
    
    m:=m-1;
    i:=1;
    while i shl 1<=m do begin
        j:=i shl 1;
        if j<m then if heap[j+1]<heap[j] then j:=j+1;
        if heap[i]>heap[j] then begin
            stt[sh[i]]:=j;
            stt[sh[j]]:=i;
            tmp:=heap[i];
            heap[i]:=heap[j];
            heap[j]:=tmp;
            tmp:=sh[i];
            sh[i]:=sh[j];
            sh[j]:=tmp;
            i:=j;
        end else break;
    end;
end;
procedure edit(d, c: long); //d is a vertex number, c is a weight
var i, tmp: long;
begin
    d:=stt[d]; //d change to an index
    heap[d]:=c;
    
    while d>1 do begin
        i:=d shr 1;
        if heap[i]>heap[d] then begin
            stt[sh[i]]:=d;
            stt[sh[d]]:=i;
            tmp:=heap[d];
            heap[d]:=heap[i];
            heap[i]:=tmp;
            tmp:=sh[d];
            sh[d]:=sh[i];
            sh[i]:=tmp;
            d:=i;
        end else break;
    end;
end;
procedure push(d, c: long); //same as edit()
var i, tmp: long;
begin
    m:=m+1;
    heap[m]:=c;
    sh[m]:=d;
    stt[d]:=m;
    c:=m; //c change to an index
    
    while (c>1) do begin
        i:=c shr 1;
        if heap[i]>heap[c] then begin
            stt[sh[c]]:=i;
            stt[sh[i]]:=c;
            tmp:=heap[c];
            heap[c]:=heap[i];
            heap[i]:=tmp;
            tmp:=sh[i];
            sh[i]:=d;
            sh[c]:=tmp;
            c:=i;
        end else break;
    end;
end;

function prim: long;
var t: link;
c, u, v: long;
begin
    prim:=0;
    m:=0;
    push(s, 0);
    trc[s]:=-1;
    while m>0 do begin
        c:=get(u);
        prim:=prim+c;
        free[u]:=-1;
        t:=ke[u];
        while t<>nil do begin
            if free[t^.d]=1 then begin
                push(t^.d, t^.c);
                free[t^.d]:=0;
                trc[t^.d]:=u;
                ctrc[t^.d]:=t^.c;
            end else if free[t^.d]<>-1 then
            if heap[stt[t^.d]]>t^.c then begin
                edit(t^.d, t^.c);
                trc[t^.d]:=u;
                ctrc[t^.d]:=t^.c;
            end;
            t:=t^.next;
        end;
    end;
    for u:=0 to s do begin
        pt[u]:=nil;
        free[u]:=1;
    end;
    for u:=0 to s-1 do begin
        v:=trc[u];
        c:=ctrc[u];
        new(t);
        t^.d:=u;
        t^.c:=c;
        t^.next:=pt[v];
        pt[v]:=t;
    end;
end;

procedure bfs;
var first, last, u: long;
t: link;
begin
    first:=0;
    last:=0;
    stt[last]:=s;
    ctrc[s]:=0;
    while first<=last do begin
        u:=stt[first];
        first:=first+1;
        t:=pt[u];
        while t<>nil do begin
            last:=last+1;
            stt[last]:=t^.d;
            ctrc[t^.d]:=fmax(ctrc[u], t^.c);
            t:=t^.next;
        end;
    end;
end;

procedure xuat;
var i: long;
v: int64;
begin
    V:=0;
    for i:=0 to s-1 do v:=v+ctrc[i]-h[i];
    writeln(V);
end;

begin
    nhap;
    prim;
    bfs;
    xuat;
end.
