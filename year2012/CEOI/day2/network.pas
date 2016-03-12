const maxn=100011; maxm=500011; maxmo=8470439;
      mo:array[1..2]of qword=(7931771,8470439);
type rec=record v,nxt:longint; end;
     anstype=record u,v:longint; end;
var n,m,root,i,x,y,tot,tot2,top,tme,tme2,cnt,p,head,tail,all:longint;
    col,dfn,edge,edge2,stack,low,f,deg,sum,q,fa,low2,dfn2:array[0..maxn]of longint;
    ans:array[0..maxn]of anstype;
    instack:array[0..maxn]of boolean;
    hash:array[1..2,0..maxmo]of boolean;
    g,tg:array[0..maxm]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure addedge2(x,y:longint);
var tmp1,tmp2:qword;
begin
tmp1:=(qword(x)*qword(cnt) mod mo[1]+qword(y)) mod mo[1];
tmp2:=(qword(x)*qword(cnt) mod mo[2]+qword(y)) mod mo[2];
if (hash[1][tmp1])and(hash[2][tmp2]) then exit;
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
inc(deg[y]);
hash[1][tmp1]:=true; hash[2][tmp2]:=true;
end;
procedure cmin(var x:longint; y:longint);
begin
if y<x then x:=y;
end;
procedure tarjan(x:longint);
var p:longint;
begin
p:=edge[x]; inc(top); stack[top]:=x; instack[x]:=true;
inc(tme); low[x]:=tme; dfn[x]:=tme;
while p<>0 do
  begin
  if dfn[g[p].v]=0 then
     begin
     fa[g[p].v]:=x;
     tarjan(g[p].v);
     cmin(low[x],low[g[p].v]);
     end
  else if instack[g[p].v] then cmin(low[x],dfn[g[p].v]);
  p:=g[p].nxt;
  end;
if low[x]=dfn[x] then
   begin
   inc(cnt);
   while stack[top+1]<>x do
     begin
     stack[top+1]:=0;
     col[stack[top]]:=cnt;
     instack[stack[top]]:=false;
     inc(sum[cnt]);
     dec(top);
     end;
   end;
end;
procedure dfs2(x:longint);
var p:longint;
begin
p:=edge[x];
inc(tme2); dfn2[x]:=tme2;
while p<>0 do
  begin
  if dfn2[g[p].v]=0 then
     begin
     dfs2(g[p].v);
     cmin(low[x],low[g[p].v]);
     end
  else cmin(low[x],dfn[g[p].v]);
  p:=g[p].nxt;
  end;
if low[x]=dfn[x] then
   begin
   p:=fa[x];
   while p<>0 do
     begin
     if (low[p]<dfn[p])or(p=root) then begin inc(all); ans[all].u:=x; ans[all].v:=p; low[x]:=dfn[p]; break; end;
     p:=fa[p];
     end;
   end;
end;
procedure work;
var i:longint;
begin
tme2:=0; all:=0;
dfs2(root);
writeln(all);
for i:=1 to all do writeln(ans[i].u,' ',ans[i].v);
end;
begin
{assign(input,'network.in');
reset(input);
assign(output,'network.out');
rewrite(output);}
read(n,m,root);
for i:=1 to m do
    begin
    read(x,y);
    addedge(x,y);
    end;
cnt:=0;
tarjan(root);
for i:=1 to n do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      if col[i]<>col[g[p].v] then addedge2(col[g[p].v],col[i]);
      p:=g[p].nxt;
      end;
    end;
head:=1; tail:=0;
for i:=1 to cnt do if deg[i]=0 then begin inc(tail); q[tail]:=i; end;
for i:=1 to cnt do f[i]:=sum[i];
while head<=tail do
  begin
  p:=edge2[q[head]];
  while p<>0 do
    begin
    f[tg[p].v]:=f[tg[p].v]+f[q[head]];
    dec(deg[tg[p].v]);
    if deg[tg[p].v]=0 then begin inc(tail); q[tail]:=tg[p].v; end;
    p:=tg[p].nxt;
    end;
  inc(head);
  end;
for i:=1 to n-1 do write(f[col[i]],' ');
write(f[col[n]]);
writeln;
work;
{close(input);
close(output);}
end.