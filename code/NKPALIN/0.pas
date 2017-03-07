uses math;
var s,t: ansistring;
m,n,i,j: longint;
f: array[0..2000,0..2000] of longint;
begin
    fillchar(f,sizeof(f),0);
    t:='';
    readln(s);
    n:=length(s);
    for i:=length(s) downto 1 do t:=t+s[i];
    for i:=1 to n do for j:=1 to n do begin
        if s[i]=t[j] then f[i,j]:=f[i-1,j-1]+1
        else f[i,j]:=max(f[i-1,j],f[i,j-1]);
    end;
    i:=n;
    j:=n;
    m:=f[n,n];
    while m>0 do begin
        if s[i]=t[j] then begin
            write(s[i]);dec(m);
            dec(i);
            dec(j);
        end else if f[i,j]=f[i-1,j] then dec(i)
        else dec(j);
    end;
end.
