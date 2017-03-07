type int=longint;
const di:array[1..4] of int=(-1,0,1,0);
dj:array[1..4] of int=(0,1,0,-1);
inf:int=110;
var n,top: int;
a,p: array[0..101,0..101] of int;

function check(k: int): boolean;
var l,r: int;
function dfs(i,j: int): boolean;
var k: int;
kq: boolean;
begin
    if (a[i,j]>inf)or(p[i,j]=top) then exit(false);
    if (a[i,j]<l)or(a[i,j]>r) then exit(false);
    if (i=n)and(j=n) then exit(true);
    p[i,j]:=top;
    kq:=false;
    for k:=1 to 4 do begin
        kq:=kq or dfs(i+di[k],j+dj[k]);
    end;
    exit(kq);
end;
begin
    for r:=k to inf do begin
        l:=r-k;
        inc(top);
        if dfs(1,1) then exit(true);
    end;
    exit(false);
end;

procedure main();
var f: text;
i,j,l,r: int;
begin
    assign(f,'');reset(f);
    readln(f,n);
    for i:=0 to n+1 do for j:=0 to n+1 do a[i,j]:=inf+1;
    for i:=1 to n do begin
        for j:=1 to n do read(f,a[i,j]);
        readln(f);
    end;
    close(f);
    fillchar(p,sizeof(p),0);
    top:=0;
    l:=0;
    r:=inf;
    while l<=r do begin
        i:=(l+r) div 2;
        if check(i) then r:=i-1
        else l:=i+1;
    end;
    writeln(l);
end;

begin
    main();
end.
