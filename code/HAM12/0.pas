type int=integer;

const inf=10000;

var n, m, k: int;
mau:array[1..100, 1..1000] of char;
la: array[1..2000] of char;

procedure nhap;
var f:text;
i, j: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m, k);
    for i:=1 to n do read(f, la[i]);
    readln(f);
    for i:=1 to k do begin
        for j:=1 to m do read(f, mau[i, j]);
        readln(f);
    end;
    close(f);
end;

procedure xl;
var i, j, l: int;
nd, kq, this: int;
begin
    nd:=n;
    for i:=1 to m-1 do begin
        n:=n+1;
        la[n]:=la[i];
    end;
    
    kq:=inf;
    for i:=1 to k do begin
        for j:=1 to nd do begin
            this:=0;
            for l:=1 to m do begin
                if mau[i, l]<>la[l+j-1] then begin
                    this:=this+1;
                    if this>=kq then break;
                end;
            end;
            if kq>this then kq:=this;
        end;
    end;
    write(kq);
end;

begin
    nhap;
    xl;
end.
