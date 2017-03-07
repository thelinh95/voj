type int=longint;
var top: int;
a,s,l,r: array[0..30000] of int;

procedure push(i: int);
begin
    while (top>0)and(a[s[top]]>=a[i]) do dec(top);
    inc(top);
    s[top]:=i;
end;

procedure xl(n: int);
var i: int;
begin
    top:=0;
    s[0]:=0;
    for i:=1 to n do begin
        push(i);
        l[i]:=s[top-1]+1;
    end;
    top:=0;
    s[0]:=n+1;
    for i:=n downto 1 do begin
        push(i);
        r[i]:=s[top-1]-1;
    end;
    top:=1;
    for i:=2 to n do begin
        if (r[i]-l[i]+1)*a[i]>(r[top]-l[top]+1)*a[top] then top:=i
        else if (r[i]-l[i]+1)*a[i]=(r[top]-l[top]+1)*a[top] then begin
            if l[i]<l[top] then top:=i;
        end;
    end;
    writeln((r[top]-l[top]+1)*a[top],' ',l[top],' ',r[top]);
end;

procedure main();
var f: text;
m,n,i: int;
begin
    assign(f,'');
    reset(f);
    readln(f,m);
    for m:=m downto 1 do begin
        readln(f,n);
        for i:=1 to n do read(f,a[i]);
        readln(f);
        xl(n);
    end;
    close(f);
end;

begin
    main();
end.
