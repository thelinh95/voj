type word=longint;

var g, a, _g, f, _f: array[0..100001] of word;
n: word;

procedure docfile;
var f: text;
i: word;
begin
    //assign(f, fi);reset(f);
    readln(n);
    for i:=n downto 1 do begin
        read(a[i]);
    end;
    {for i:=1 to n do write(a[i], ' ');
    writeln;}
    //close(f);
end;

function find(i, r: word): word;
var l, j: word;
begin
    l:=1;
    
    while (l<=r) do begin
        j:=(l+r)div 2;
        if a[f[j]]>=a[i] then r:=j-1
        else l:=j+1;
    end;
    exit(r);
end;

procedure xl;
var i, j, max, u: word;
begin
    f[0]:=0;
    max:=0;
    for i:=1 to n do begin
        _f[i]:=0;
        f[i]:=0;
        j:=find(i, max);
        if max<j+1 then max:=j+1;
        f[j+1]:=i;
        _f[i]:=j+1;
    end;
    
    {for i:=1 to n do write(_f[i], ' ');
    writeln;}
end;

function find1(i, r: word): word;
var l, j: word;
begin
    l:=1;
    j:=(l+r) div 2;
    
    while l<=r do begin
        j:=(l+r) div 2;
        if a[g[j]]<=a[i] then r:=j-1
        else l:=j+1;
    end;
    exit(r);
end;

procedure xl1;
var i, j, max, u: word;
begin
    g[0]:=0;
    max:=0;
    for i:=1 to n do begin
        g[i]:=0;
        _g[i]:=0;
        j:=find1(i, max);
        if max<j+1 then max:=j+1;
        g[j+1]:=i;
        _g[i]:=j+1;
    end;
    
    {for i:=1 to n do write(_g[i], ' ');
    writeln;}
end;

procedure anon;
var max, i: word;
begin
    max:=0;
    for i:=1 to n do if max<_f[i]+_g[i]-1 then max:=_f[i]+_g[i]-1;
    writeln(max);
end;

begin
    docfile;
    xl;
    xl1;
    anon;
end.
