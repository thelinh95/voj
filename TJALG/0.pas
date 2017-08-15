//*** tarjan algorithm
//*** 2014-12-17

type int=longint;
link=^node;
node=record
    d: int;
    next: link;
end;
stype=record
    d, son: int;
    t: link;
end;

const maxn=10000;

var n: int;
ke: array[1..maxn] of link;

function fmin(a, b: int): int;
begin
    if a>b then exit(b) else exit(a);
end;

procedure nhap;
var f: text;
i, u, v, m: int;
t: link;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m);
    for i:=1 to n do begin
        ke[i]:=nil;
    end;
    for i:=1 to m do begin
        readln(f, u, v);
        new(t);
        t^.d:=v;
        t^.next:=ke[u];
        ke[u]:=t;
    end;
    close(f);
end;

procedure tarjan_stack;
var s, p, num, low: array[1..maxn] of int;
i, top, sv, count: int;

var stack: array[1..maxn] of stype;
sl: int;

procedure push(i: int);
begin
    count:=count+1;
    num[i]:=count;
    low[i]:=count;
    top:=top+1;
    s[top]:=i;
    
    sl:=sl+1;
    stack[sl].d:=i;
    stack[sl].t:=ke[i];
    stack[sl].son:=0;
end;
procedure dfs(i: int);
var t: link;
j: int;
begin
    sl:=0;
    push(i);
    
    while sl>0 do begin
        i:=stack[sl].d;
        t:=stack[sl].t;
        if stack[sl].son<>0 then begin
            low[i]:=fmin(low[i], low[stack[sl].son]);
            stack[sl].son:=0;
        end;
        
        if t<>nil then begin
            stack[sl].t:=t^.next;
            j:=t^.d;
            if p[j]=0 then begin
                if num[j]=0 then begin
                    stack[sl].son:=j;
                    push(j);
                end else begin
                    low[i]:=fmin(low[i], num[j]);
                end;
            end;
        end else begin
            if low[i]=num[i] then begin
                sv:=sv+1;
                while s[top]<>i do begin
                    p[s[top]]:=sv;
                    top:=top-1;
                end;
                p[i]:=sv;
                top:=top-1;
            end;
            sl:=sl-1;
        end;
    end;
end;

begin
    sv:=0;
    top:=0;
    count:=0;
    for i:=1 to n do begin
        p[i]:=0;
        num[i]:=0;
    end;
    for i:=1 to n do if p[i]=0 then dfs(i);
    
    writeln(sv);
    //for i:=1 to n do write(p[i], ' ');
    //writeln;
end;

procedure tarjan;
var s, p, num, low: array[1..maxn] of int;
i, top, sv, count: int;

procedure try(i: int);
var t: link;
j: int;
begin
    count:=count+1;
    num[i]:=count;
    low[i]:=count;
    top:=top+1;
    s[top]:=i;
    
    t:=ke[i];
    while t<>nil do begin
        j:=t^.d;
        if p[j]=0 then begin
            if num[j]=0 then begin
                try(j);
                low[i]:=fmin(low[i], low[j]);
            end else begin
                low[i]:=fmin(low[i], num[j]);
            end;
        end;
        t:=t^.next;
    end;
    
    if low[i]=num[i] then begin
        sv:=sv+1;
        while s[top]<>i do begin
            p[s[top]]:=sv;
            top:=top-1;
        end;
        p[i]:=sv;
        top:=top-1;
    end;
end;
begin
    sv:=0;
    top:=0;
    count:=0;
    for i:=1 to n do begin
        p[i]:=0;
        num[i]:=0;
    end;
    for i:=1 to n do if p[i]=0 then try(i);
    
    writeln(sv);
    for i:=1 to n do write(p[i], ' ');
    writeln;
end;

begin
    nhap;
    tarjan_stack;
end.
