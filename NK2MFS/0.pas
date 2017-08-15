uses math;

type int=longint;

var a, b, x, y: array[1..10000] of int;
n, p, q: int;

procedure xepx;
var tmp, g: int;

procedure sort(l, r: int);
var i, j: int;
begin
    i:=l;
    j:=r;
    g:=a[x[(l+r) div 2]];
    while i<=j do begin
        while a[x[i]]<g do i:=i+1;
        while a[x[j]]>g do j:=j-1;
        if i<=j then begin
            tmp:=x[i];x[i]:=x[j];x[j]:=tmp;
            i:=i+1;
            j:=j-1;
        end;
    end;
    if l<j then sort(l, j);
    if i<r then sort(i, r);
end;
begin
    sort(1, p);
end;

procedure xepy;
var tmp, g: int;

procedure sort(l, r: int);
var i, j: int;
begin
    i:=l;
    j:=r;
    g:=b[y[(l+r) div 2]];
    while i<=j do begin
        while b[y[i]]>g do i:=i+1;
        while b[y[j]]<g do j:=j-1;
        if i<=j then begin
            tmp:=y[i];y[i]:=y[j];y[j]:=tmp;
            i:=i+1;
            j:=j-1;
        end;
    end;
    if l<j then sort(l, j);
    if i<r then sort(i, r);
end;
begin
    sort(1, q);
end;

procedure chia;
var i: int;
begin
    p:=0;
    q:=0;
    for i:=1 to n do begin
        if a[i]<=b[i] then begin
            p:=p+1;
            x[p]:=i;
        end else begin
            q:=q+1;
            y[q]:=i;
        end;
    end;
end;

procedure nhap;
var f:text;
i: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n);
    for i:=1 to n do read(f, a[i]);
    readln(f);
    for i:=1 to n do read(f, b[i]);
    close(f);
end;

procedure xuat;
var i: int;
ta, tb: int;
begin
    ta:=0;
    tb:=0;
    for i:=1 to p do begin
        ta:=ta+a[x[i]];
        tb:=max(ta, tb)+b[x[i]];
    end;
    for i:=1 to q do begin
        ta:=ta+a[y[i]];
        tb:=max(ta, tb)+b[y[i]];
    end;
    writeln(max(ta, tb));
    for i:=1 to p do write(x[i], ' ');
    for i:=1 to q do write(y[i], ' ');
end;

begin
    nhap;
    chia;
    xepx;
    xepy;
    xuat;
end.
