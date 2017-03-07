//*** BALLGMVN VOI 2014
type long=longint;
int=integer;

var _x, _y: array[1..2000] of long;
n: int;

function gcd(a, b: long): long;
var r: long;
begin
    a:=abs(a);
    while b<>0 do begin
        r:=a mod b;
        a:=b;
        b:=r;
    end;
    exit(a);
end;
procedure swap(var a, b: long);
var tmp: long;
begin
    tmp:=a;
    a:=b;
    b:=tmp;
end;
procedure swap(var a, b: int);
var tmp: int;
begin
    tmp:=a;
    a:=b;
    b:=tmp;
end;

function cmp(a, b, c, d: long): shortint;
begin
    if a>c then exit(1);
    if a<c then exit(-1);
    if b>d then exit(1);
    if b<d then exit(-1);
    exit(0);
end;

procedure xuat(a, b, c: int);
begin
    writeln(a, ' ', b, ' ', c);
    halt;
end;

procedure xl(k: long);
var x, y, cs: array[1..2000] of long;
i, j: int;
g: long;

var xx, yx: long;

procedure sort(l,r: long);
var ll, rr: int;
begin
    ll:=l;
    rr:=r;
    xx:=x[(l+r)div 2];
    yx:=y[(l+r)div 2];
    while ll<=rr do begin
        while cmp(x[ll], y[ll], xx, yx)=-1 do ll:=ll+1;
        while cmp(x[rr], y[rr], xx, yx)=1 do rr:=rr-1;
        if ll<=rr then begin
            swap(x[ll], x[rr]);
            swap(y[ll], y[rr]);
            swap(cs[ll], cs[rr]);
            ll:=ll+1;
            rr:=rr-1;
        end;
    end;
    if l<rr then sort(l, rr);
    if ll<r then sort(ll, r);
end;
begin
    for i:=k+1 to 2*n do begin
        cs[i]:=i;
        
        x[i]:=_x[i]-_x[k];
        y[i]:=_y[i]-_y[k];
        if y[i]<0 then begin
            y[i]:=-y[i];
            x[i]:=-x[i];
        end else if y[i]=0 then begin
            x[i]:=1;
        end;
        g:=gcd(x[i], y[i]);
        x[i]:=x[i] div g;
        y[i]:=y[i] div g;
    end;
    
    sort(k+1, n*2);
    
    for i:=k+1 to 2*n-1 do begin
        j:=i+1;
        if (x[i]=x[j])and(y[i]=y[j]) then begin
            if (cs[i]>n)or(cs[j]>n) then begin
                xuat(k, cs[i], cs[j]);
            end;
        end;
    end;
end;

procedure xxx;
var i: int;
begin
    for i:=1 to n do xl(i);
end;

procedure nhap;
var f: text;
i: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n);
    for i:=1 to 2*n do readln(f, _x[i], _y[i]);
    close(f);
end;

begin
    nhap;
    xxx;
    writeln(-1);
end.
