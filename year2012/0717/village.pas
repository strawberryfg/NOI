const maxn=41111; maxque=81111; inf=maxlongint;
type quetype=record ch:char; x,y:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,k,tot,t,t1,t2,xx,yy,addsize:longint;
    edge,fa,from,dep,size,h:array[0..maxn]of longint;
    fans,sum:array[0..maxn]of longint;
    ans,ret,tmp,addsum:longint;
    g:array[0..2*maxn]of rec;
    s,ts:string;
    code:integer;
    que:array[0..maxque]of quetype; 
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure cmin(var x:longint; y:longint);
begin
if y<x then x:=y;
end;
procedure swap(var x,y:longint);
begin
x:=x+y; y:=x-y; x:=x-y;
end;
procedure dfs(x,last,d:longint);
var p:longint;
begin
from[x]:=last;
dep[x]:=d; size[x]:=1; sum[x]:=dep[x];
p:=edge[x];
while p<>0 do
  begin
  if g[p].v<>last then dfs(g[p].v,x,d+1);
  p:=g[p].nxt;
  end;
end;
procedure dfs2(x:longint; res:longint);
var p:longint;
begin
cmin(ret,res);
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>from[x])and(h[g[p].v]=x) then
     dfs2(g[p].v,res+size[t1]-size[g[p].v]-size[g[p].v]);
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'village.in');
reset(input);
assign(output,'village.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(s);
    que[i].ch:=s[1];
    if s[1]='Q' then continue;
    t:=pos(' ',s);
    delete(s,1,t);
    t:=pos(' ',s);
    ts:=copy(s,1,t-1);
    val(ts,que[i].x,code);
    delete(s,1,t);
    while s[length(s)]=' ' do delete(s,length(s),1);
    val(s,que[i].y,code);
    addedge(que[i].x,que[i].y);
    addedge(que[i].y,que[i].x);
    end;
dfs(1,0,0);
ans:=0;
for i:=1 to n do fa[i]:=i;
for i:=1 to m do
    begin
    if que[i].ch='Q' then writeln(ans)
       else begin
            xx:=que[i].x; yy:=que[i].y;
            if dep[xx]>dep[yy] then swap(xx,yy);
            t1:=getfa(xx);
            t:=yy; addsum:=sum[yy]; addsize:=size[yy];
            while t<>t1 do
              begin
              size[from[t]]:=size[from[t]]+addsize;
              sum[from[t]]:=sum[from[t]]+addsum;
              t:=from[t];
              end;
            t2:=getfa(yy);
            tmp:=sum[t1]-size[t1]*dep[t1];
            ret:=inf;
            fa[t2]:=t1;
            h[yy]:=xx;
            dfs2(t1,tmp);
            ans:=ans+ret-fans[t1]-fans[t2];
            fans[t1]:=ret; fans[t2]:=0;
            end;
    end;
close(input);
close(output);
end.