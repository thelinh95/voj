type int=longint;
pack=record x,y: int; end;
var f: text;
n,i: int;
a: array[1..100000] of pack;
x,y: array[1..100000] of int64;
kq: int64;

begin
    assign(f,'');
    reset(f);
    readln(f,n);
    for i:=1 to n do readln(f,a[i].x,a[i].y);
    fillchar(x,sizeof(x),0);
    fillchar(y,sizeof(y),0);
    for i:=1 to n do begin
        inc(x[a[i].x]);
        inc(y[a[i].y]);
    end;
    kq:=0;
    for i:=1 to n do kq:=kq+(x[a[i].x]-1)*(y[a[i].y]-1);
    writeln(kq);
end.
