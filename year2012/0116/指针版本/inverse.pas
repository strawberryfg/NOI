uses dos;
const maxn=100020; maxnode=5000000; maxrand=maxlongint;
type point=^node;
     node=record  key,son,num:longint; left,right:point; end;
     rec=record l,r:longint; root:point end;
var n,m,i,t,t1,t2,v,tot:longint;
    ans:int64;
    bit,a,hash:array[0..maxn]of longint;
    tree:array[0..4*maxn]of rec;
    aa,bb,cc,dd:word;
    tt1,tt2:real;
    x:point;
function query(x:longint):int64;
var res:int64;
begin
res:=0;
while x>0 do
  begin
  res:=res+bit[x];
  x:=x-x and -x;
  end;
exit(res);
end;
procedure modify(x,d:longint);
begin
while x<=n do
  begin
  bit[x]:=bit[x]+d;
  x:=x+x and -x;
  end;
end;
procedure update(var x:point);
begin
if (x^.left<>nil)and(x^.right<>nil) then x^.son:=x^.left^.son+x^.right^.son+1
   else if (x^.left<>nil)and(x^.right=nil) then x^.son:=x^.left^.son+1
           else if (x^.left=nil)and(x^.right<>nil) then x^.son:=x^.right^.son+1
                   else x^.son:=1;
end;
function leftrotate(x:point):point;
var y:point;
begin
y:=x^.right;
x^.right:=y^.left;
y^.left:=x;
y^.son:=x^.son;
update(x);
exit(y);
end;
function rightrotate(x:point):point;
var y:point;
begin
y:=x^.left;
x^.left:=y^.right;
y^.right:=x;
y^.son:=x^.son;
update(x);
exit(y);
end;
function insert(root:point; v:longint):point;
begin
if root=nil then
   begin
   new(x);
   x^.key:=v;
   root:=x;
   x^.num:=random(maxrand)+1;
   x^.son:=1;
   x^.left:=nil; x^.right:=nil;
   exit(root);
   end
else
   begin
   if v<root^.key then
      begin
      root^.left:=insert(root^.left,v);
      if root^.left^.num>root^.num then
         root:=rightrotate(root);
      end
   else
      begin
      root^.right:=insert(root^.right,v);
      if root^.right^.num>root^.num then
         root:=leftrotate(root);
      end;
   update(root);
   exit(root);
   end;
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
for i:=f to t do
    tree[x].root:=insert(tree[x].root,a[i]);
end;
function delete(now:point; v:longint):point;
begin
if v<now^.key then now^.left:=delete(now^.left,v)
   else if v>now^.key then now^.right:=delete(now^.right,v)
           else begin
                if (now^.left=nil)and(now^.right=nil) then
                   exit(nil);
                if (now^.right=nil)or((now^.right<>nil)and(now^.left<>nil)and(now^.left^.num>now^.right^.num)) then
                   begin
                   now:=rightrotate(now);
                   now^.right:=delete(now^.right,v);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   now^.left:=delete(now^.left,v);
                   end;
                end;
update(now);
exit(now);
end;
procedure work(f,t,x,v:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].root:=delete(tree[x].root,v);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then work(f,t,x*2,v);
if t>mid then work(f,t,x*2+1,v);
if (tree[x].l<=f)and(f<=tree[x].r) then
   tree[x].root:=delete(tree[x].root,v);
end;
function ask(opt,v:longint;x:point):longint;
var res:longint;
begin
if x=nil then exit(0);
if opt=1 then
   begin
   if v>=x^.key then exit(ask(opt,v,x^.right))
      else if v<x^.key then
              begin
              if x^.right<>nil then res:=x^.right^.son+1 else res:=1;
              res:=res+ask(opt,v,x^.left);
              exit(res);
              end;
   end
else
   begin
   if v<=x^.key then exit(ask(opt,v,x^.left))
      else if v>x^.key then
              begin
              if x^.left<>nil then res:=x^.left^.son+1 else res:=1;
              res:=res+ask(opt,v,x^.right);
              exit(res);
              end;
   end;
end;
function query(f,t,x,opt:longint):longint;
var mid,res:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   exit(ask(opt,v,tree[x].root));
   end;
mid:=(tree[x].l+tree[x].r)div 2;
res:=0;
if f<=mid then res:=query(f,t,x*2,opt);
if t>mid then res:=res+query(f,t,x*2+1,opt);
exit(res);
end;
begin
assign(input,'inverse.in');
reset(input);
assign(output,'inverse.out');
rewrite(output);
readln(n,m);
ans:=0;
randomize;   //init
gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;
for i:=1 to n do
    begin
    readln(t);
    a[i]:=t;
    ans:=ans+query(n)-query(t);
    modify(t,1);
    hash[t]:=i; //position
    end;
init(1,n,1);
for i:=1 to m do
    begin
    readln(t);
    writeln(ans);
    v:=t;
    t1:=query(1,hash[t]-1,1,1);
    t2:=query(hash[t]+1,n,1,2);
    ans:=ans-t1-t2;
    work(hash[t],hash[t],1,t);
    end;
gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:10);
close(input);
close(output);
end.