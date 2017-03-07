const fi='';
fo='';
maxn=1000;
type point=record
    x,y:int64;
end;
var a:array[1..maxn] of point;
b:array[1..maxn] of int64;
n:longint;
res:int64;
function distance(a,b:point):int64;
var d:int64;
begin
    d:=int64(sqr(a.x-b.x));
    d:=d+int64(sqr(a.y-b.y));
    exit(d);
end;

procedure docfile;
var i:longint;
begin
    assign(input,fi); reset(input);
    readln(n);
    for i:= 1 to n do
    readln(a[i].x,a[i].y);
    close(input);
end;

procedure swap(var x,y:int64);
var z:int64;
begin
    z:=x; x:=y; y:=z;
end;

procedure sort(l,r:longint);
var i,j:longint; x:int64;
begin
    i:=l;
    j:=r;
    x:=b[i+random(j-i)];
    repeat
    while x>b[i] do inc(i);
    while x<b[j] do dec(j);
    if i<=j then
    begin
        swap(b[i],b[j]);
        inc(i);
        dec(j);
    end;
    until i>j;
    if i<r then sort(i,r);
    if l<j then sort(l,j);
end;

procedure thuchien;
var i,j,dem,l,r,t:longint;
begin
    res:=0;
    for i:= 1 to n do
    begin
        dem:=0;
        fillchar(b,sizeof(b),0);
        for j:=1 to n do
        if i<>j then
        begin
            inc(dem);
            b[dem]:=distance(a[i],a[j]);
        end;
        sort(1,dem);
        l:=1;
        while l<=dem do
        begin
            r:=l;
            while (b[r]=b[r+1]) and (r<dem) do inc(r);
            t:=r-l+1;
            res:=res+(t*(t-1)) div 2;
            l:=r+1;
        end;
    end;
end;

begin
    docfile;
    thuchien;
    assign(output,fo); rewrite(output);
    writeln(res);
    close(output);
end.
