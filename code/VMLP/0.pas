//*** VMLP spoj

type int=integer;
link=^node;
node=record
    d: int;
    next: link;
end;

var n, m, lla: int;
ke: array[1..1000] of link;
free: array[1..1000] of boolean;
bac, cha, la: array[1..1000] of int;

max: int;

ci, cj: array[1..1000] of boolean;
kq: array[1..1000] of int;

_x, _type, _la1, _la2: int;

procedure nhap;
var f: text;
t: link;
i, u, v: int;
begin
    assign(f, '');
    reset(f);
    readln(f, n, m);
    for i:=1 to n do ke[i]:=nil;
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
end;

procedure dfs(x: int);
var t: link;
tt: boolean;
begin
    t:=ke[x];
    tt:=true;
    while t<>nil do begin
        if free[t^.d] then begin
            free[t^.d]:=false;
            cha[t^.d]:=x;
            bac[t^.d]:=bac[x]+1;
            tt:=false;
            dfs(t^.d);
        end;
        t:=t^.next;
    end;
    
    if tt then begin
        lla:=lla+1;
        la[lla]:=x;
    end;
end;

function lca(i, j: int): int;
var k: int;
begin
    for k:=1 to n do begin
        ci[k]:=false;
        cj[k]:=false;
    end;
    ci[i]:=true;
    cj[j]:=true;
    
    while true do begin
        if cha[i]<>0 then begin
            ci[cha[i]]:=true;
            i:=cha[i];
        end;
        if cha[j]<>0 then begin
            cj[cha[j]]:=true;
            j:=cha[j];
        end;
        
        if ci[j] and cj[i] then begin
            if bac[i]>bac[j] then exit(j)
            else exit(i);
        end else if ci[j] then exit(j)
        else if cj[i] then exit(i);
    end;
end;

procedure truyvet2(la1, la2, x: int);
var i: int;
begin
    for i:=1 to bac[la1]+1 do begin
        kq[i]:=la1;
        la1:=cha[la1];
    end;
    for i:=max downto max-bac[la2]+1 do begin
        kq[i]:=la2;
        la2:=cha[la2];
    end;
end;

procedure truyvet1(la, x: int);
var i: int;
begin
    for i:=1 to max do begin
        kq[i]:=la;
        la:=cha[la];
    end;
end;

procedure qsort;
var tmp, x: int;

procedure sort(l, r: int);
var i, j: int;
begin
    i:=l;
    j:=r;
    x:=bac[la[(l+r)div 2]];
    while i<=j do begin
        while bac[la[i]]>x do i:=i+1;
        while bac[la[j]]<x do j:=j-1;
        if i<=j then begin
            tmp:=la[i];
            la[i]:=la[j];
            la[j]:=tmp;
            i:=i+1;
            j:=j-1;
        end;
    end;
    if l<j then sort(l, j);
    if i<r then sort(i, r);
end;
begin
    sort(1, lla);
end;

procedure xl;
var x, i, j, lim: int;
begin
    max:=-1;
    for x:=1 to n do begin
        lla:=0;
        for i:=1 to n do begin
            free[i]:=true;
        end;
        free[x]:=false;
        cha[x]:=0;
        bac[x]:=0;
        dfs(x);
        qsort;
        
        for i:=1 to lla do
        if max<bac[la[i]]+1 then begin
            max:=bac[la[i]]+1;
            _type:=1;
            _la1:=la[i];
            _x:=x;
        end else break;
        
        lim:=lla;
        for i:=1 to lla do begin
            if i+1<lim then break;
            for j:=i+1 to lim do begin
                if max>=bac[la[i]]+bac[la[j]]+1 then begin
                    lim:=j-1;
                    break;
                end else if lca(la[i], la[j])=x then begin
                    max:=bac[la[i]]+bac[la[j]]+1;
                    _type:=2;
                    _la1:=la[i];
                    _la2:=la[j];
                    _x:=x;
                end;
            end;
        end;
        if max=n then break;
    end;
    
    writeln(max);
    for i:=1 to n do begin
        free[i]:=true;
    end;
    free[_x]:=false;
    cha[_x]:=0;
    bac[_x]:=0;
    dfs(_x);
    if _type=1 then truyvet1(_la1, _x)
    else if _type=2 then truyvet2(_la1, _la2, _x);
    
    for i:=max downto 1 do write(kq[i], ' ')
end;

begin
    nhap;
    xl;
end.
