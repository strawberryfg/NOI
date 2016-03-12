const maxn=2020; maxm=3000020; maxq=5000020; inf=maxlongint;
type rec=record x,y:longint; end;
     newtype=record x1,y1,x2,y2:longint; end;
     gtype=record v,nxt:longint; w:extended; end;
var n,i,j,st,en,sx,ex,sy,ey,tmp,tot,head,tail:longint;
    v,ans:extended;
    a:array[0..maxn]of newtype;
    b:array[0..4*maxn+10]of rec;
    edge:array[0..4*maxn+10]of longint;
    g:array[0..maxm]of gtype;
    dis:array[0..4*maxn+10]of extended;
    mark:array[0..4*maxn+10]of boolean;
    q:array[0..maxq]of longint;
procedure addedge(x,y:longint; z:extended);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function dist(u,v:longint):extended;
begin
dist:=sqrt(extended(b[u].x-b[v].x)*extended(b[u].x-b[v].x)+extended(b[u].y-b[v].y)*extended(b[u].y-b[v].y));
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function check(view,up,down,chk:rec):boolean;
var x1,y1,x2,y2:longint;
    ret1,ret2:int64;
begin
if (up.x=-inf)and(up.y=-inf) then exit(true);
if (down.x=-inf)and(down.y=-inf) then exit(true);
x1:=up.x-view.x; y1:=up.y-view.y;
x2:=chk.x-view.x; y2:=chk.y-view.y;
ret1:=int64(x1)*int64(y2)-int64(x2)*int64(y1);
if ret1<0 then ret1:=-1; if ret1>0 then ret1:=1;
if ret1=1 then exit(false);
x1:=down.x-view.x; y1:=down.y-view.y;
ret2:=int64(x1)*int64(y2)-int64(x2)*int64(y1);
if ret2<0 then ret2:=-1; if ret2>0 then ret2:=1;
if ret2=-1 then exit(false);
check:=true;
end;
function cross(x1,y1,x2,y2,x3,y3:longint):longint;   //1->2 1->3
var xx1,yy1,xx2,yy2:longint; ret:int64;
begin
xx1:=x2-x1; yy1:=y2-y1;
xx2:=x3-x1; yy2:=y3-y1;
ret:=int64(xx1)*int64(yy2)-int64(xx2)*int64(yy1);
if ret<0 then exit(-1); if ret>0 then exit(1);
cross:=0;
end;
procedure work(sta:rec; ll,rr,now:longint);
var i:longint; up,down:rec;
begin
up.x:=-inf; up.y:=-inf; down.x:=-inf; down.y:=-inf;
for i:=ll to rr do
    begin
    if check(sta,up,down,b[(i-1)*4+1]) then addedge(now,(i-1)*4+1,dist(now,(i-1)*4+1));
    if check(sta,up,down,b[(i-1)*4+2]) then addedge(now,(i-1)*4+2,dist(now,(i-1)*4+2));
    if check(sta,up,down,b[(i-1)*4+3]) then addedge(now,(i-1)*4+3,dist(now,(i-1)*4+3));
    if check(sta,up,down,b[(i-1)*4+4]) then addedge(now,(i-1)*4+4,dist(now,(i-1)*4+4));
    if i=rr then break;
    if ((up.x=-inf)and(up.y=-inf))or(cross(sta.x,sta.y,up.x,up.y,a[i].x2,min(a[i].y2,a[i+1].y2))<=0) then begin up.x:=a[i].x2; up.y:=min(a[i].y2,a[i+1].y2); end;
    if ((down.x=-inf)and(down.y=-inf))or(cross(sta.x,sta.y,a[i].x2,max(a[i].y1,a[i+1].y1),down.x,down.y)<=0) then begin down.x:=a[i].x2; down.y:=max(a[i].y1,a[i+1].y1); end;
    if cross(sta.x,sta.y,up.x,up.y,down.x,down.y)>0 then exit;
    end;
if check(sta,up,down,b[4*n+2]) then addedge(now,4*n+2,dist(now,4*n+2));
end;
procedure spfa;
var p:longint;
begin
head:=1; tail:=1;
fillchar(mark,sizeof(mark),false); mark[4*n+1]:=true; q[1]:=4*n+1;
for i:=1 to 4*n+2 do dis[i]:=inf; dis[4*n+1]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (dis[q[head]]+g[p].w<dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].w;
       if not mark[g[p].v] then
          begin
          inc(tail);
          q[tail]:=g[p].v;
          end;
       end;
    p:=g[p].nxt;
    end;
  mark[q[head]]:=false;
  inc(head);
  end;
ans:=dis[4*n+2]/v;
writeln(round(ans*100000000)/100000000:0:8);
end;
begin
assign(input,'car.in');
reset(input);
assign(output,'car.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(a[i].x1,a[i].y1,a[i].x2,a[i].y2);
    b[(i-1)*4+1].x:=a[i].x1; b[(i-1)*4+1].y:=a[i].y1;
    b[(i-1)*4+2].x:=a[i].x1; b[(i-1)*4+2].y:=a[i].y2;
    b[(i-1)*4+3].x:=a[i].x2; b[(i-1)*4+3].y:=a[i].y1;
    b[(i-1)*4+4].x:=a[i].x2; b[(i-1)*4+4].y:=a[i].y2;
    end;
readln(sx,sy); readln(ex,ey); readln(v);
if sx>ex then begin tmp:=sx; sx:=ex; ex:=tmp; tmp:=sy; sy:=ey; ey:=tmp; end;
b[n*4+1].x:=sx; b[n*4+1].y:=sy;
b[n*4+2].x:=ex; b[n*4+2].y:=ey;
for i:=1 to n do if (a[i].x1<=sx)and(sx<=a[i].x2) then begin st:=i; break; end;
for i:=1 to n do if (a[i].x1<=ex)and(ex<a[i].x2) then begin en:=i; break; end;
work(b[n*4+1],st,en,n*4+1);
for i:=st to en do for j:=1 to 4 do work(b[(i-1)*4+j],i,en,(i-1)*4+j);
spfa;
close(input);
close(output);
end.