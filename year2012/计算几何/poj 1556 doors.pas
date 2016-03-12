const maxn=211; maxq=1111111; eps=1e-16; inf=1e30;
type vertype=record x,y:extended; end;
     segtype=record x1,y1,x2,y2:extended; end;
     rec=record v,nxt:longint; w:extended; end;
var n,ver,cnt,tot,i,j,k,pd,head,tail:longint;
    a:array[0..maxn]of vertype;
    seg:array[0..maxn]of segtype;
    edge:array[0..maxn]of longint;
    dis:array[0..maxn]of extended;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    g:array[0..maxn*maxn]of rec;
    xx:extended;
procedure init;
begin
tot:=0;
fillchar(edge,sizeof(edge),0);
end;
procedure addedge(x,y:longint;z:extended);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
if xx<-eps then exit(-1);
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
exit(x1*y2-x2*y1);
end;
function dot(x1,y1,x2,y2:extended):extended;
begin
exit(x1*x2+y1*y2);
end;
function calc(x1,y1,x2,y2:extended):extended;
begin
exit(sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)));
end;
function online(xx,yy,lx,ly,rx,ry:extended):boolean;
begin
if (cmp(cross(lx-xx,ly-yy,rx-xx,ry-yy))=0)and(cmp(dot(lx-xx,ly-yy,rx-xx,ry-yy))<=0) then exit(true);
exit(false);
end;
function intersect(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
var ret:longint;
begin
if online(x4,y4,x1,y1,x2,y2) then exit(false);
if online(x3,y3,x1,y1,x2,y2) then exit(false);
if online(x1,y1,x3,y3,x4,y4) then exit(false);
if online(x2,y2,x3,y3,x4,y4) then exit(false);
ret:=cmp(cross(x2-x1,y2-y1,x4-x1,y4-y1))*cmp(cross(x2-x1,y2-y1,x3-x1,y3-y1));
if ret>0 then exit(false);
ret:=cmp(cross(x4-x3,y4-y3,x1-x3,y1-y3))*cmp(cross(x4-x3,y4-y3,x2-x3,y2-y3));
if ret>0 then exit(false);
exit(true);
end;
procedure spfa(s,t:longint);
var i,p:longint;
begin
for i:=1 to ver do dis[i]:=inf; dis[s]:=0.0;
fillchar(mark,sizeof(mark),false);
head:=1; tail:=1; q[1]:=s; mark[s]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if cmp(dis[g[p].v]-(dis[q[head]]+g[p].w))>0 then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].w;
       if not mark[g[p].v] then
          begin
          inc(tail); q[tail]:=g[p].v;
          mark[g[p].v]:=true;
          end;
       end;
    p:=g[p].nxt;
    end;
  mark[q[head]]:=false;
  inc(head);
  end;
writeln(round(dis[t]*100)/100:0:2);
end;
begin
{assign(input,'doors.in');
reset(input);
assign(output,'doors.out');
rewrite(output);}
read(n);
while n<>-1 do
  begin
  if n=0 then begin writeln('10.00'); read(n); continue; end;
  init;
  ver:=1; cnt:=0;
  a[1].x:=0; a[1].y:=5;
  for i:=1 to n do
      begin
      read(xx);
      inc(ver); a[ver].x:=xx; a[ver].y:=0;
      for j:=1 to 4 do begin inc(ver); a[ver].x:=xx; read(a[ver].y); end;
      inc(cnt); seg[cnt].x1:=xx; seg[cnt].y1:=0; seg[cnt].x2:=xx; seg[cnt].y2:=a[ver-3].y;
      inc(cnt); seg[cnt].x1:=xx; seg[cnt].y1:=a[ver-2].y; seg[cnt].x2:=xx; seg[cnt].y2:=a[ver-1].y;
      inc(cnt); seg[cnt].x1:=xx; seg[cnt].y1:=a[ver].y; seg[cnt].x2:=xx; seg[cnt].y2:=10;
      end;
  inc(ver); a[ver].x:=10; a[ver].y:=5;
  for i:=1 to ver-1 do
      for j:=i+1 to ver do
          if cmp(a[j].x-a[i].x)>0 then
             begin
             pd:=1;
             for k:=1 to cnt do
                 if intersect(a[i].x,a[i].y,a[j].x,a[j].y,seg[k].x1,seg[k].y1,seg[k].x2,seg[k].y2) then
                    begin
                    pd:=0;
                    break;
                    end;
             if pd=1 then addedge(i,j,calc(a[i].x,a[i].y,a[j].x,a[j].y));
             end;
  spfa(1,ver);
  read(n);
  end;
{close(input);
close(output);}
end.