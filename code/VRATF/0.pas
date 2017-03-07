var n, k, kq: longint;

procedure try(n: longint);
begin
    if(n>k)and((n xor k) and 1=0) then begin
        try((n+k)shr 1);
        try((n-k)shr 1);
    end else inc(kq);
end;

begin
    readln(n, k);
    kq:=0;
    try(n);
    writeln(kq);
end.
