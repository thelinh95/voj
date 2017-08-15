//*** caauf vaf khowps
//*** spoj: GRAPH_
//*** 2014-12-17
type int=word;
link=^node;
node=record
    d: int;
    next: link;
end;
stype=record
    d, con: int;
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
i, m, u, v: int;
t: link;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m);
    for u:=1 to n do begin
        ke[u]:=nil;
    end;
    for i:=1 to m do begin
        readln(f, u, v);
        new(t);
        t^.d:=v;
        t^.next:=ke[u];
        ke[u]:=t;
        new(t);
        t^.d:=u;
        t^.next:=ke[v];
        ke[v]:=t;
    end;
    close(f);
end;

procedure main_stack;
var i, count, cau, numkhop: int;
num, low, con, trc: array[1..maxn] of int;
khop: array[1..maxn] of boolean;

stack: array[1..maxn] of stype;
sl: int;

procedure push(i: int);
begin
    count:=count+1;
    num[i]:=count;
    low[i]:=count;
    khop[i]:=false;
    con[i]:=0;
    
    sl:=sl+1;
    stack[sl].d:=i;
    stack[sl].con:=0;
    stack[sl].t:=ke[i];
end;
procedure dfs(i: int);
var j: int;
t: link;
begin
    sl:=0;
    push(i);
    
    while sl>0 do begin
        i:=stack[sl].d;
        t:=stack[sl].t;
        j:=stack[sl].con;
        if (j<>0) then begin
            if num[i]<low[j] then cau:=cau+1;
            if trc[i]<>0 then if not khop[i] then if num[i]<=low[j] then khop[i]:=true;
            low[i]:=fmin(low[i], low[j]);
            stack[sl].con:=0;
        end;
        
        if t<>nil then begin
            stack[sl].t:=t^.next;
            j:=t^.d;
            if num[j]<>0 then begin
                if j<>trc[i] then low[i]:=fmin(low[i], num[j]);
            end else begin
                trc[j]:=i;
                con[i]:=con[i]+1;
                stack[sl].con:=j;
                push(j);
            end;
        end else begin
            sl:=sl-1;
        end;
    end;
end;
begin
    count:=0;
    cau:=0;
    numkhop:=0;
    
    for i:=1 to n do begin
        num[i]:=0;
    end;
    for i:=1 to n do if num[i]=0 then begin
        trc[i]:=0;
        dfs(i);
        if con[i]>1 then numkhop:=numkhop+1;
    end;
    for i:=1 to n do if khop[i] then numkhop:=numkhop+1;
    
    write(numkhop, ' ', cau);
end;

procedure main;
var i, count, cau, numkhop: int;
num, low, con, trc: array[1..maxn] of int;
khop: array[1..maxn] of boolean;

procedure try(i: int);
var j: int;
t: link;
begin
    count:=count+1;
    num[i]:=count;
    low[i]:=count;
    khop[i]:=false;
    con[i]:=0;
    
    t:=ke[i];
    while t<>nil do begin
        j:=t^.d;
        if num[j]<>0 then begin
            if j<>trc[i] then low[i]:=fmin(low[i], num[j]);
        end else begin
            con[i]:=con[i]+1;
            trc[j]:=i;
            try(j);
            if num[i]<low[j] then cau:=cau+1;
            if trc[i]<>0 then if not khop[i] then if num[i]<=low[j] then khop[i]:=true;
            low[i]:=fmin(low[i], low[j]);
        end;
        t:=t^.next;
    end;
end;
begin
    count:=0;
    cau:=0;
    numkhop:=0;
    
    for i:=1 to n do begin
        num[i]:=0;
    end;
    for i:=1 to n do if num[i]=0 then begin
        trc[i]:=0;
        try(i);
        if con[i]>1 then numkhop:=numkhop+1;
    end;
    for i:=1 to n do begin
        if khop[i] then numkhop:=numkhop+1;
    end;
    
    write(numkhop, ' ', cau);
end;

begin
    nhap;
    main_stack;
end.
