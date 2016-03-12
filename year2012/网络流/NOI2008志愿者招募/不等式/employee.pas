const maxn=1020; maxm=40020; maxq=10000000; inf=maxlongint;
type rec=record u,v,nxt,c,w,op:longint; end;
var n,m,s,t,i,v,last,ll,rr,cost,tot:longint;
    edge,fa:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    dis:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    ans:longint;
procedure addedge(x,y,z,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].c:=z; g[tot].w:=cost; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].c:=0; g[tot].w:=-cost; g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=s to t do dis[i]:=inf;
dis[s]:=0;
fillchar(mark,sizeof(mark),false);
q[1]:=s; mark[s]:=true; head:=1; tail:=1;
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
if dis[t]=inf then spfa:=false else spfa:=true;
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
ans:=ans+dis[t]*mmin;
end;
begin
{assign(input,'employee.in');
reset(input);
assign(output,'employee.out');
rewrite(output);}
readln(n,m);
s:=0; t:=n+1+1; last:=0;
for i:=1 to n+1 do
    begin
    if i=n+1 then v:=0 else read(v);
    if v-last>0 then addedge(i,t,v-last,0) else if v-last<0 then addedge(s,i,last-v,0);
    last:=v;
    end;
for i:=1 to n do addedge(i,i+1,inf,0);
for i:=1 to m do begin readln(ll,rr,cost); addedge(rr+1,ll,inf,cost); end;
ans:=0;
while spfa do work;
writeln(ans);
{close(input);
close(output);}
end.