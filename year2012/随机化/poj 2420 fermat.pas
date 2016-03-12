const maxn=1111; inf=1e30; maxnum=30; maxtime=30; eps=1e-16; eps2=0.1; rate=0.8;
type rec1=record x,y:longint; end;
     rec2=record x,y,res:extended; end;
var n,i,j,minx,miny,maxx,maxy:longint;
    t,ans,mindis,numx,numy,lx,ly,rx,ry,tx,ty,now:extended;
    a:array[0..maxn]of rec1;
    b:array[0..maxn]of rec2;
function cmp(num:extended):longint;
begin
if abs(num)<eps then exit(0);
if num>eps then exit(1);
exit(-1);
end;
procedure cmin(var x:longint; y:longint);
begin
if y<x then x:=y;
end;
procedure cmax(var x:longint; y:longint);
begin
if y>x then x:=y;
end;
function dist(x1,y1,x2,y2:extended):extended;
begin
exit(sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)));
end;
function calc(x1,y1:extended):extended;
var i:longint; ret:extended;
begin
ret:=0.0;
for i:=1 to n do ret:=ret+dist(x1,y1,a[i].x,a[i].y);
exit(ret);
end;
begin
{assign(input,'fermat.in');
reset(input);
assign(output,'fermat.out');
rewrite(output);}
read(n);
randomize;
maxx:=-maxlongint; maxy:=-maxlongint; minx:=maxlongint; miny:=maxlongint;
for i:=1 to n do
    begin
    read(a[i].x,a[i].y);
    cmin(minx,a[i].x); cmin(miny,a[i].y);
    cmax(maxx,a[i].x); cmax(maxy,a[i].y);
    end;
for i:=1 to maxnum do
    begin
    b[i].x:=random(maxx-minx+1)+minx;
    b[i].y:=random(maxy-miny+1)+miny;
    b[i].res:=calc(b[i].x,b[i].y);
    end;
if maxx-minx>maxy-miny then t:=maxx-minx else t:=maxy-miny;
t:=t*2;
ans:=inf;
while t>eps2 do
  begin
  for i:=1 to maxnum do
      begin
      mindis:=inf; numx:=0.0; numy:=0.0;
      for j:=1 to maxtime do
          begin
          lx:=b[i].x-t; ly:=b[i].y-t; rx:=b[i].x+t; ry:=b[i].y+t;
          tx:=(rx-lx)*(random(1000)+1)/1000+lx; ty:=(ry-ly)*(random(1000)+1)/1000+ly;
          now:=calc(tx,ty);
          if cmp(now-mindis)<0 then
             begin
             mindis:=now;
             numx:=tx; numy:=ty;
             end;
          end;
      if cmp(mindis-b[i].res)<0 then begin b[i].res:=mindis; b[i].x:=numx; b[i].y:=numy; end;
      if cmp(b[i].res-ans)<0 then ans:=b[i].res;
      end;
  t:=t*rate;
  end;
writeln(ans:0:0);
{close(input);
close(output);}
end.