const   finp='';
fout='';
nmax=770;
dx:array[1..8] of longint=(1,1,-1,-1,1,-1,0,0);
dy:array[1..8] of longint=(1,-1,1,-1,0,0,1,-1);
type
data=longint;
dulieu=record
    u,v:longint;
end;
var
fi,fo:text;
ok:boolean;
a,tham:array[0..nmax+1,0..nmax+1] of longint;
m,n,s,t,kq,q,p:data;
dd:array[0..nmax+1,0..nmax+1] of boolean;
dau,cuoi:data;

procedure docfile;
var     i,j,u,v:data;
begin
    assign(fi,finp); reset(fi);
    readln(fi,n,m);
    for i:=1 to n do begin
        for j:=1 to m do read(fi,a[i,j]);
        readln(fi);
    end;
    close(fi);
end;

procedure dfs(u,v:longint);
var     i,j,x,y:data;
begin
    if dd[u,v]then begin ok:=false;exit;end;
    dd[u,v]:=true;
    for i:=1 to 8 do begin
        x:=u+dx[i];
        y:=v+dy[i];
        if (x>0)and(x<=n)and(y>0)and(y<=m)then begin
            if (a[x,y]>a[u,v])then ok:=false;
            if (not dd[x,y])and (a[x,y]=a[u,v])then dfs(x,y);
        end;
    end;
end;

procedure inkq;
var i,j:longint;
begin
    for i:=1 to n do
    for j:=1 to m do
    begin
        ok:=true;
        dfs(i,j);
        if ok then inc(kq);
    end;
end;

begin
    docfile;
    inkq;
    assign(fo,fout);rewrite(fo);
    write(fo,kq);
    close(fo);
end.
