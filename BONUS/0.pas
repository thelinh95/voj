program bonus;
uses crt;
type integer=longint;
const fi='';
var c,a : array[0..1000,0..1000] of integer;
b,t : array[0..1000] of integer;
n,m,kq : integer;
procedure enter;
var i,j : integer;
g : text;
begin
    assign(g,fi); reset(g);
    readln(g,n,m);
    for i:=1 to n do
    begin
        for j:=1 to n do read(g,a[i,j]);
        readln(g);
    end;
    close(g);
    kq:=0;
end;
procedure init;
var i,j : integer;
begin
    c[1,1]:=a[1,1];
    for i:=2 to n do
    c[i,1]:=c[i-1,1]+a[i,1];
    for j:=2 to n do
    c[1,j]:=c[1,j-1]+a[1,j];
    for i:=2 to n do
    begin
        for j:=2 to n do
        c[i,j]:=a[i,j]+c[i-1,j]+c[i,j-1]-c[i-1,j-1];
    end;
end;
procedure th;
var i,j,k : integer;
begin
    init;
    for i:=1 to n-m+1 do
    begin
        for j:=1 to n-m+1 do
        begin
            if kq<(c[i+m-1,j+m-1]-c[i+m-1,j-1]-c[i-1,j+m-1]+c[i-1,j-1]) then
            kq:=c[i+m-1,j+m-1]-c[i+m-1,j-1]-c[i-1,j+m-1]+c[i-1,j-1];
        end;
    end;
    writeln(kq);
end;
begin
    clrscr;
    enter;
    th;
end.
