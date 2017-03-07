uses math;
type int=longint;
var m,n,kq: int;
a,c,d: array[1..100,1..100] of int;
b: array[1..100,1..100] of char;

function try(i,j: int): boolean;
var k,this,l,r: int;
x: array[1..100] of int;
begin
    if j>n then exit(true);
    if b[i,j]='0' then exit(try(i,j+1));
    this:=0;
    for k:=1 to kq do if(d[i,k]=0)and(c[j,k]=0)then begin
        inc(this);
        x[this]:=k;
    end;
    for l:=1 to this do begin
        r:=random(this)+1;
        k:=x[l]; x[l]:=x[r]; x[r]:=k;
    end;
    for l:=1 to this do begin
        k:=x[l];
        d[i,k]:=1;
        c[j,k]:=1;
        a[i,j]:=k;
        if try(i,j+1) then exit(true);
        d[i,k]:=0;
        c[j,k]:=0;
        a[i,j]:=0;
    end;
    exit(false);
end;

procedure main();
var i,j,k,this: int;
ok: boolean;
begin
    assign(input,'');
    reset(input);
    readln(m,n);
    for i:=1 to m do begin
        for j:=1 to n do read(b[i,j]);
        readln;
    end;
    close(input);
    fillchar(a,sizeof(a),0);
    fillchar(c,sizeof(c),0);
    fillchar(d,sizeof(d),0);
    kq:=0;
    for i:=1 to m do begin
        this:=0;
        for j:=1 to n do this:=this+int(b[i,j]='1');
        kq:=max(kq,this);
    end;
    for i:=1 to n do begin
        this:=0;
        for j:=1 to m do this:=this+int(b[j,i]='1');
        kq:=max(kq,this);
    end;
    for i:=1 to m do try(i,1);
    writeln(kq);
    for i:=1 to m do begin
        for j:=1 to n do write(a[i,j],' ');
        writeln;
    end;
end;

begin
    randomize();
    main();
end.
