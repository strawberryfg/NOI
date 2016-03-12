const maxn=100020; inf=maxlongint;
type rec=record u,v,nxt:longint; end;
     treetype=record l,r,v:longint; end;
var n,q,i,x,y,tot,total,ch:longint;
    edge,son,maxnum,fa,top,col,dep,h,a:array[0..maxn]of longint;
    tree:array[0..4*maxn]of treetype;
    g:array[0..2*maxn]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
function getans(x,y:longint):longint;
begin
if dep[x]<dep[y] then exit(x) else exit(y);
end;
procedure dfs(x,from,d:longint);
var max,p:longint;
begin
dep[x]:=d;
p:=edge[x];
son[x]:=1;
max:=0;
while p<>0 do
  begin
  if (g[p].v<>from) then
     begin
     fa[g[p].v]:=x;
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
var p:longint;
begin
inc(total); h[total]:=x;
col[x]:=total;                             //dfn[x];
top[x]:=root;
if maxnum[x]<>0 then cuttree(maxnum[x],x,root);
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>from)and(g[p].v<>maxnum[x]) then
     cuttree(g[p].v,x,g[p].v);
  p:=g[p].nxt;
  end;
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].v:=0;
if f=t then
   begin
   a[h[f]]:=x;
   exit;
   end;
init(f,(f+t)shr 1,x shl 1);
init((f+t)shr 1+1,t,x shl 1+1);
end;
procedure modify(x:longint);
var tmp:longint;
begin
tmp:=a[x];
if tree[tmp].v=0 then tree[tmp].v:=x
   else tree[tmp].v:=0;
while tmp>1 do
  begin
  tmp:=tmp shr 1;
  tree[tmp].v:=getans(tree[tmp shl 1].v,tree[tmp shl 1+1].v);
  end;
end;
function ask(f,t,x:longint):longint;
var res,mid:longint;
begin
if (tree[x].l=f)and(tree[x].r=t) then
   begin
   exit(tree[x].v);
   end;
mid:=(tree[x].l+tree[x].r)shr 1;
if t<=mid then exit(ask(f,t,x shl 1))
   else if f>mid then exit(ask(f,t,x*2+1))
           else begin
                res:=0;
                res:=getans(res,ask(f,tree[x shl 1].r,x shl 1));
                res:=getans(res,ask(tree[x shl 1+1].l,t,x shl 1+1));
                end;
//tree[x].v:=getans(tree[x*2].v,tree[x*2+1].v);
exit(res);
end;
function query(x:longint):longint;
var ans:longint;
begin
ans:=0;
while x<>0 do
  begin
  ans:=getans(ans,ask(col[top[x]],col[x],1));
  x:=fa[top[x]];
  end;
if ans=0 then ans:=-1;
exit(ans);
end;
begin
{assign(input,'qtree3.in');
reset(input);
assign(output,'qtree3.out');
rewrite(output);}
readln(n,q);
for i:=1 to n-1 do
    begin
    readln(x,y);
    addedge(x,y);
    end;
dfs(1,0,0);
cuttree(1,0,1);
init(1,n,1);
dep[0]:=inf;
fa[1]:=0;
//for i:=1 to n do writeln(i,' dep: ',dep[i],' col: ',col[i],' top: ',top[i],' fa: ',fa[i]);
for i:=1 to q do
    begin
    readln(ch,x);
    if ch=0 then
       begin
       modify(x);
       end
    else
       begin
       writeln(query(x));
       end;
    end;
{close(input);
close(output);}
end.
