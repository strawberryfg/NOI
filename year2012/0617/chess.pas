const maxn=120; maxq=10000000; inf=maxlongint;
type rec=record u,v,c,nxt,w,op:longint; end;
var n,m,k,a,b,i,s,t,j,x,y,ans,tot,nx,ny:longint;
    dx,dy:array[0..8]of longint;
    edge,dis,fa:array[0..maxn*maxn]of longint;
    map:array[0..maxn,0..maxn]of char;
    mark:array[0..maxn*maxn]of boolean;
    g:array[0..maxn*maxn*18]of rec;
    q:array[0..maxq]of longint;
procedure addedge(x,y,z,cost:longint); inline;
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].w:=cost; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].w:=-cost; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean; inline;
var i,head,tail,p:longint;
begin
head:=1; tail:=1; q[1]:=s;
fillchar(mark,sizeof(mark),false);
for i:=s to t do dis[i]:=inf; dis[s]:=0; mark[s]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[q[head]]+g[p].w<dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].w;
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
if dis[t]=inf then exit(false) else exit(true);
end;
procedure work; inline;
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
ans:=ans+mmin*dis[t];
end;
begin
assign(input,'chess.in');
reset(input);
assign(output,'chess.out');
rewrite(output);
readln(n,m,k,a,b);
dx[1]:=a; dx[2]:=a; dx[3]:=-a; dx[4]:=-a; dx[5]:=b; dx[6]:=b; dx[7]:=-b; dx[8]:=-b;
dy[1]:=b; dy[2]:=-b; dy[3]:=b; dy[4]:=-b; dy[5]:=a; dy[6]:=-a; dy[7]:=a; dy[8]:=-a;
for i:=1 to n do
    begin
    for j:=1 to m do read(map[i][j]);
    readln;
    end;
s:=0; t:=n*m+1;
for i:=1 to k do
    begin
    readln(x,y);
    addedge(s,(x-1)*m+y,1,0);
    end;
for i:=1 to k do
    begin
    readln(x,y);
    addedge((x-1)*m+y,t,1,0);
    end;
for i:=1 to n do
    for j:=1 to m do
        begin
        if map[i][j]='*' then continue;
        for k:=1 to 8 do
            begin
            nx:=i+dx[k]; ny:=j+dy[k];
            if (nx>=1)and(nx<=n)and(ny>=1)and(ny<=m)and(map[nx][ny]<>'*') then addedge((i-1)*m+j,(nx-1)*m+ny,inf,1);
            end;
        end;
ans:=0;
while spfa do work;
writeln(ans);
close(input);
close(output);
end.
