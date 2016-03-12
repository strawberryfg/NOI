//21:00; 21:40
const maxn=100000; maxv=maxlongint;
type rec=record l,r,root:longint; end;
var n,v,i,j,cntf,cntg,k,tot:longint;
    sa,sb,a,f,g,ind,belf,belg:array[0..maxn]of longint;
    left,right,son,key,num:array[0..20*maxn]of longint;
    tree:array[0..1,0..4*maxn]of rec;
    ans:qword;
procedure sort1(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=f[(l+r) div 2];
repeat
while f[i]<x do inc(i);
while x<f[j] do dec(j);
if not(i>j) then begin y:=f[i]; f[i]:=f[j]; f[j]:=y; y:=ind[i]; ind[i]:=ind[j]; ind[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort1(l,j);
if i<r then sort1(i,r);
end;
procedure sort2(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=g[(l+r) div 2];
repeat
while g[i]<x do inc(i);
while x<g[j] do dec(j);
if not(i>j) then begin y:=g[i]; g[i]:=g[j]; g[j]:=y; y:=ind[i]; ind[i]:=ind[j]; ind[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
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
function insert(root,v:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   key[tot]:=v;
   num[tot]:=random(maxv)+1;
   son[tot]:=1;
   exit(tot);
   end
else
   begin
   inc(son[root]);
   if (v<key[root]) then
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
//   son[root]:=son[left[root]]+son[right[root]]+1;
   exit(root);
   end;
end;
procedure init(f,t,x:longint);
begin
tree[0][x].l:=f; tree[0][x].r:=t;
tree[1][x].l:=f; tree[1][x].r:=t;
if f=t then exit;
tree[0][x].root:=0; tree[1][x].root:=0;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure modify(f,t,x,opt,v:longint);
var mid:longint;
begin
if (f<=tree[opt][x].l)and(tree[opt][x].r<=t) then
   begin
   tree[opt][x].root:=insert(tree[opt][x].root,v);
   exit;
   end;
mid:=(tree[opt][x].l+tree[opt][x].r)div 2;
if f<=mid then modify(f,t,x*2,opt,v);
if t>mid then modify(f,t,x*2+1,opt,v);
tree[opt][x].root:=insert(tree[opt][x].root,v);
end;
function ask(x,v:longint):longint;
begin
if x=0 then exit(0);
if v>key[x] then exit(ask(right[x],v))
   else if v=key[x] then exit(ask(left[x],v)+1+ask(right[x],v))
           else exit(son[right[x]]+1+ask(left[x],v));
end;
function query(f,t,x,opt,v:longint):longint;
var mid,ret:longint;
begin
if (f<=tree[opt][x].l)and(tree[opt][x].r<=t) then
   begin
   exit(ask(tree[opt][x].root,v));
   end;
mid:=(tree[opt][x].l+tree[opt][x].r)div 2;
ret:=0;
if f<=mid then ret:=query(f,t,x*2,opt,v);
if t>mid then ret:=ret+query(f,t,x*2+1,opt,v);
exit(ret);
end;
begin
assign(input,'median.in');
reset(input);
assign(output,'median.out');
rewrite(output);
readln(n,v);
sa[0]:=0; sb[0]:=0;
for i:=1 to n do
    begin
    read(a[i]);
    sa[i]:=sa[i-1];
    sb[i]:=sb[i-1];
    if a[i]<v then inc(sa[i])
       else if a[i]>v then inc(sb[i]);
    end;
for i:=1 to n do f[i]:=2*sa[i]-i;
for i:=1 to n do g[i]:=2*sb[i]-i;
for i:=1 to n+1 do ind[i]:=i;
f[n+1]:=0; g[n+1]:=0;
sort1(1,n+1);
i:=1;
cntf:=0;
while i<=n+1 do
  begin
  j:=i;
  while (j+1<=n+1)and(f[j+1]=f[i]) do inc(j);
  inc(cntf);
  // sf[cntf]:=f[i];
  for k:=i to j do belf[ind[k]]:=cntf;
  i:=j+1;
  end;
for i:=1 to n+1 do ind[i]:=i;
sort2(1,n+1);
i:=1;
cntg:=0;
while i<=n+1 do
  begin
  j:=i;
  while (j+1<=n+1)and(g[j+1]=g[i]) do inc(j);
  inc(cntg);
  // sg[cntg]:=g[i];
  for k:=i to j do belg[ind[k]]:=cntg;
  i:=j+1;
  end;
init(1,cntf,1);
modify(belf[n+1],belf[n+1],1,0,belg[n+1]);
ans:=0;
for i:=1 to n do
    begin
    ans:=ans+qword(query(belf[i],cntf,1,(i-1)mod 2,belg[i]));
    modify(belf[i],belf[i],1,i mod 2,belg[i]);
    end;
writeln(ans);
close(input);
close(output);
end.