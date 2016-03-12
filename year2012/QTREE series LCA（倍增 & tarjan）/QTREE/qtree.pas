const maxn=30020; maxm=60020; inf=maxlongint;
type edgetype=record u,v,c,nxt:longint; end;
     treetype=record l,r,max:longint; end;
var u,test,i,n,x,y,z,tot,tme,total,t:longint;
    ch:char;
    edge,son,maxnum,fa,dep,h,col,root,ret,hash:array[0..maxn]of longint;
    g:array[0..maxm]of edgetype;
    bel:array[0..maxm]of longint;
    f:array[0..maxn,0..17]of longint;
    tree:array[0..4*maxn]of treetype;
procedure pre;
begin
tot:=0;
tme:=0;
total:=0;
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(son,sizeof(son),0);
fillchar(maxnum,sizeof(maxnum),0);
fillchar(f,sizeof(f),0);
fillchar(fa,sizeof(fa),0);
fillchar(dep,sizeof(dep),0);
fillchar(h,sizeof(h),0);
fillchar(col,sizeof(col),0);
fillchar(root,sizeof(root),0);
fillchar(bel,sizeof(bel),0);
fillchar(ret,sizeof(ret),0);
fillchar(hash,sizeof(hash),0);
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=z; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
function getmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure dfs(x,from,d:longint);
var p,max,i:longint;
begin
dep[x]:=d;
son[x]:=1;
f[x][0]:=from;
for i:=1 to 16 do
    f[x][i]:=f[f[x][i-1]][i-1];
p:=edge[x];
max:=0;
while p<>0 do
  begin
  if (g[p].v<>from) then
     begin
     dfs(g[p].v,x,d+1);
     son[x]:=son[x]+son[g[p].v];
     if son[g[p].v]>max then
        begin
        max:=son[g[p].v];
        maxnum[x]:=g[p].v;
        end;
     fa[g[p].v]:=p;
     end;
    //   g[fa[x]].v=x g[fa[x]].u=f[x][0];   light edge
  p:=g[p].nxt;
  end;
end;
procedure cuttree(x,top,from:longint);
var p:longint;
begin
inc(tme);
h[tme]:=x; root[x]:=top;
col[x]:=tme;     // flag;
if x<>1 then
   begin
   inc(total);      // new edge number
   bel[fa[x]]:=total;  //bel[original edge number]=new edge number in the segment tree
   hash[total]:=fa[x];
   end;
p:=edge[x];
if maxnum[x]<>0 then cuttree(maxnum[x],top,x);
while p<>0 do
  begin
  if (g[p].v<>from)and(g[p].v<>maxnum[x]) then
     begin
     cuttree(g[p].v,g[p].v,x);
     end;
  p:=g[p].nxt;
  end;
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t; tree[x].max:=-inf;
if f=t then
   begin
   ret[f]:=x;
   tree[x].max:=g[hash[f]].c;
   exit;
   end;
init(f,(f+t)shr 1,x shl 1);
init((f+t)shr 1+1,t,x shl 1+1);
tree[x].max:=getmax(tree[x shl 1].max,tree[x shl 1+1].max);
end;
procedure modify(x,y:longint);
var p:longint;
begin
if root[g[x].u]<>root[g[x].v] then
   begin
   g[x].c:=y;
   end
else
   begin
   p:=ret[bel[x]];
   tree[p].max:=y;
   while p>1 do
     begin
     p:=p shr 1;
     tree[p].max:=getmax(tree[p shl 1].max,tree[p shl 1+1].max);
     end;
   end;
end;
procedure up(var x:longint; step:longint);
var t:longint;
begin
t:=0;
while step>0 do
  begin
  if step mod 2=1 then x:=f[x][t];
  inc(t);
  step:=step shr 1;
  end;
end;
function lca(x,y:longint):longint;
var i:longint;
begin
if dep[x]<dep[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
up(x,dep[x]-dep[y]);
if x=y then exit(x);
for i:=16 downto 0 do
    begin
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
    end;
exit(f[x][0]);
end;
function ask(f,t,x:longint):longint;
var mid:longint;
begin
if (f=tree[x].l)and(tree[x].r=t) then exit(tree[x].max);
mid:=(tree[x].r+tree[x].l)shr 1;
if (t<=mid) then exit(ask(f,t,x*2));
if (f>mid) then exit(ask(f,t,x*2+1));
exit(getmax(ask(f,mid,x*2),ask(mid+1,t,x*2+1)));
end;
function work(x,anc:longint):longint;
var ans,ll,rr:longint;
begin
ans:=-inf;
while true do
  begin
  if x=anc then break;
  if root[x]<>x then
     begin
     if (col[root[x]]<=col[anc])and(col[anc]<col[x]) then
        begin
        ll:=maxnum[anc];
        ll:=bel[fa[ll]];
        rr:=bel[fa[x]];
        ans:=getmax(ans,ask(ll,rr,1));
        break;
        end
     else
        begin
        ll:=maxnum[root[x]];
        ll:=bel[fa[ll]];
        rr:=bel[fa[x]];
        ans:=getmax(ans,ask(ll,rr,1));
        end;
     end;
  ans:=getmax(ans,g[fa[root[x]]].c);
  x:=g[fa[root[x]]].u;
  end;
exit(ans);
end;
function query(x,y:longint):longint;
var anc,ans:longint;
begin
anc:=lca(x,y);
ans:=work(x,anc);
ans:=getmax(ans,work(y,anc));
exit(ans);
end;
begin
{assign(input,'qtree.in');
reset(input);
assign(output,'e:\wqf\qtree.out');
rewrite(output);}
readln(test);
for u:=1 to test do
    begin
    readln(n);
    pre;
    for i:=1 to n-1 do
        begin
        readln(x,y,z);
        addedge(x,y,z);
        end;
    dfs(1,0,0);
    cuttree(1,1,0);
    init(1,n-1,1);
{    for i:=1 to n do
        begin
        writeln(i,'  dep:   ',dep[i],' son: ',son[i],' root: ',root[i],' fa: ',g[fa[i]].u,' and ',g[fa[i]].v,' maxnum: ',maxnum[i]);
        end;}
    read(ch);
    while ch<>'D' do
      begin
      if ch='Q' then
         begin
         for i:=1 to 5 do read(ch);
         read(x,y);
{         if (x=6)and(y=9) then
            x:=x;}
         writeln(query(x,y));
         end
      else
         begin
         for i:=1 to 6 do read(ch);
         read(x,y);
         x:=2*x-1;
         t:=fa[g[x].v];
         if t<>x then t:=fa[g[x].u];
         modify(t,y);
         end;
      readln;
      read(ch);
      end;
    for i:=1 to 3 do read(ch);
    readln;
    end;
{close(input);
close(output);}
end.
