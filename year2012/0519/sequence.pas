const maxn=100020; maxbina=20; maxrand=maxlongint; inf=maxlongint;
type treetype=record root:longint; end;
var n,i,ret,ans,tot:longint;
    key,max,num,left,right,ran:array[0..maxn*maxbina]of longint;
    a,flag,f:array[0..maxn]of longint;
    tree:array[0..maxn*maxbina]of treetype;
function getmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure update(x:longint);
begin
max[x]:=getmax(max[left[x]],max[right[x]]);
max[x]:=getmax(max[x],num[x]);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
update(x);
exit(y);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
update(x);
exit(y);
end;
function insert(x,value,dfn:longint):longint;
begin
if x=0 then
   begin
   inc(tot);
   key[tot]:=value;
   max[tot]:=dfn;
   num[tot]:=dfn;
   ran[tot]:=random(maxrand)+1;
   exit(tot);
   end;
if value<=key[x] then
   begin
   left[x]:=insert(left[x],value,dfn);
   if ran[left[x]]>ran[x] then
      x:=rightrotate(x);
   end
else
   begin
   right[x]:=insert(right[x],value,dfn);
   if ran[right[x]]>ran[x] then
      x:=leftrotate(x);
   end;
update(x);
exit(x);
end;
procedure modify(l,r,x,xa,xb,dfn:longint);
var mid:longint;
begin
tree[x].root:=insert(tree[x].root,xb,dfn);
if (xa<=l)and(r<=xa) then exit;
mid:=(l+r) div 2;
if xa<=mid then modify(l,mid,x*2,xa,xb,dfn);
if xa>mid then modify(mid+1,r,x*2+1,xa,xb,dfn);
end;
function ask(x,value:longint):longint;
begin
if x=0 then exit(0);
if key[x]<=value then
   begin
   ask:=getmax(max[left[x]],num[x]);
   ask:=getmax(ask,ask(right[x],value));
   exit;
   end
else
   ask:=ask(left[x],value);
end;
function query(l,r,x,xa,xb:longint):longint;
var mid:longint;
begin
if (1<=l)and(r<=xa) then
   begin
   query:=ask(tree[x].root,xb);
   exit;
   end;
mid:=(l+r) div 2;
query:=0;
query:=query(l,mid,x*2,xa,xb);
if xa>mid then query:=getmax(query,query(mid+1,r,x*2+1,xa,xb));
end;
begin
assign(input,'sequence.in');
reset(input);
assign(output,'sequence.out');
rewrite(output);
randomize;
readln(n);
for i:=1 to n do read(a[i]);
for i:=1 to n do if a[i]>i then flag[i]:=-1;
for i:=1 to n do f[i]:=-inf;
for i:=1 to n do
    begin
    if flag[i]=-1 then continue;
    if a[i]=1 then
       f[i]:=1
    else
       begin
       if i=720 then
          ret:=ret;
       if a[i]>0 then ret:=query(1,n,1,a[i]-1,i-a[i])
          else ret:=-1;
       f[i]:=ret+1;
       end;
    if a[i]>0 then modify(1,n,1,a[i],i-a[i],f[i]);
    end;
ans:=0;
for i:=1 to n do if f[i]>ans then ans:=f[i];
writeln(ans);
close(input);
close(output);
end.