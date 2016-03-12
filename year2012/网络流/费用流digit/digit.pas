const maxn=400; inf=1000000000;
type rec=record u,v,c,key,op,nxt:longint; end;
var n,m,s,t,i,j,cnt,ans,ans1,ans2,ans3,tot:longint;
    a,v:array[0..maxn,0..maxn]of longint;
    g:array[0..maxn*maxn]of rec;
    edge:array[0..maxn*maxn]of longint;
    mark:array[0..maxn*maxn]of boolean;
    fa,dis,q:array[0..maxn*maxn]of longint;
procedure init;
begin
tot:=0;
for i:=0 to maxn*maxn do edge[i]:=0;
end;
procedure addedge(x,y,flow,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=flow; g[tot].key:=cost; g[tot].nxt:=edge[x];
edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].key:=-cost; g[tot].nxt:=edge[y];
edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,x,p,min:longint;
    found:boolean;
begin
for i:=s to t do dis[i]:=inf;
dis[s]:=0;
head:=1; tail:=1;
q[1]:=s;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
found:=false;
while head<=tail do
  begin
  x:=q[head];
  p:=edge[x];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[x]<>inf)and(dis[x]+g[p].key<dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[x]+g[p].key;
       fa[g[p].v]:=p;
       if g[p].v=t then found:=true;
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
if not found then exit(false)
   else begin
        p:=fa[t];
        min:=inf;
        while p<>0 do
          begin
          if g[p].c<min then min:=g[p].c;
          p:=fa[g[p].u];
          end;
        p:=fa[t];
        ans:=ans+min*abs(dis[t]);
        while p<>0 do
          begin
          dec(g[p].c,min);
          inc(g[g[p].op].c,min);
          p:=fa[g[p].u];
          end;
        exit(true);
        end;
end;
procedure solve1;
var i,j:longint;
begin
s:=0; t:=(2*m+n-1)*n+1;
for i:=1 to m do addedge(s,i,1,0);
for i:=1 to m+n-1 do
    addedge(v[n][i]+cnt,t,1,0);
for i:=1 to n-1 do
    for j:=1 to i+m-1 do
        begin
        addedge(v[i][j]+cnt,v[i+1][j],1,0);
        addedge(v[i][j]+cnt,v[i+1][j+1],1,0);
        end;
for i:=1 to n do
    for j:=1 to i+m-1 do
        addedge(v[i][j],v[i][j]+cnt,1,-a[i][j]);
ans:=0;
while spfa do
   ans:=ans;
ans1:=ans;
end;
procedure solve2;
var i,j:longint;
begin
for i:=1 to m do
    addedge(s,i,1,0);
for i:=1 to m+n-1 do
    addedge(v[n][i],t,inf,-a[n][i]);
for i:=1 to n-1 do
    for j:=1 to i+m-1 do
        begin
        addedge(v[i][j],v[i+1][j],1,-a[i][j]);
        addedge(v[i][j],v[i+1][j+1],1,-a[i][j]);
        end;
ans:=0;
while spfa do
   ans:=ans;
ans2:=ans;
end;
procedure solve3;
var i,j:longint;
begin
for i:=1 to m do
    addedge(s,i,1,0);
for i:=1 to m+n-1 do
    addedge(v[n][i],t,inf,-a[n][i]);
for i:=1 to n-1 do
    for j:=1 to i+m-1 do
        begin
        addedge(v[i][j],v[i+1][j],inf,-a[i][j]);
        addedge(v[i][j],v[i+1][j+1],inf,-a[i][j]);
        end;
ans:=0;
while spfa do
   ans:=ans;
ans3:=ans;
end;
begin
assign(input,'digit.in');
reset(input);
assign(output,'digit.out');
rewrite(output);
readln(m,n);
s:=0;
t:=(2*m+n-1)*n div 2+1;
cnt:=0;
for i:=1 to n do
    begin
    for j:=1 to i+m-1 do
        begin
        read(a[i][j]);
        inc(cnt);
        v[i][j]:=cnt;
        end;
    readln;
    end;
close(input);
init;
solve1;
init;
solve2;
init;
solve3;
writeln(ans1);
writeln(ans2);
writeln(ans3);
close(output);
end.