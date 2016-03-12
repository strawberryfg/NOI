//uses dos;
const maxn=100020; maxm=3000020; maxrand=maxlongint;
type rec=record l,r,root:longint; end;
     rea=record left,right,son,key,num:longint; end;
var n,m,i,x,y,k,ans,tot,tt:longint;
    ch,c:char;
    a:array[0..maxn]of longint;
    g:array[0..maxm]of rea;
    tree:array[0..4*maxn]of rec;
{    aa,bb,cc,dd:word;
    tt1,tt2:real;}
procedure update(x:longint);
begin
g[x].son:=g[g[x].left].son+g[g[x].right].son+1;
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=g[x].left;
g[x].left:=g[y].right;
g[y].right:=x;
g[y].son:=g[x].son;
update(x);
exit(y);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=g[x].right;
g[x].right:=g[y].left;
g[y].left:=x;
g[y].son:=g[x].son;
update(x);
exit(y);
end;
function insert(var root:longint; v:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   g[tot].key:=v;
   g[tot].num:=random(maxrand)+1;
   g[tot].son:=1;
   root:=tot;
   exit(root);
   end;
if v<g[root].key then
   begin
   g[root].left:=insert(g[root].left,v);
   if g[g[root].left].num>g[root].num then root:=rightrotate(root);
   end
else
   begin
   g[root].right:=insert(g[root].right,v);
   if g[g[root].right].num>g[root].num then root:=leftrotate(root);
   end;
update(root);
exit(root);
end;
function delete(now:longint; v:longint):longint;
begin
if v<g[now].key then g[now].left:=delete(g[now].left,v)
   else if v>g[now].key then g[now].right:=delete(g[now].right,v)
           else begin
                if (g[now].left=0)and(g[now].right=0) then
                   exit(0);
                if g[g[now].left].num>g[g[now].right].num then
                   begin
                   now:=rightrotate(now);
                   g[now].right:=delete(g[now].right,v);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   g[now].left:=delete(g[now].left,v);
                   end;
                end;
update(now);
exit(now);
end;
procedure init(f,t,x:longint);
var i:longint;
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then
   begin
   tree[x].root:=insert(tree[x].root,a[f]);
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
for i:=f to t do tree[x].root:=insert(tree[x].root,a[i]);
end;
procedure work(p,v,x,opt:longint);
var mid:longint;
begin
if (tree[x].l=tree[x].r) then
   begin
   if opt=1 then
      tree[x].root:=delete(tree[x].root,v)
   else
      tree[x].root:=insert(tree[x].root,v);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if p<=mid then work(p,v,x*2,opt);
if p>mid then work(p,v,x*2+1,opt);
if (tree[x].l<=p)and(p<=tree[x].r) then
   begin
   if opt=1 then tree[x].root:=delete(tree[x].root,v)
      else tree[x].root:=insert(tree[x].root,v);
   end;
end;
function ask(x,v:longint):longint;
var res:longint;
begin
if x=0 then exit(0);
if v<g[x].key then exit(ask(g[x].left,v))
   else begin
        res:=g[g[x].left].son+1;
        res:=res+ask(g[x].right,v);
        exit(res);
        end;
end;
function query(f,t,v,x:longint):longint;
var mid,res:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   exit(ask(tree[x].root,v))
else
   begin
   mid:=(tree[x].l+tree[x].r)div 2;
   res:=0;
   if f<=mid then res:=query(f,t,v,x*2);
   if t>mid then res:=res+query(f,t,v,x*2+1);
   exit(res);
   end;
end;
begin
{assign(input,'racetime.in');
reset(input);
assign(output,'e:\work\racetime.out');
rewrite(output);}
randomize;
readln(n,m);
for i:=1 to n do readln(a[i]);
init(1,n,1);
{gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;}
for i:=1 to m do
    begin
    read(ch); read(c);
    if ch='C' then
       inc(tt);
    if ch='C' then
       begin
       read(x,y,k);
       ans:=query(x,y,k,1);
       writeln(ans);
       end
    else
       begin
       read(x,y);
       work(x,a[x],1,1);
       work(x,y,1,2);
       a[x]:=y;
       end;
    readln;
    end;
{writeln(tt);
gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:10);
close(input);
close(output);   }
end.