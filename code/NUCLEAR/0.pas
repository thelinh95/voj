type int=longint;
var n,q: int;
d1,d2,r1,r2: array[1..200000] of int64;
vt,id,kq,z,vt1,id2,f: array[1..200000] of int;

procedure swap(var a,b: int64);
var tmp: int64;
begin
    tmp:=a;
    a:=b;
    b:=tmp;
end;
procedure swap(var a,b: int);
var tmp: int;
begin
    tmp:=a;
    a:=b;
    b:=tmp;
end;

procedure qsort();
var i: int;
procedure sort(l,r: int);
var i,j: int;
x: int64;
begin
    i:=l; j:=r;
    x:=r2[l+random(r-l+1)];
    while i<=j do begin
        while r2[i]<x do inc(i);
        while r2[j]>x do dec(j);
        if i<=j then begin
            swap(r1[i],r1[j]);
            swap(r2[i],r2[j]);
            swap(id[i],id[j]);
            inc(i); dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;
begin
    for i:=1 to q do id[i]:=i;
    sort(1,q);
end;
procedure qsort1();
var i: int;
procedure sort(l,r: int);
var i,j: int;
x: int64;
begin
    i:=l; j:=r;
    x:=d1[l+random(r-l+1)];
    while i<=j do begin
        while d1[i]<x do inc(i);
        while d1[j]>x do dec(j);
        if i<=j then begin
            swap(d1[i],d1[j]);
            swap(z[i],z[j]);
            inc(i); dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;
begin
    for i:=1 to n do z[i]:=i;
    sort(1,n);
    for i:=1 to n do vt1[z[i]]:=i;
end;
procedure qsort2();
var i: int;
procedure sort(l,r: int);
var i,j: int;
x: int64;
begin
    i:=l; j:=r;
    x:=d2[l+random(r-l+1)];
    while i<=j do begin
        while d2[i]<x do inc(i);
        while d2[j]>x do dec(j);
        if i<=j then begin
            swap(d2[i],d2[j]);
            swap(id2[i],id2[j]);
            inc(i); dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;
begin
    for i:=1 to n do id2[i]:=i;
    sort(1,n);
end;

function find(k: int64): int;
var l,r,i: int;
begin
    l:=1;
    r:=n;
    while l<=r do begin
        i:=(l+r) div 2;
        if d1[i]<=k then l:=i+1
        else r:=i-1;
    end;
    exit(r);
end;

procedure up(i: int);
begin
    while i<=n do begin
        f[i]:=f[i]+1;
        i:=i+(i and(-i));
    end;
end;
function get(i: int): int;
begin
    get:=0;
    while i>0 do begin
        get:=get+f[i];
        i:=i-(i and(-i));
    end;
end;

procedure main();
var i,j: int;
x1,x2,y1,y2,u,v: int64;
begin
    fillchar(f,sizeof(f),0);
    //assign(input,'a.inp'); reset(input);
    readln(n);
    for i:=1 to n do readln(d1[i],d2[i]);
    readln(x1,y1,x2,y2,q);
    for i:=1 to n do begin
        u:=d1[i];
        v:=d2[i];
        d1[i]:=(u-x1)*(u-x1)+(v-y1)*(v-y1);
        d2[i]:=(u-x2)*(u-x2)+(v-y2)*(v-y2);
    end;
    for i:=1 to q do readln(r1[i],r2[i]);
    //close(input);
    for i:=1 to q do begin
        r1[i]:=r1[i]*r1[i];
        r2[i]:=r2[i]*r2[i];
    end;
    qsort();
    qsort1();
    qsort2();
    j:=1;
    for i:=1 to q do begin
        while (j<=n)and(d2[j]<=r2[i]) do begin
            up(vt1[id2[j]]);
            inc(j);
        end;
        kq[i]:=find(r1[i])+(j-1)-get(find(r1[i]));
    end;
    for i:=1 to q do vt[id[i]]:=i;
    for i:=1 to q do writeln(kq[vt[i]]);
end;

begin
    main();
end.
