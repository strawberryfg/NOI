const inf=100000000; maxn=1020; maxq=1000020;
type rec=record u,v,c,key,op,nxt:longint; end;
var a,b,m,n,i,j,v,s,t,k,x,y,ans,tot:longint;
    edge,dis,fa:array[0..maxn*maxn]of longint;
    g:array[0..maxn*maxn]of rec;
    mark:array[0..maxn*maxn]of boolean;
    q:array[0..maxq]of longint;
procedure addedge(x,y,flow,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=flow; g[tot].key:=cost;
g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].key:=-cost;
g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=s to t do dis[i]:=-inf;
for i:=s to t do fa[i]:=0;
dis[s]:=0;
fillchar(mark,sizeof(mark),false);
head:=1; tail:=1; q[1]:=s;
mark[s]:=true;
while head<=tail do
  begin
  x:=q[head];
  p:=edge[x];
  while p<>0 do
    begin
    if (dis[x]<>-inf)and(g[p].c>0)and(dis[x]+g[p].key>dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[x]+g[p].key;
       fa[g[p].v]:=p;
       if not mark[g[p].v] then
          begin
          mark[g[p].v]:=true;
          inc(tail);
          q[tail]:=g[p].v;
          end;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  mark[x]:=false;
  end;
if dis[t]=-inf then exit(false) else exit(true);
end;
procedure doit;
var p,min:longint;
begin
ans:=0;
while spfa do
  begin
  min:=inf;
  p:=fa[t];
  while p>0 do
    begin
    if g[p].c<min then min:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t];
  while p>0 do
    begin
//    writeln(g[p].u,' ',g[p].v);
    dec(g[p].c,min);
    inc(g[g[p].op].c,min);
    p:=fa[g[p].u];
    end;
  ans:=ans+min*dis[t];
//  writeln('flow ',dis[t]*min);
  end;
end;
begin
assign(input,'robo.in');
reset(input);
assign(output,'robo.out');
rewrite(output);
readln(a,b);
readln(m,n);
for i:=1 to m+1 do
    begin
    for j:=1 to n do
        begin
        read(v);
        addedge((i-1)*(n+1)+j,(i-1)*(n+1)+j+1,1,v);
        addedge((i-1)*(n+1)+j,(i-1)*(n+1)+j+1,inf,0);
        end;
    readln;
    end;
for i:=1 to n+1 do
    begin
    for j:=1 to m do
        begin
        read(v);
        addedge((j-1)*(n+1)+i,j*(n+1)+i,1,v);
        addedge((j-1)*(n+1)+i,j*(n+1)+i,inf,0);
        end;
    end;
s:=0;
t:=(n+1)*(m+1)+1;
for i:=1 to a do
    begin
    readln(k,x,y);
    addedge(s,x*(n+1)+y+1,k,0);
    end;
for i:=1 to b do
    begin
    readln(k,x,y);
    addedge(x*(n+1)+y+1,t,k,0);
    end;
doit;
writeln(ans);
close(input);
close(output);
end.
