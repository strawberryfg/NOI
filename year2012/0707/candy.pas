//16:28;
const maxn=311111; inf=maxlongint; maxrand=maxlongint;
var n,i,cnt,le,ri,mid,ans,tot,root:longint;
    sum,f,size,left,right,tree,key,num,ran:array[0..maxn]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure update(x,opt:longint);
begin
size[x]:=size[left[x]]+size[right[x]]+1;
if opt=1 then tree[x]:=min(f[num[x]],min(tree[left[x]],tree[right[x]]))
   else tree[x]:=max(f[num[x]],max(tree[left[x]],tree[right[x]]));
end;
function rightrotate(x,opt:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
update(x,opt);
exit(y);
end;
function leftrotate(x,opt:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
update(x,opt);
exit(y);
end;
function insert(x,v,id,opt:longint):longint;
begin
if x=0 then
   begin
   inc(tot); size[tot]:=1; left[tot]:=0; right[tot]:=0; key[tot]:=v; num[tot]:=id; ran[tot]:=random(maxrand)+1;
   tree[tot]:=f[id];
   exit(tot);
   end;
if v<key[x] then
   begin
   left[x]:=insert(left[x],v,id,opt);
   if ran[left[x]]>ran[x] then x:=rightrotate(x,opt);
   end
else
   begin
   right[x]:=insert(right[x],v,id,opt);
   if ran[right[x]]>ran[x] then x:=leftrotate(x,opt);
   end;
update(x,opt);
exit(x);
end;
function getbigger(x,v,opt:longint):longint;
var ret:longint;
begin
if opt=1 then ret:=inf else ret:=-inf;
while x<>0 do
  begin
  if key[x]>=v then
     begin
     if opt=1 then ret:=min(min(ret,tree[right[x]]),f[num[x]])
        else ret:=max(max(ret,tree[right[x]]),f[num[x]]);
     x:=left[x];
     end
  else x:=right[x];
  end;
exit(ret);
end;
function check(x:longint):boolean;
var i,ret:longint;
begin
root:=0; tot:=0; tree[0]:=inf; size[0]:=0; f[0]:=0;
root:=insert(root,0,0,1);
for i:=1 to n do f[i]:=inf;
for i:=1 to n do
    begin
    ret:=getbigger(root,sum[i]-x,1);
    if ret=inf then continue;
    f[i]:=ret+1;
    root:=insert(root,sum[i],i,1);
    end;
if f[n]>cnt then exit(false);
root:=0; tot:=0; tree[0]:=-inf; size[0]:=0; f[0]:=0;
root:=insert(root,0,0,2);
for i:=1 to n do f[i]:=-inf;
for i:=1 to n do
    begin
    ret:=getbigger(root,sum[i]-x,2);
    if ret=-inf then continue;
    f[i]:=ret+1;
    root:=insert(root,sum[i],i,2);
    end;
if f[n]<cnt then exit(false);
exit(true);
end;
begin
assign(input,'candy.in');
reset(input);
assign(output,'candy.out');
rewrite(output);
read(n,cnt);
for i:=1 to n do begin read(sum[i]); sum[i]:=sum[i-1]+sum[i]; end;
le:=-inf div 2; ri:=inf div 2; ans:=inf;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if check(mid) then begin ans:=mid; ri:=mid-1; end
     else le:=mid+1;
  end;
writeln(ans);
close(input);
close(output);
end.