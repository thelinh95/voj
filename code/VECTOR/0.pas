uses math;
type int=longint;
pack=record x,y: int; end;
var n,m: int;
a: array[1..30] of pack;
b: array[1..40000] of pack;
c: array[0..40000] of int;
z: pack;

function cmp(a,b: pack): int;
begin
    if a.x<b.x then exit(-1);
    if a.x>b.x then exit(1);
    if a.y<b.y then exit(-1);
    if a.y>b.y then exit(1);
    exit(0);
end;

function get(x,l,r: int): pack;
var i: int;
this: pack;
begin
    this.x:=0;
    this.y:=0;
    for i:=l to r do begin
        if x mod 2=1 then begin
            this.x:=this.x+a[i].x;
            this.y:=this.y+a[i].y;
        end;
        x:=x div 2;
    end;
    exit(this);
end;

procedure qsort();
var i,m1: int;
procedure sort(l,r: int);
var i,j: int;
x,tmp: pack;
begin
    i:=l; j:=r;
    x:=b[l+random(r-l+1)];
    while i<=j do begin
        while cmp(b[i],x)=-1 do inc(i);
        while cmp(b[j],x)=1 do dec(j);
        if i<=j then begin
            tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
            inc(i); dec(j);
        end;
    end;
    if l<j then sort(l,j);
    if i<r then sort(i,r);
end;
begin
    fillchar(c,sizeof(c),0);
    sort(1,m);
    m1:=1;
    c[1]:=1;
    for i:=2 to m do if cmp(b[i],b[i-1])<>0 then begin
        inc(m1);
        b[m1]:=b[i];
        c[m1]:=1;
    end else inc(c[m1]);
    m:=m1;
end;

function find(k: pack): int;
var l,r,i: int;
begin
    l:=1;
    r:=m;
    while l<=r do begin
        i:=(l+r) div 2;
        if cmp(k,b[i])=0 then exit(i);
        if cmp(b[i],k)=1 then r:=i-1
        else l:=i+1;
    end;
    exit(0);
end;

procedure main();
var fi: text;
i,kq: int;
this: pack;
begin
    assign(fi,'');
    reset(fi);
    readln(fi,n);
    for i:=1 to n do readln(fi,a[i].x,a[i].y);
    readln(fi,z.x,z.y);
    close(fi);
    m:=0;
    for i:=0 to 2**(n div 2)-1 do begin
        inc(m);
        b[m]:=get(i,1,n div 2);
    end;
    qsort();
    kq:=0;
    for i:=0  to 2**(n-n div 2)-1 do begin
        this:=get(i,n div 2+1,n);
        this.x:=z.x-this.x;
        this.y:=z.y-this.y;
        kq:=kq+c[find(this)];
    end;
    writeln(kq);
end;

begin
    randomize();
    main();
end.
