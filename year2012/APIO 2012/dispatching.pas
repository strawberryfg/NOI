//19:15;
const maxn=200020; maxv=maxlongint;
type gtype=record v,nxt:longint; end;
     treetype=record left,right,son,ran:longint; key,sum:int64; end;
var n,i,fa,root,top,total,tot:longint;
    a,value:array[0..maxn]of int64;
    edge,from:array[0..maxn]of longint;
    g:array[0..maxn]of gtype;
    tree:array[0..maxn*20]of treetype;
    stack:array[0..maxn*20]of longint;
    m,ans:int64;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getnode:longint;
begin
if top=0 then begin inc(total); getnode:=total; end
   else begin getnode:=stack[top]; dec(top); end;
end;
procedure update(x:longint);
begin
tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
tree[x].sum:=tree[tree[x].left].sum+tree[tree[x].right].sum+tree[x].key;
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].left;
tree[x].left:=tree[y].right;
tree[y].right:=x;
update(x);
update(y);
exit(y);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].right;
tree[x].right:=tree[y].left;
tree[y].left:=x;
update(x);
update(y);
exit(y);
end;
function insert(x:longint; v:int64):longint;
var now:longint;
begin
if x=0 then
   begin
   now:=getnode;
   tree[now].left:=0; tree[now].right:=0; tree[now].son:=1; tree[now].key:=v; tree[now].ran:=random(maxv)+1; tree[now].sum:=v;
   insert:=now;
   end
else
   begin
   if v<tree[x].key then
      begin
      tree[x].left:=insert(tree[x].left,v);
      if tree[tree[x].left].ran>tree[x].ran then x:=rightrotate(x);
      end
   else
      begin
      tree[x].right:=insert(tree[x].right,v);
      if tree[tree[x].right].ran>tree[x].ran then x:=leftrotate(x);
      end;
   update(x);
   insert:=x;
   end;
end;
procedure recycle(x,y:longint);
begin
if x=0 then exit;
from[y]:=insert(from[y],tree[x].key);
recycle(tree[x].left,y);
recycle(tree[x].right,y);
inc(top);
stack[top]:=x;
end;
function check(x,posi:longint):boolean;
var ret:int64;
begin
ret:=0;
while x<>0 do
  begin
  if tree[tree[x].left].son+1=posi then begin ret:=ret+tree[tree[x].left].sum+tree[x].key; break; end
     else if tree[tree[x].left].son>=posi then x:=tree[x].left
             else begin ret:=ret+tree[tree[x].left].sum+tree[x].key; posi:=posi-1-tree[tree[x].left].son; x:=tree[x].right; end;
  if ret>m then break;
  end;
if ret>m then check:=false else check:=true;
end;
procedure work(x:longint);
var p,num1,num2,le,ri,mid,opt:longint; res:int64;
begin
p:=edge[x];
while p<>0 do
  begin
  work(g[p].v);
  if from[x]=0 then from[x]:=from[g[p].v]
     else begin
          if tree[from[x]].son>tree[from[g[p].v]].son then begin num1:=from[g[p].v]; num2:=x; opt:=1; end
             else begin num1:=from[x]; num2:=g[p].v; opt:=2; end;
          recycle(num1,num2);
          if opt=2 then from[x]:=from[g[p].v];
          end;
  p:=g[p].nxt;
  end;
from[x]:=insert(from[x],a[x]);
le:=1; ri:=tree[from[x]].son;
res:=-1;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if check(from[x],mid) then begin res:=mid; le:=mid+1; end
     else ri:=mid-1;
  end;
if res<>-1 then res:=res*value[x];
if res>ans then ans:=res;
end;
begin
assign(input,'dispatching.in');
reset(input);
assign(output,'dispatching.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    readln(fa,a[i],value[i]);
    if fa<>0 then addedge(fa,i) else root:=i;
    end;
ans:=0;
work(root);
writeln(ans);
close(input);
close(output);
end.