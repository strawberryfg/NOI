const maxn=820; inf=maxlongint; maxq=1000020; maxm=3000020;
type rec=record x,y:longint; end;
     typ=record x1,y1,x2,y2:longint; end;
     gtype=record v,nxt:longint; w:extended; end;
var n,i,sx,sy,ex,ey,tmp,head,tail,tot,total,st,en,p:longint;
    v,ans:extended;
    a:array[0..maxn]of typ;
    q:array[0..maxq]of longint;
    g:array[0..maxm]of gtype;
    edge,flag1,flag2:array[0..maxn*4]of longint;
    mark:array[0..maxn*4]of boolean;
    dis:array[0..maxn*4]of extended;
    c:array[0..maxn*4]of rec;
    hash:array[0..maxn*4,0..maxn*4]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure insert(xx,yy,ww,zz:longint);
begin
inc(tot); c[tot].x:=xx; c[tot].y:=yy; flag1[tot]:=ww; flag2[tot]:=zz;
end;
procedure addedge(x,y:longint;z:extended);
begin
if hash[x][y]=1 then exit;
hash[x][y]:=1;
//writeln(total+1,' : ',c[x].x,' ',c[x].y,' ',c[y].x,' ',c[y].y);
inc(total); g[total].v:=y; g[total].w:=z; g[total].nxt:=edge[x]; edge[x]:=total;
end;
function dist(u,v:longint):extended;
begin
dist:=sqrt(extended(c[u].x-c[v].x)*extended(c[u].x-c[v].x)+extended(c[u].y-c[v].y)*extended(c[u].y-c[v].y));
end;
procedure work;
var i,j,k,pd,xx1,yy1,xx2,yy2,miny,maxy:longint;
    ret1,ret2:int64;
begin
for i:=1 to n do begin insert(a[i].x1,a[i].y1,i,i); insert(a[i].x1,a[i].y2,i,i); insert(a[i].x2,a[i].y1,i+1,i); insert(a[i].x2,a[i].y2,i+1,i); end;
insert(sx,sy,0,0); st:=tot; insert(ex,ey,0,0); en:=tot;
for i:=1 to n do if (a[i].x1<=sx)and(sx<a[i].x2) then begin flag1[tot-1]:=i; break; end;
for i:=1 to n do if (a[i].x1<=sx)and(sx<a[i].x2) then begin flag2[tot-1]:=i; break; end;
for i:=1 to n do if (a[i].x1<=ex)and(ex<a[i].x2) then begin flag1[tot]:=i; break; end;
for i:=1 to n do if (a[i].x1<=ex)and(ex<a[i].x2) then begin flag2[tot]:=i; break; end;
for i:=1 to tot do
    begin
    for j:=1 to tot do
        begin
        if (i=j) then continue;
        if c[i].x>c[j].x then continue;
        if (c[i].x=c[j].x)and(c[i].y=c[j].y) then continue;
        if c[i].x=c[j].x then begin addedge(i,j,dist(i,j)); addedge(j,i,dist(i,j)); continue; end;
        pd:=1;
        for k:=flag1[i] to flag2[j] do
            begin
            miny:=max(a[k].y1,a[k-1].y1); maxy:=min(a[k].y2,a[k-1].y2);
            xx1:=a[k].x1-c[i].x; yy1:=maxy-c[i].y;
            xx2:=c[j].x-c[i].x;  yy2:=c[j].y-c[i].y;
            ret1:=int64(xx1)*int64(yy2)-int64(xx2)*int64(yy1);
                                 yy1:=miny-c[i].y;
            ret2:=int64(xx1)*int64(yy2)-int64(xx2)*int64(yy1);
            if ret1<0 then ret1:=-1 else if ret1>0 then ret1:=1;
            if ret2<0 then ret2:=-1 else if ret2>0 then ret2:=1;
            if ((ret1>0)and(ret2>0))or((ret1<0)and(ret2<0)) then begin pd:=0; break; end;
            end;
        if pd=1 then addedge(i,j,dist(i,j));
        end;
    end;
for i:=1 to tot do dis[i]:=inf;
dis[st]:=0; head:=1; tail:=1; q[1]:=st;
fillchar(mark,sizeof(mark),false); mark[st]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if dis[q[head]]+g[p].w<dis[g[p].v] then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].w;
       if not mark[g[p].v] then
          begin
          mark[g[p].v]:=true;
          inc(tail);
          q[tail]:=g[p].v;
          end;
       end;
    p:=g[p].nxt;
    end;
  mark[q[head]]:=false;
  inc(head);
  end;
ans:=dis[en]/extended(v);
writeln(round(ans*100000000)/100000000:0:8);
end;
begin
assign(input,'car.in');
reset(input);
assign(output,'car.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i].x1,a[i].y1,a[i].x2,a[i].y2);
readln(sx,sy); readln(ex,ey);
if sx>ex then begin tmp:=sx; sx:=ex; ex:=tmp; tmp:=sy; sy:=ey; ey:=tmp; end;
readln(v);
work;
close(input);
close(output);
end.