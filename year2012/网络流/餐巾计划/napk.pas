const maxn=10020; maxq=1000020; inf=maxlongint;
type rec=record u,v,c,key,op,nxt:longint; end;
var n,charge,fastday,fastcharge,slowday,slowcharge,s,t,i,ans,tot:longint;
    edge,fa,dis,a:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    g:array[0..2*maxn]of rec;
procedure addedge(x,y,flow,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=flow; g[tot].key:=cost;  g[tot].nxt:=edge[x]; g[tot].op:=tot+1; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0;    g[tot].key:=-cost; g[tot].nxt:=edge[y]; g[tot].op:=tot-1; edge[y]:=tot;
end;
function spfa:boolean;
var i,x,p,head,tail:longint;
begin
for i:=s to t do fa[i]:=-1;
for i:=s to t do dis[i]:=inf;
dis[s]:=0;
q[1]:=s;
head:=1; tail:=1;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
while head<=tail do
  begin
  x:=q[head];
  p:=edge[x];
  while p>0 do
    begin
    if (g[p].c>0)and(dis[x]+g[p].key<dis[g[p].v]) then
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
if dis[t]=inf then exit(false) else exit(true);
end;
procedure work;
var min,p:longint;
begin
while spfa do
  begin
  min:=inf;
  p:=fa[t];
  while p>0 do
    begin
    if (g[p].c>0)and(g[p].c<min) then min:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t];
  while p>0 do
    begin
    dec(g[p].c,min);
    inc(g[g[p].op].c,min);
//    writeln(g[p].u,' ',g[p].v);
    p:=fa[g[p].u];
    end;
  ans:=ans+dis[t]*min;
{  writeln('min:',min);
  writeln('cost:',dis[t]);}
  end;
end;
begin
assign(input,'napk.in');
reset(input);
assign(output,'napk.out');
rewrite(output);
readln(n,charge,fastday,fastcharge,slowday,slowcharge);
s:=0; t:=2*n+1;
for i:=1 to n do readln(a[i]);
for i:=1 to n do
    begin
    addedge(s,i+n,inf,charge);
    addedge(s,i,a[i],0);
    if i<n then
       addedge(i,i+1,inf,0);
    if i+fastday<=n then addedge(i,i+fastday+n,inf,fastcharge);
    if i+slowday<=n then addedge(i,i+slowday+n,inf,slowcharge);
    addedge(i+n,t,a[i],0);
    end;
work;
writeln(ans);
close(input);
close(output);
end.
