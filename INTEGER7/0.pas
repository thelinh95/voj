//*** integer7

type long=int64;

var a1, b1, a2, b2: long;

procedure calc(a, b, c: long);
var r0, r1, r2, x0, x1, x2, y0, y1, y2, q: long;
x, y, a_, b_, d: long;
min, xx, yy: long;
begin
    r0:=a;
    r1:=b;
    x0:=1;
    y0:=0;
    x1:=0;
    y1:=1;
    
    while r1<>0 do begin
        q:=r0 div r1;
        r2:=r0 mod r1;
        x2:=x0-q*x1;
        y2:=y0-q*y1;
        
        r0:=r1;
        r1:=r2;
        x0:=x1;
        y0:=y1;
        x1:=x2;
        y1:=y2;
    end;
    
    x0:=x0*(c div r0);
    y0:=y0*(c div r0);
    
    a_:=a div r0;
    b_:=b div r0;
    
    {if (x0>=0)and(y0>=0) then writeln(x0, ' ', y0)
    else begin
        d:=-1;
        while d<=1 do begin
            x:=x0+b_*d;
            y:=y0-a_*d;
            if (x>=0)and(y>=0) then begin
                writeln(x, ' ', y);
                break;
            end;
            d:=d+2;
        end;
    end;}
    d:=-10000;
    min:=1000000000000000000;
    while d<=10000 do begin
        x:=x0+b_*d;
        y:=y0-a_*d;
        if (x>=0)and(y>=0) then begin
            if min>x+y then begin
                min:=x+y;
                xx:=x;
                yy:=y;
            end;
        end;
        d:=d+1;
    end;
    write(xx, ' ', yy);
end;

begin
    readln(a1, b1, a2, b2);
    calc(a1, -a2, b2-b1);
end.
