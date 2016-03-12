const maxn=200000; inf=maxlongint;
type rec=record u,v,nxt:longint; end;
     treetype=record del,sum:qword; end;
var n,i,x,y,flag,tot,total:longint;
    fa,bel,a,edge,cnt,col,top,h,maxnum,dep,son,fmax:array[0..maxn]of longint;
    g:array[0..maxn*2]of rec;
    tree,tree2:array[0..4*maxn]of treetype;
    f:array[0..maxn,0..18]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dfs1(x,d:longint);
var p:longint;
begin
bel[x]:=d; a[d]:=x;  //num node
p:=edge[x];
if p<>0 then dfs1(g[p].v,d+1);
end;
procedure lazy(x,l,r:longint);
var mid:longint;
begin
mid:=(l+r)div 2;
if tree[x].del<>0 then
   begin
   tree[x*2].del:=tree[x*2].del+tree[x].del;
   tree[x*2].sum:=tree[x*2].sum+tree[x].del*qword(mid-l+1);
   tree[x*2+1].del:=tree[x*2+1].del+tree[x].del;
   tree[x*2+1].sum:=tree[x*2+1].sum+tree[x].del*qword(r-mid);
   tree[x].del:=0;
   end
end;
procedure lazy2(x,l,r:longint);
var mid:longint;
begin
mid:=(l+r)div 2;
if tree2[x].del<>0 then
   begin
   tree2[x*2].del:=tree2[x*2].del+tree2[x].del;
   tree2[x*2].sum:=tree2[x*2].sum+tree2[x].del*qword(mid-l+1);
   tree2[x*2+1].del:=tree2[x*2+1].del+tree2[x].del;
   tree2[x*2+1].sum:=tree2[x*2+1].sum+tree2[x].del*qword(r-mid);
   tree2[x].del:=0;
   end
end;
procedure modify(f,t,l,r,del,x:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then begin tree[x].del:=tree[x].del+qword(del); tree[x].sum:=tree[x].sum+qword(del)*qword(r-l+1); exit; end;
mid:=(l+r)div 2;
lazy(x,l,r);
if f<=mid then modify(f,t,l,mid,del,x*2);
if t>mid then modify(f,t,mid+1,r,del,x*2+1);
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
end;
function query(f,t,l,r,x:longint):qword;
var mid:longint;
begin
if l<>r then lazy(x,l,r);
if (f<=l)and(r<=t) then exit(tree[x].sum);
mid:=(l+r)div 2;
query:=0;
if f<=mid then query:=query+query(f,t,l,mid,x*2);
if t>mid then query:=query+query(f,t,mid+1,r,x*2+1);
//tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
end;
procedure modify2(f,t,l,r,del,x:longint);
var mid:longint;
begin
if f>t then exit;
if (f<=l)and(r<=t) then begin tree2[x].del:=tree2[x].del+qword(del); tree2[x].sum:=tree2[x].sum+qword(del)*qword(r-l+1); exit; end;
mid:=(l+r)div 2;
lazy2(x,l,r);
if f<=mid then modify2(f,t,l,mid,del,x*2);
if t>mid then modify2(f,t,mid+1,r,del,x*2+1);
tree2[x].sum:=tree2[x*2].sum+tree2[x*2+1].sum;
end;
function query2(f,t,l,r,x:longint):qword;
var mid:longint;
begin
if l<>r then lazy2(x,l,r);
if (f<=l)and(r<=t) then exit(tree2[x].sum);
mid:=(l+r)div 2;
query2:=0;
if f<=mid then query2:=query2+query2(f,t,l,mid,x*2);
if t>mid then query2:=query2+query2(f,t,mid+1,r,x*2+1);
//tree2[x].sum:=tree2[x*2].sum+tree2[x*2+1].sum;
end;
procedure work1;
var i,opt,x,y,del:longint;
    ch,c:char;
    ans:qword;
begin
dfs1(1,1);
readln(opt);
for i:=1 to opt do
    begin
    read(ch); read(c);
    if ch='A' then
       begin
       read(x,y,del); inc(x); inc(y);
       if bel[x]>bel[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
       modify(bel[x],bel[y],1,n,del,1);
       end
    else
       begin
       read(x); inc(x);
       ans:=query(bel[x],n,1,n,1);
       writeln(ans);
       end;
    readln;
    end;
end;
procedure dfs(x,from,d:longint);
var max,p:longint;
begin
dep[x]:=d;
p:=edge[x];
son[x]:=1;
max:=0;
f[x][0]:=from;
for i:=1 to 18 do f[x][i]:=f[f[x][i-1]][i-1];
while p<>0 do
  begin
  if (g[p].v<>from) then
     begin
//     fa[g[p].v]:=x;
     dfs(g[p].v,x,d+1);
     son[x]:=son[x]+son[g[p].v];
     if son[g[p].v]>max then
        begin
        max:=son[g[p].v];
        maxnum[x]:=g[p].v;
        end;
     end;
  p:=g[p].nxt;
  end;
end;
procedure cuttree(x,from,root:longint);
var p,mmax:longint;
begin
inc(total); h[total]:=x;
col[x]:=total;                             //dfn[x];
top[x]:=root;
mmax:=-inf;
if maxnum[x]<>0 then
   begin
   cuttree(maxnum[x],x,root);
   if fmax[maxnum[x]]>mmax then mmax:=fmax[maxnum[x]];
   end;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>from)and(g[p].v<>maxnum[x]) then
     begin
     cuttree(g[p].v,x,g[p].v);
     if fmax[g[p].v]>mmax then mmax:=fmax[g[p].v];
     end;
  p:=g[p].nxt;
  end;
if mmax=-inf then fmax[x]:=col[x] else fmax[x]:=mmax;
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
procedure worktmp(xx,anc,del:longint);
begin
if xx=anc then exit;
while true do
  begin
  if xx=0 then break;
  if xx=anc then break;
  if col[xx]<col[anc] then break;
  if col[anc]<col[top[xx]] then
     begin
     modify2(col[top[xx]],col[xx],1,n,del,1);
     xx:=f[top[xx]][0];
     end
  else
     begin
     modify2(col[anc]+1,col[xx],1,n,del,1);
     break;
     end;
  end;
end;
procedure work2;
var i,opt,x,y,del,anc:longint;
    ch,c:char;
    ans:qword;
begin
dfs(1,0,0);
cuttree(1,0,1);
readln(opt);
for i:=1 to opt do
    begin
    read(ch); read(c);
    if ch='A' then
       begin
       read(x,y,del); inc(x); inc(y);
       anc:=lca(x,y);
       worktmp(x,anc,del);
       worktmp(y,anc,del);
       modify2(col[anc],col[anc],1,n,del,1);
       end
    else
       begin
       read(x); inc(x);
       ans:=query2(col[x],fmax[x],1,n,1);
       writeln(ans);
       end;
    readln;
    end;
end;
begin
assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);
readln(n);
flag:=1;
for i:=1 to n-1 do
    begin
    readln(x,y); inc(x); inc(y);
    fa[y]:=x;
    addedge(x,y);
    inc(cnt[x]);
    if cnt[x]>1 then flag:=0;
    end;
if flag=1 then work1
   else work2;
close(input);
close(output);
end.
