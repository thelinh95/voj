type byte=integer;

var m,n:byte;
a:array[0..1000,0..1000] of longint;
v:int64;
b:array[0..1000,0..1000] of 0..2;
kt:boolean;


procedure nhap;
var i,j:byte;
f:text;
min: longint;
begin
    fillchar(a, sizeof(a), 0);
    v:=0;
    assign(f,'');
    reset(f);
    readln(f,m,n);
    min:=1000001;
    for i:=1 to m do begin
        for j:=1 to n do begin
            read(f,a[i,j]);
            if a[i,j]<min then min:=a[i,j];
        end;
        readln(f);
    end;
    close(f);
    
    for i:=1 to m do for j:=1 to n do a[i, j]:=a[i, j]-min;
end;

procedure xet(i,j:byte);
begin
    b[i,j]:=2;
    if (i>0)and(a[i-1,j]=0)and(b[i-1,j]=1) then xet(i-1,j);
    if (i<m+1)and(a[i+1, j]=0)and(b[i+1,j]=1) then xet(i+1,j);
    if (j>0)and(a[i,j-1]=0)and(b[i,j-1]=1) then xet(i,j-1);
    if (j<n+1)and(a[i,j+1]=0)and(b[i,j+1]=1) then xet(i,j+1);
end;

procedure tinh;
var i,j:byte;
min: longint;
begin
    fillchar(b,sizeof(b),1);
    min:=1000001;
    for i:=1 to m do for j:=1 to n do begin
        if a[i,j]>0 then begin
            if a[i, j]<min then min:=a[i,j];
        end;
    end;
    xet(0,0);
    for i:=1 to m do for j:=1 to n do begin
        if (a[i, j]=0)and(b[i,j]=1) then v:=v+min;
        if a[i,j]>0 then a[i,j]:=a[i,j]-min;
        if a[i,j]>0 then kt:=false;
    end;
    
end;

procedure xl;
var count: longint;
begin
    repeat
    count:=count+1;
    kt:=true;
    tinh;
    until kt;
    //writeln(count);
end;

begin
    nhap;
    xl;
    writeln(v);
end.
