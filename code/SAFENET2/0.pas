//*** find biconnected components
//*** spoj: SAFENET2

type int=word;
link=^node;
node=record
    d: int;
    next: link;
end;

const maxn=30000;

var n, max: int;
ke: array[1..maxn] of link;

function fmin(a, b: int): int;
begin
    if a>b then exit(b) else exit(a);
end;

procedure nhap;
var f: text;
i, m: longint;
u, v: int;
t: link;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m);
    for u:=1 to n do ke[u]:=nil;
    for i:=1 to m do begin
        readln(f, u, v);
        new(t);
        t^.d:=u;
        t^.next:=ke[v];
        ke[v]:=t;
        new(t);
        t^.d:=v;
        t^.next:=ke[u];
        ke[u]:=t;
    end;
    close(f);
    
    if m>0 then max:=2 else max:=1;
end;

procedure main;
var num, low, trc, last: array[1..maxn] of int;
count, i, this, comm: int;

s: array[1..2*maxn] of int;
top: longint;


procedure try(i: int);
var j: int;
t: link;
begin
    count:=count+1;
    num[i]:=count;
    low[i]:=count;
    
    t:=ke[i];
    while t<>nil do begin
        j:=t^.d;
        if num[j]<>0 then begin
            if j<>trc[i] then low[i]:=fmin(low[i], num[j]);
        end else begin
            top:=top+1;
            s[top]:=i;
            trc[j]:=i;
            try(j);
            
            if (num[i]<=low[j]) then begin
                this:=0;
                comm:=comm+1;
                repeat
                if last[s[top]]<comm then begin
                    last[s[top]]:=comm;
                    this:=this+1;
                end;
                top:=top-1;
                until s[top+1]=i;
                //writeln(this);
                if this>max then max:=this;
            end;
            low[i]:=fmin(low[i], low[j]);
        end;
        t:=t^.next;
    end;
    top:=top+1;
    s[top]:=i;
end;
begin
    for i:=1 to n do begin
        num[i]:=0;
        last[i]:=0;
    end;
    comm:=0;
    count:=0;
    top:=0;
    
    for i:=1 to n do if num[i]=0 then begin
        trc[i]:=0;
        try(i);
    end;
end;

begin
    nhap;
    main;
    writeln(max);
end.
