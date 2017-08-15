uses math;
type int=longint;
mang=array[1..1000000] of int;
var inf: int=1000000;
var zzz: int64=1000000009;
var m,n,k: int;
ina,inb,x: mang;
prime: array[1..1000000] of boolean;
tmp: array[0..20000000] of int;
function mu(a: int64; b: int): int64;
begin
    if b=0 then exit(1);
    mu:=mu(a, b div 2);
    mu:=mu*mu mod zzz;
    if b and 1=1 then mu:=mu*a mod zzz;
end;
function pow(a: int64): int64;
begin
    if tmp[a]=-1 then tmp[a]:=mu(a,k);
    exit(tmp[a]);
end;
function bac(i,j: int): int;
begin
    bac:=0;
    while j mod i=0 do begin
        inc(bac);
        j:=j div i;
    end;
end;

procedure sang(var xet: mang; z: int);
var i,j: int;
begin
    fillchar(prime,sizeof(prime),true);
    i:=2;
    while i<=inf do begin
        if prime[i] then begin
            j:=i;
            while j<=inf do begin
                if xet[j]>0 then x[i]:=x[i]+z*xet[j]*bac(i,j);
                prime[j]:=false;
                j:=j+i;
            end;
        end;
        inc(i);
    end;
end;

procedure main();
var i,a: int;
kq: int64;
begin
    fillchar(ina,sizeof(ina),0);
    fillchar(inb,sizeof(inb),0);
    fillchar(x,sizeof(x),0);
    for i:=1 to 20000000 do tmp[i]:=-1;
    inf:=0;
    assign(input,''); reset(input);
    readln(m,n,k);
    for i:=1 to m do begin
        read(a);
        inf:=max(inf,a);
        inc(ina[a]);
    end;
    for i:=1 to n do begin
        read(a);
        inf:=max(inf,a);
        inc(inb[a]);
    end;
    close(input);
    sang(ina,-1);
    sang(inb,1);
    for i:=1 to inf do if x[i]<0 then begin
        writeln(0);
        exit();
    end;
    kq:=1;
    for i:=2 to inf do if x[i]>0 then begin
        kq:=kq*((pow(x[i]+1)-2*pow(x[i])+pow(x[i]-1)+2*zzz) mod zzz) mod zzz;
    end;
    writeln(kq);
end;

begin
    main();
end.
