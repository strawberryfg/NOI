//20:12;
const maxn=100200; maxm=400020; inf=maxlongint;
type heaptype=record id,v:longint; end;
     rec=record u,v,w,nxt,op:longint; end;
var n,m,k,opt,i,j,t1,t2,tot,top,x,y,z,num,a,b,p,anc,ans:longint;
    edge,dis,bel,fa,dep:array[0..maxn]of longint;
    heap:array[0..maxn]of heaptype;
    g,tg:array[0..maxm]of rec;
    mark,ind:array[0..maxm]of longint;
    inheap:array[0..maxn]of boolean;
    f,mind:array[0..maxn,0..18]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].w:=z; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
procedure up(x:longint);
var swap:longint;
    tmp:heaptype;
begin
while (x div 2>=1)and(heap[x].v<heap[x div 2].v) do
  begin
  swap:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x div 2].id]; bel[heap[x div 2].id]:=swap;
  tmp:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=tmp;
  x:=x div 2;
  end;
end;
procedure down(x:longint);
var swap:longint;
    tmp:heaptype;
begin
while (x*2<=top) do
  begin
  if x*2+1>top then
     begin
     if heap[x].v>heap[x*2].v then
        begin
        swap:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2].id]; bel[heap[x*2].id]:=swap;
        tmp:=heap[x]; heap[x]:=heap[x*2]; heap[x*2]:=tmp;
        end;
     break;
     end
  else if heap[x*2].v>heap[x*2+1].v then
          begin
          if heap[x].v>heap[x*2+1].v then
             begin
             swap:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2+1].id]; bel[heap[x*2+1].id]:=swap;
             tmp:=heap[x]; heap[x]:=heap[x*2+1]; heap[x*2+1]:=tmp;
             x:=x*2+1;
             end
          else
             break;
          end
      else begin
           if heap[x].v>heap[x*2].v then
              begin
              swap:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2].id]; bel[heap[x*2].id]:=swap;
              tmp:=heap[x]; heap[x]:=heap[x*2]; heap[x*2]:=tmp;
              x:=x*2;
              end
           else
              break;
           end;

  end;
end;
procedure insert(x,v:longint);
begin
inc(top); heap[top].id:=x; heap[top].v:=v; bel[x]:=top;
inheap[x]:=true;
up(top);
end;
procedure pop;
begin
if top>0 then
   begin
   num:=heap[1].id;
   inheap[heap[1].id]:=false;
   bel[heap[1].id]:=0;
   heap[1]:=heap[top]; bel[heap[1].id]:=1;
   heap[top].id:=0; heap[top].v:=0;
   dec(top);
   down(1);
   end;
end;
procedure sort(l,r: longint);
var i,j,cmp,swap: longint; tmp:rec;
begin
i:=l; j:=r; cmp:=g[random(r-l+1)+l].w;
repeat
while (g[i].w>cmp) do inc(i);
while (cmp>g[j].w) do dec(j);
if not(i>j) then begin tmp:=g[i]; g[i]:=g[j]; g[j]:=tmp; swap:=ind[i]; ind[i]:=ind[j]; ind[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure dfs(x,fa,d:longint);
var p,i:longint;
begin
dep[x]:=d;
p:=edge[x];
f[x][0]:=g[fa].u; mind[x][0]:=g[fa].w;
for i:=1 to 18 do
    begin
    f[x][i]:=f[f[x][i-1]][i-1];
    mind[x][i]:=min(mind[x][i-1],mind[f[x][i-1]][i-1]);
    end;
while p<>0 do
  begin
  if (mark[p]=1)and(g[p].v<>g[fa].u) then
     dfs(g[p].v,p,d+1);
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
exit(f[x][0]);
end;
function getans(x,step:longint):longint;
var now,ret:longint;
begin
if step=0 then exit(inf);
now:=-1;
ret:=inf;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then
     begin
     ret:=min(ret,mind[x][now]);
     x:=f[x][now];
     end;
  step:=step div 2;
  end;
getans:=ret;
end;
begin
assign(input,'e.in');
reset(input);
assign(output,'e.out');
rewrite(output);
readln(n,m,k,opt);
randomize;
for i:=1 to m do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    end;
for i:=1 to n do dis[i]:=inf;
for i:=1 to n do inheap[i]:=false;
top:=0;
for i:=1 to k do
    begin
    read(x); dis[x]:=0;
    insert(x,0);
    end;
while true do
  begin
  num:=-1;
  pop;
  if num=-1 then break;
  p:=edge[num];
  while p<>0 do
    begin
    if dis[num]+g[p].w<dis[g[p].v] then
       begin
       dis[g[p].v]:=dis[num]+g[p].w;
       if inheap[g[p].v] then
          begin
          heap[bel[g[p].v]].v:=dis[g[p].v];
          up(bel[g[p].v]);
          end
       else
          insert(g[p].v,dis[g[p].v]);
       end;
    p:=g[p].nxt;
    end;
  end;
for i:=1 to tot do g[i].w:=min(dis[g[i].u],dis[g[i].v]);
tg:=g;
for i:=1 to tot do ind[i]:=i;
sort(1,tot);
for i:=1 to n do fa[i]:=i;
i:=1; j:=0;
while (i<=tot)and(j<n-1) do
  begin
  t1:=getfa(g[i].u); t2:=getfa(g[i].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     mark[ind[i]]:=1;
     mark[tg[ind[i]].op]:=1;
     inc(j);
     end;
  inc(i);
  end;
g:=tg;
dfs(1,0,0);
for i:=1 to opt do
    begin
    readln(x,y);
    anc:=lca(x,y);
    a:=getans(x,dep[x]-dep[anc]);
    b:=getans(y,dep[y]-dep[anc]);
    writeln(min(a,b));
    end;
close(input);
close(output);
end.