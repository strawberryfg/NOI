const maxn=455555; maxv=maxlongint;
type treetype=record left,right,key,ran,son,root:longint; end;
var tot,top,total,n:longint;
    stack:array[0..maxn*20]of longint;
    ll,rr,from,info:array[0..maxn]of longint;
    tree:array[0..maxn*20]of treetype;
    sum1,sum2,ans:qword;
procedure dfs(x:longint); inline;
var v:longint;
begin
readln(v);
if v=0 then
   begin
   inc(tot); ll[x]:=tot; dfs(tot);
   inc(tot); rr[x]:=tot; dfs(tot);
   end
else
   info[x]:=v;
end;
function getnode:longint; inline;
begin
if top=0 then begin inc(total); getnode:=total; end
   else begin getnode:=stack[top]; dec(top); end;
end;
procedure update(x:longint); inline;
begin
tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
end;
function leftrotate(x:longint):longint; inline;
var y:longint;
begin
y:=tree[x].right;
tree[x].right:=tree[y].left;
tree[y].left:=x;
update(x);
update(y);
exit(y);
end;
function rightrotate(x:longint):longint; inline;
var y:longint;
begin
y:=tree[x].left;
tree[x].left:=tree[y].right;
tree[y].right:=x;
update(x);
update(y);
exit(y);
end;
function insert(x,v:longint):longint; inline;
var now:longint;
begin
if x=0 then
   begin
   now:=getnode;
   tree[now].son:=1; tree[now].key:=v; tree[now].ran:=random(maxv)+1; tree[now].left:=0; tree[now].right:=0;
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
procedure recycle(x,y:longint); inline;
begin
if x=0 then exit;
from[y]:=insert(from[y],tree[x].key);
recycle(tree[x].left,y);
recycle(tree[x].right,y);
inc(top); stack[top]:=x;
end;
function findbigger(x,v:longint):longint; inline;
begin
if x=0 then exit(0);
if tree[x].key>v then exit(findbigger(tree[x].left,v)+1+tree[tree[x].right].son)
   else exit(findbigger(tree[x].right,v));
end;
function findsmaller(x,v:longint):longint; inline;
begin
if x=0 then exit(0);
if tree[x].key<v then exit(findsmaller(tree[x].right,v)+1+tree[tree[x].left].son)
   else exit(findsmaller(tree[x].left,v));
end;
procedure dfs2(x,y:longint); inline;
begin
if x=0 then exit;
sum1:=sum1+findbigger(y,tree[x].key);
sum2:=sum2+findsmaller(y,tree[x].key);
dfs2(tree[x].left,y);
dfs2(tree[x].right,y);
end;
procedure work(x:longint); inline;
var now,tmp:longint;
begin
if ll[x]<>0 then work(ll[x]);
if rr[x]<>0 then work(rr[x]);
if (ll[x]=0)and(rr[x]=0) then
   begin
   now:=getnode;
   from[x]:=now;
   tree[now].son:=1; tree[now].key:=info[x]; tree[now].ran:=random(maxv)+1; tree[now].left:=0; tree[now].right:=0;
   exit;
   end;
if rr[x]=0 then begin from[x]:=from[ll[x]]; exit; end;
if ll[x]=0 then begin from[x]:=from[rr[x]]; exit; end;
if tree[from[ll[x]]].son<tree[from[rr[x]]].son then begin tmp:=ll[x]; ll[x]:=rr[x]; rr[x]:=tmp; end;
sum1:=0; sum2:=0;
dfs2(from[rr[x]],from[ll[x]]);   // balanced tree root:from[rr[x]];
if sum1<sum2 then ans:=ans+sum1 else ans:=ans+sum2;
recycle(from[rr[x]],ll[x]);
from[x]:=from[ll[x]];
end;
begin
assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);
randomize;
readln(n);
tot:=1;
top:=0; total:=0;
dfs(1);
ans:=0;
work(1);
writeln(ans);
close(input);
close(output);
end.