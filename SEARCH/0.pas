type int=longint;
mang=array[0..100001] of int;
var m,n,p: int;
a,b,c,x,y: mang;
boo: array[0..100001] of boolean;

procedure qsort(var a: mang; n: int);
var tmp,x: int;
procedure sort(l,r: int);
var i,j: int;
begin
    i:=l;
    j:=r;
    x:=a[l+random(r-l+1)];
    while i<=j do begin
        while a[i]<x do inc(i);
        while a[j]>x do dec(j);
        if i<=j then begin
            tmp:=a[i];
            a[i]:=a[j];
            a[j]:=tmp;
            inc(i);
            dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;
begin
    sort(1,n);
end;

function find(var a:mang; n,k: int): int;
var l,r,i: int;
begin
    l:=1;
    r:=n;
    while l<=r do begin
        i:=(l+r)div 2;
        if a[i]=k then exit(i);
        if a[i]>k then r:=i-1
        else l:=i+1;
    end;
    exit(0);
end;

function check(i,j: int):boolean;
var k: int;
begin
    fillchar(y,sizeof(y),0);
    for k:=i to j do inc(y[find(a,m,c[k])]);
    for k:=1 to m do if y[k]<1 then exit(false);
    exit(true);
end;

procedure main();
var i,j,kq: int;
f: text;
begin
    assign(f,'');
    reset(f);
    readln(f,m,n,p);
    for i:=1 to m do read(f,a[i]);readln(f);
    for i:=1 to n do read(f,b[i]);readln(f);
    for i:=1 to p do read(f,c[i]);
    close(f);
    qsort(b,n);
    qsort(a,m);
    j:=1;
    x[1]:=1;
    
    for i:=2 to m do begin
        if a[i]<>a[i-1] then begin
            inc(j);
            a[j]:=a[i];
            x[j]:=1;
        end else inc(x[j]);
    end;
    m:=j;
    
    for i:=1 to p do boo[i]:=find(b,n,c[i])<>0;
    boo[p+1]:=true;
    j:=0;
    kq:=0;
    for i:=1 to p+1 do begin
        if (i-1-j>=m)and(boo[i])and(i-1-j>kq)and(check(j+1,i-1)) then begin
            kq:=i-1-j;
        end;
        if boo[i] then j:=i;
    end;
    writeln(kq);
end;

begin
    main();
end.
