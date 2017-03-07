const input='';
output='';
var   tuch:array[1..8] of string=('k','ko','ng','n','dc','hok','ntn','kq');
tuth:array[1..8] of string=('khong','khong','nguoi','nhieu','duoc','khong','nhu the nao','ket qua');
chch:array[1..5] of string=('j','w','f','dz','z');
chth:array[1..5] of string=('gi','qu','ph','d','d');
f:text;
s:ansistring;

procedure xuly1(i:longint);
var     j:longint;
begin
    j:=pos(tuch[i],s);
    while (j>0)  do
    begin
        if (s[j-1]=' ') and ((s[j+length(tuch[i])]=' ') or (not (s[j+length(tuch[i])] in ['a'..'z']))) then begin
            insert(tuth[i],s,j);
            delete(s,j+length(tuth[i]),length(tuch[i]));
        end else begin
            insert('Z',s,j);
            delete(s,j+length('Z'),length(tuch[i]));            	
        end;
        j:=pos(tuch[i],s);
    end;
    j:=pos('Z',s);
    while (j>0)  do
    begin
        insert(tuch[i],s,j);
        delete(s,j+length(tuch[i]),length('Z'));
        j:=pos('Z',s);
    end;
end;

procedure xuly2(i:longint);
var j:longint;
begin
    j:=pos(chch[i],s);
    while (j>0) do
    begin
        insert(chth[i],s,j);
        delete(s,j+length(chth[i]),length(chch[i]));
        j:=pos(chch[i],s);
    end;
end;

procedure docfile;
var    i:longint;
begin
    assign(f,input);
    reset(f);
    readln(f,s);
    close(f);
    s:=' '+s+' ';
    for i:= 1 to 8 do xuly1(i);
    for i:= 1 to 5 do xuly2(i);
    assign(f,output);
    rewrite(f);
    delete(s,1,1);
    delete(s,length(s),1);
    writeln(f,s);
    close(f);
end;

begin
    docfile;
end.
