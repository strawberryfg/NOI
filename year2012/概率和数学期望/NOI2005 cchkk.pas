const maxn=1020; maxm=10020; maxq=10000000; inf=maxlongint;
type rec=record v,nxt:longint; end;
var n,m,i,j,st1,st2,x,y,tot:longint;
    num,dis:array[0..maxn,0..maxn]of longint;
    f:array[0..maxn,0..maxn]of extended;
    edge,deg:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    g:array[0..maxm]of rec;
    q:array[0..maxq]of longint;
    ans:extended;
procedure addedge(x,y:longint);
begin
inc(deg[x]);
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure prepare;
var i,j,head,tail,p:longint;
begin
for i:=1 to n do
    for j:=1 to n do
        dis[i][j]:=inf;
for i:=1 to n do
    begin
    head:=1; tail:=1; q[1]:=i; fillchar(mark,sizeof(mark),false);
    for j:=1 to n do dis[i][j]:=inf; dis[i][i]:=0;
    mark[i]:=true;
    while head<=tail do
      begin
      p:=edge[q[head]];
      while p<>0 do
        begin
        if dis[i][q[head]]+1<dis[i][g[p].v] then
           begin
           dis[i][g[p].v]:=dis[i][q[head]]+1;
           if not mark[g[p].v] then
              begin
              inc(tail); q[tail]:=g[p].v; mark[g[p].v]:=true;
              end;
           end;
        p:=g[p].nxt;
        end;
      mark[q[head]]:=false;
      inc(head);
      end;
    end;
for i:=1 to n do
    for j:=1 to n do
        if i<>j then
           begin
           p:=edge[i]; num[i][j]:=inf;
           while p<>0 do
             begin
             if (num[i][j]=inf)or(dis[g[p].v][j]<dis[num[i][j]][j])or((dis[g[p].v][j]=dis[num[i][j]][j])and(g[p].v<num[i][j])) then num[i][j]:=g[p].v;
             p:=g[p].nxt;
             end;
           end;
end;
function work(x,y:longint):extended;
var p:longint;
begin
if f[x][y]<>-1 then exit(f[x][y]);
if (num[x][y]=y)or(num[num[x][y]][y]=y) then begin f[x][y]:=1.0; exit(f[x][y]); end;
p:=edge[y]; f[x][y]:=0.0;
while p<>0 do
  begin
  f[x][y]:=f[x][y]+work(num[num[x][y]][y],g[p].v)/(deg[y]+1);
  p:=g[p].nxt;
  end;
f[x][y]:=f[x][y]+work(num[num[x][y]][y],y)/(deg[y]+1)+1;
exit(f[x][y]);
end;
begin
assign(input,'cchkk.in');
reset(input);
assign(output,'cchkk.out');
rewrite(output);
readln(n,m);
readln(st1,st2);
for i:=1 to m do begin readln(x,y); addedge(x,y); addedge(y,x); end;
prepare;
for i:=1 to n do
    for j:=1 to n do
        begin
        f[i][j]:=-1.0;
        if i=j then f[i][j]:=0.0;
        end;
ans:=work(st1,st2);
writeln(round(ans*1000)/1000:0:3);
close(input);
close(output);
end.