const maxn=100020; maxvertex=40; eps=1e-12; inf=1e30;
type rec=record ver,v:longint;  x,y:array[0..maxvertex]of extended;    r:extended; end;
var n,m,i,j,num,x,ans:longint;
    x0,y0,x1,y1:extended;
    a:array[0..maxn]of rec;
    ch:char;
function incircle(x,y:extended; num:longint):boolean;
var dis:extended;
begin
dis:=(x-a[num].x[1])*(x-a[num].x[1])+(y-a[num].y[1])*(y-a[num].y[1]);
if dis-a[num].r*a[num].r>eps then exit(false) else exit(true);
end;
function cross(x1,y1,x2,y2,x3,y3:extended):extended;
begin
exit((x2-x1)*(y3-y1)-(y2-y1)*(x3-x1));
end;
function common(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
var t1,t2:extended;
begin
t1:=cross(x1,y1,x3,y3,x2,y2);
t2:=cross(x1,y1,x4,y4,x2,y2);
if t1*t2>0 then exit(false);
t1:=cross(x3,y3,x2,y2,x4,y4);
t2:=cross(x3,y3,x1,y1,x4,y4);
if t1*t2>0 then exit(false);
exit(true);
end;
function inpolygon(x,y:extended; num:longint):boolean;
var px,py,miny,maxy,x1,x2,y1,y2:extended;
    cnt,i:longint;
begin
cnt:=0;
for i:=1 to a[num].ver do
    begin
    if i<>a[num].ver then begin x1:=a[num].x[i]; y1:=a[num].y[i]; x2:=a[num].x[i+1]; y2:=a[num].y[i+1]; end
       else begin x1:=a[num].x[i]; y1:=a[num].y[i]; x2:=a[num].x[1]; y2:=a[num].y[1]; end;
    if abs(y1-y2)<eps then continue;
    if y1-y2>eps then begin maxy:=y1; px:=x1; end else begin maxy:=y2; px:=x2; end;
    if (abs(maxy-y)<eps)and(x-px>eps) then continue;
    if y1-y2>eps then begin miny:=y2; px:=x2; end else begin miny:=y1; px:=x1; end;
    if (abs(miny-y)<eps)and(x-px>eps) then begin inc(cnt); continue; end;
    if common(-inf,y,x,y,x1,y1,x2,y2) then
       inc(cnt);
    end;
if cnt mod 2=1 then exit(true) else exit(false);
end;
procedure work(x0,y0,x1,y1:extended);
var i,f1,f2:longint;
begin
for i:=1 to n do
    begin
    f1:=-1; f2:=-1;
    if a[i].ver=1 then
       begin
       if incircle(x0,y0,i) then f1:=1 else f1:=0;
       if incircle(x1,y1,i) then f2:=1 else f2:=0;
       end
    else
       begin
       if inpolygon(x0,y0,i) then f1:=1 else f1:=0;
       if inpolygon(x1,y1,i) then f2:=1 else f2:=0;
       end;
    ans:=ans xor ((f1 xor f2)*a[i].v);
    end;
writeln(ans);
end;
begin
assign(input,'nightmare.in');
reset(input);
assign(output,'nightmare.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    read(ch);
    if ch='C' then begin a[i].ver:=1; read(a[i].x[1],a[i].y[1],a[i].r,a[i].v); end   //extended
       else begin
            read(num);
            a[i].ver:=num;
            for j:=1 to num do read(a[i].x[j],a[i].y[j]);
            read(a[i].v);
            end;
    readln;
    end;
for i:=1 to m do
    begin
    read(ch);
    if ch='Q' then
       begin
       read(x0,y0,x1,y1);
       work(x0,y0,x1,y1);
       end
    else
       begin
       read(x,num);
       a[x].v:=num;
       end;
    readln;
    end;
close(input);
close(output);
end.