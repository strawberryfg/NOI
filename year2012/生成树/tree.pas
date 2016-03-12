const maxn=100020; maxm=600020; inf=maxlongint;
type rec=record u,v,w,nxt:longint; end;
var n,m,i,j,tot,now,cnt,t1,t2,anc,minn,max,maxx:longint;
    ans:qword;
    g,h:array[0..maxm]of rec;
    flag:array[0..maxm]of longint;
    edge,dep,fa:array[0..maxn]of longint;
    f,fmax,gmax:array[0..maxn,0..18]of longint;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure sort(l,r:longint);
var i,j,cmp:longint; swap:rec;
begin
i:=l; j:=r; cmp:=h[(l+r) div 2].w;
repeat
while h[i].w<cmp do inc(i);
while cmp<h[j].w do dec(j);
if not(i>j) then begin swap:=h[i]; h[i]:=h[j]; h[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure dfs(x,last,sta:longint);
var p:longint;
begin
dep[x]:=dep[last]+1;
p:=edge[x];
f[x][0]:=last; if sta<>0 then fmax[x][0]:=g[sta].w; gmax[x][0]:=-1;
for i:=1 to 18 do
    begin
    f[x][i]:=f[f[x][i-1]][i-1];
    if fmax[x][i-1]>fmax[f[x][i-1]][i-1] then fmax[x][i]:=fmax[x][i-1] else fmax[x][i]:=fmax[f[x][i-1]][i-1];
    gmax[x][i]:=-1;
    if (fmax[x][i-1]<fmax[x][i])and(fmax[x][i-1]>gmax[x][i])  then gmax[x][i]:=fmax[x][i-1];
    if (gmax[x][i-1]<>-1)and(gmax[x][i-1]<fmax[x][i])and(gmax[x][i-1]>gmax[x][i]) then gmax[x][i]:=gmax[x][i-1];
    if (fmax[f[x][i-1]][i-1]<fmax[x][i])and(fmax[f[x][i-1]][i-1]>gmax[x][i]) then gmax[x][i]:=fmax[f[x][i-1]][i-1];
    if (gmax[f[x][i-1]][i-1]<>-1)and(gmax[f[x][i-1]][i-1]<fmax[x][i])and(gmax[f[x][i-1]][i-1]>gmax[x][i]) then gmax[x][i]:=gmax[f[x][i-1]][i-1];
    end;
while p<>0 do
  begin
  if (g[p].v<>last) then dfs(g[p].v,x,p);
  p:=g[p].nxt;
  end;
end;
function work(x,step:longint):longint;
var now:longint;
begin
now:=-1;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then x:=f[x][now];
  step:=step div 2;
  end;
work:=x;
end;
function lca(x,y:longint):longint;
var i:longint;
begin
if dep[x]<dep[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
x:=work(x,dep[x]-dep[y]);
if x=y then exit(x);
for i:=18 downto 0 do
    begin
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
    end;
lca:=f[x][0];
end;
procedure work1(x,anc:longint);
var step,now:longint;
begin
step:=dep[x]-dep[anc];
now:=-1;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then begin if fmax[x][now]>max then max:=fmax[x][now]; x:=f[x][now]; end;
  step:=step div 2;
  end;
end;
procedure work2(x,anc:longint);
var step,now:longint;
begin
step:=dep[x]-dep[anc];
now:=-1;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then
     begin
     if (fmax[x][now]<max)and(fmax[x][now]>maxx) then maxx:=fmax[x][now];
     if (gmax[x][now]<>-1)and(gmax[x][now]<max)and(gmax[x][now]>maxx) then maxx:=gmax[x][now];
     x:=f[x][now];
     end;
  step:=step div 2;
  end;
end;
begin
assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);
readln(n,m);
for i:=1 to m do begin read(h[i].u,h[i].v,h[i].w); end;
sort(1,m);
for i:=1 to n do fa[i]:=i;
now:=1; cnt:=0; ans:=0;
while (now<=m)and(cnt<n-1) do
  begin
  t1:=getfa(h[now].u); t2:=getfa(h[now].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     inc(cnt);
     flag[now]:=1;
     ans:=ans+qword(h[now].w);
     end;
  inc(now);
  end;
for i:=1 to m do if flag[i]=1 then begin addedge(h[i].u,h[i].v,h[i].w); addedge(h[i].v,h[i].u,h[i].w); end;
dep[0]:=-1;
for i:=1 to n do for j:=0 to 18 do fmax[i][j]:=-inf;
dfs(1,0,0);
minn:=inf;
for i:=1 to m do
    begin
    if flag[i]=1 then continue;  //in MST
    anc:=lca(h[i].u,h[i].v);
    max:=-inf;
    work1(h[i].u,anc);
    work1(h[i].v,anc);
    if h[i].w>max then begin if h[i].w-max<minn then minn:=h[i].w-max; continue; end;
    maxx:=-inf;
    work2(h[i].u,anc);
    work2(h[i].v,anc);
    if maxx=-inf then continue;
    if h[i].w>maxx then begin if h[i].w-maxx<minn then minn:=h[i].w-maxx; continue; end;
    end;
ans:=ans+qword(minn);
writeln(ans);
close(input);
close(output);
end.