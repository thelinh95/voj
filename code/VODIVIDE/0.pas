//*** spoj vodivide VOI 2015 (2015-04-16)
uses math;
type int=longint;
const inf=2100000000;
var f: text;
n, i, j, top: int;
a, b, c, idx: array[1..5000] of int;
g: array[0..5000, -1..5000] of int;

procedure swap(var a, b: int);
var tmp: int;
begin
    tmp:=a;
    a:=b;
    b:=tmp;
end;

begin
    assign(f, '');
    reset(f);
    readln(f, n);
    for i:=1 to n do read(f, a[i]);
    readln(f);
    for i:=1 to n do read(f, b[i]);
    close(f);
    
    for i:=1 to n do idx[i]:=i;
    for j:=1 to n do for i:=1 to n-1 do begin
        if a[i]>a[i+1] then begin
            swap(a[i], a[i+1]);
            swap(b[i], b[i+1]);
            swap(idx[i], idx[i+1]);
        end;
    end;
    
    fillchar(g, sizeof(g), 0);
    for i:=0 to n do begin
        g[i, -1]:=-inf;
    end;
    for i:=1 to n do begin
        for j:=0 to i do begin
            g[i, j]:=max(g[i-1, j+1], g[i-1, j-1]+b[i]);
        end;
    end;
    
    i:=n;
    j:=0;
    while i>0 do begin
        if g[i, j]=g[i-1, j+1] then begin
            c[i]:=0;
            j:=j+1;
        end else begin
            c[i]:=1;
            j:=j-1;
        end;
        i:=i-1;
    end;
    top:=0;
    for i:=1 to n do begin
        if c[i]=1 then begin
            top:=top+1;
            a[top]:=idx[i];
        end else begin
            b[idx[i]]:=a[top];
            b[a[top]]:=idx[i];
            top:=top-1;
        end;
    end;
    assign(f, '');
    rewrite(f);
    writeln(f, g[n, 0]);
    for i:=1 to n do if b[i]>i then begin
        writeln(f, i, ' ', b[i]);
    end;
    close(f);
end.
