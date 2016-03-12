const maxn=211; maxq=10000000; inf=maxlongint; inf2=5555555555555555555;
type rec=record u,v,nxt,c,w,op:longint; end;
var n,m,p,i,j,k,tot,s,t,ds,ws:longint;
    a,b:array[0..maxn]of longint;
    map:array[0..maxn,0..maxn]of longint;
    edge,fa:array[0..maxn*4]of longint;
    mark:array[0..maxn*4]of boolean;
    dis:array[0..maxn*4]of int64;
    g:array[0..maxn*maxn*16]of rec;
    q:array[0..maxq]of longint;
    ans:int64;
procedure addedge(x,y,z,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].w:=cost; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].w:=-cost; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=s to t do dis[i]:=inf2;
head:=1; tail:=1; fillchar(mark,sizeof(mark),false); mark[s]:=true; q[1]:=s; dis[s]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[q[head]]+int64(g[p].w)<dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[q[head]]+int64(g[p].w);
       fa[g[p].v]:=p;
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
if dis[t]=inf2 then exit(false) else exit(true);
end;
procedure work;
var p,mmin:longint;
begin
p:=fa[t]; mmin:=inf;
while p<>0 do
  begin
  if g[p].c<mmin then mmin:=g[p].c;
  p:=fa[g[p].u];
  end;
p:=fa[t];
while p<>0 do
  begin
  g[p].c:=g[p].c-mmin;
  g[g[p].op].c:=g[g[p].op].c+mmin;
  p:=fa[g[p].u];
  end;
ans:=ans+dis[t]*int64(mmin);
end;
begin
assign(input,'purchase.in');
reset(input);
assign(output,'purchase.out');
rewrite(output);
readln(n,m,p);
a[1]:=0;
for i:=2 to m+1 do read(a[i]);
a[m+2]:=0;
for i:=1 to p do read(b[i]);
for i:=0 to n-1 do
    for j:=0 to n-1 do
        begin
        read(map[i][j]);
        if (i<>j)and(map[i][j]=0) then map[i][j]:=inf;
        end;
for k:=0 to n-1 do
    for i:=0 to n-1 do
        for j:=0 to n-1 do
            if (i<>j)and(j<>k)and(i<>k)and(map[i][k]<>inf)and(map[k][j]<>inf)and(map[i][k]+map[k][j]<map[i][j]) then
               map[i][j]:=map[i][k]+map[k][j];
readln(ds,ws);
s:=0; t:=m+1+p+1+1;
for i:=1 to m+1 do addedge(s,i,1,0);
for i:=1 to m+1 do
    begin
    if map[a[i]][a[i+1]]<>inf then addedge(i,m+1+p+1,1,map[a[i]][a[i+1]]*ws);
    for j:=1 to p do
        begin
        if (map[a[i]][b[j]]<>inf)and(map[b[j]][a[i+1]]<>inf) then
           addedge(i,m+1+j,1,map[a[i]][b[j]]*ws+map[b[j]][a[i+1]]*ds);
        end;
    end;
addedge(m+1+p+1,t,inf,0);
for i:=1 to p do addedge(m+1+i,t,1,0);
ans:=0;
while spfa do work;
writeln(ans);
close(input);
close(output);
end.
