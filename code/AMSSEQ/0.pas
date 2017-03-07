uses math;
type int=longint;
const inf=1000000000;
var n,k: int;
a,b: array[0..10000] of int;

procedure main();
var f: text;
i,j,kq: int;
begin
    assign(f,'');
    reset(f);
    readln(f,n,k);
    for i:=1 to n do read(f,a[i]);
    close(f);
    
    fillchar(b,sizeof(b),0);
    kq:=0;
    for i:=1 to n do begin
        b[i]:=-inf;
        for j:=i-1 downto max(i-k,0) do begin
            b[i]:=max(b[i],b[j]);
        end;
        b[i]:=b[i]+a[i];
        kq:=max(kq,b[i]);
    end;
    assign(f,'');
    rewrite(f);
    writeln(f,kq);
    close(f);
end;

begin
    main();
end.
