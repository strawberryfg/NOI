//uses dos;
const maxn=100020; maxnode=5000000; maxrand=maxlongint;
type rec=record l,r,root:longint; end;
var n,m,i,t,t1,t2,v,tot:longint;
    ans:int64;
    bit,a,hash:array[0..maxn]of longint;
    tree:array[0..4*maxn]of rec;
    left,right,key,son,num:array[0..maxnode]of longint;
{   aa,bb,cc,dd:word;
    tt1,tt2:real;}
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
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
son[y]:=son[x];
son[x]:=son[left[x]]+son[right[x]]+1;
exit(y);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
son[y]:=son[x];
son[x]:=son[left[x]]+son[right[x]]+1;
exit(y);
end;
function insert(var root:longint; v:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   left[tot]:=0; right[tot]:=0;
   key[tot]:=v;
   root:=tot;
   num[tot]:=random(maxrand)+1;
   son[tot]:=1;
   exit(root);
   end
else
   begin
   if v<key[root] then
      begin
      left[root]:=insert(left[root],v);
      if num[left[root]]>num[root] then
         root:=rightrotate(root);
      end
   else
      begin
      right[root]:=insert(right[root],v);
      if num[right[root]]>num[root] then
         root:=leftrotate(root);
      end;
   son[root]:=son[left[root]]+son[right[root]]+1;
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
function delete(now:longint; v:longint):longint;
begin
if v<key[now] then left[now]:=delete(left[now],v)
   else if v>key[now] then right[now]:=delete(right[now],v)
           else begin
                if (left[now]=0)and(right[now]=0) then
                   exit(0);
                if num[left[now]]>num[right[now]] then
                   begin
                   now:=rightrotate(now);
                   right[now]:=delete(right[now],v);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   left[now]:=delete(left[now],v);
                   end;

                end;
son[now]:=son[left[now]]+son[right[now]]+1;
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
function ask(opt,v,x:longint):longint;
var res:longint;
begin
if x=0 then exit(0);
if opt=1 then
   begin
   if v>=key[x] then exit(ask(opt,v,right[x]))
      else if v<key[x] then
              begin
              res:=son[right[x]]+1;
              res:=res+ask(opt,v,left[x]);
              exit(res);
              end;
   end
else
   begin
   if v<=key[x] then exit(ask(opt,v,left[x]))
      else if v>key[x] then
              begin
              res:=son[left[x]]+1;
              res:=res+ask(opt,v,right[x]);
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
{gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;}
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
{gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:10);}
close(input);
close(output);
end.

