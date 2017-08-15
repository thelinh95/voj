type int=longint;
var n,m: int;
a,f: array[1..20000] of int64;

function push(a: int64): int64;
var i,j: int;
tmp: int64;
begin
    inc(m);
    f[m]:=a;
    i:=m;
    while i>1 do begin
        j:=i div 2;
        if f[j]<=f[i] then break;
        tmp:=f[i];
        f[i]:=f[j];
        f[j]:=tmp;
        i:=j;
    end;
    exit(a);
end;
function get(): int64;
var i,j: int;
tmp: int64;
begin
    get:=f[1];
    f[1]:=f[m];
    dec(m);
    i:=1;
    while i*2<=m do begin
        j:=i*2;
        if (j<m)and(f[j+1]<f[j]) then j:=j+1;
        if f[i]<=f[j] then break;
        tmp:=f[i];
        f[i]:=f[j];
        f[j]:=tmp;
        i:=j;
    end;
end;

function calc(): int64;
var i: int;
kq: int64;
begin
    if n=1 then exit(a[1]);
    m:=0;
    kq:=0;
    for i:=1 to n do push(a[i]);
    while m>1 do inc(kq,push(get()+get()));
    exit(kq);
end;

procedure main();
var f: text;
t,i: int;
begin
    assign(f,'');
    reset(f);
    readln(f,t);
    while t>0 do begin
        readln(f,n);
        for i:=1 to n do read(f,a[i]);
        writeln(calc());
        dec(t);
    end;
end;

begin
    main();
end.
