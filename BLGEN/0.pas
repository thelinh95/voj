uses math;
type int=integer;

var a, b: array[1..1000] of int64;
g: array[0..1000, 0..1000] of int;
m, n: int;

function sqr(a: int64): int64;
begin
    exit(a*a);
end;
function sqr3(a: int64): int64;
begin
    exit(a*a*a);
end;
function sqrt(a: int64): int64;
begin
    exit(trunc(exp(ln(a)/2)+0.5));
end;
function sqrt3(a: int64): int64;
begin
    exit(trunc(exp(ln(a)/3)+0.5));
end;
function prime(a: int64): boolean;
var k, l: int64;
begin
    if a=1 then exit(false)
    else if a=2 then exit(true)
    else if a mod 2=0 then exit(false)
    else begin
        k:=3;
        l:=sqrt(a);
        while k<=l do begin
            if a mod k=0 then exit(false);
            k:=k+2;
        end;
    end;
    exit(true);
end;
function check(a: int64): boolean;
begin
    if sqr(sqrt(a))=a then exit(true);
    if sqr3(sqrt3(a))=a then if prime(sqrt3(a)) then exit(true);
    exit(false);
end;

procedure nhap;
var f: text;
i, j: int;
t: int64;
begin
    assign(f, '');
    reset(f);
    m:=0;
    while not seekeoln(f) do begin
        read(f, t);
        if check(t) then begin
            m:=m+1;
            a[m]:=t;
        end;
    end;
    readln(f);
    n:=0;
    while not seekeoln(f) do begin
        read(f, t);
        if check(t) then begin
            n:=n+1;
            b[n]:=t;
        end;
    end;
    close(f);
    
    for i:=0 to m do g[i, 0]:=0;
    for j:=0 to n do g[0, j]:=0;
    for i:=1 to m do for j:=1 to n do begin
        if a[i]=b[j] then g[i, j]:=g[i-1, j-1]+1
        else g[i, j]:=max(g[i, j-1], g[i-1, j]);
    end;
    writeln(g[m, n]);
end;

begin
    nhap;
end.
