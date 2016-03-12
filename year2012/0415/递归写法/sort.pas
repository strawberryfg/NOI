const maxn=100000;
var n,tot,root,i,x,l,r,t1,t2:longint;
    a,ta,b,ind,left,right,son,rev,key,fa,ans:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,x,y,tmp: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2]; y:=ind[(l+r)div 2];
repeat
while (a[i]<x)or((a[i]=x)and(ind[i]<y)) do inc(i);
while (x<a[j])or((x=a[j])and(y<ind[j])) do dec(j);
if not(i>j) then begin tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp; tmp:=ind[i]; ind[i]:=ind[j]; ind[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure lazydown(x:longint);
var tmp:longint;
begin
if rev[x]<>0 then
   begin
   rev[left[x]]:=1-rev[left[x]];
   rev[right[x]]:=1-rev[right[x]];
   tmp:=left[x]; left[x]:=right[x]; right[x]:=tmp;
   rev[x]:=0;
   end;
end;
function find(x,y:longint):longint;
begin
lazydown(x);
if son[left[x]]>=y then exit(find(left[x],y))
   else if son[left[x]]+1=y then exit(x)
           else exit(find(right[x],y-1-son[left[x]]));
end;
procedure update(x:longint);
var t1,t2,t:longint;
begin
if x=0 then exit;
son[x]:=son[left[x]]+son[right[x]]+1;
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
//lazydown(y);
//lazydown(x);
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
right[x]:=y;
son[x]:=son[y];
son[y]:=son[left[y]]+son[right[y]]+1;
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
//lazydown(y);
//lazydown(x);
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
left[x]:=y;
son[x]:=son[y];
son[y]:=son[left[y]]+son[right[y]]+1;
end;
procedure splay(x,y:longint);
begin
lazydown(x);
while fa[x]<>y do
  begin
  lazydown(fa[fa[x]]);
  lazydown(fa[x]);
//  lazydown(x);
  if fa[fa[x]]=y then
     begin
     if x=left[fa[x]] then rightrotate(x)
        else leftrotate(x);
     end
  else
     begin
     if fa[x]=left[fa[fa[x]]] then
        begin
        if x=left[fa[x]] then
           begin
           rightrotate(fa[x]);
           rightrotate(x);
           end
        else
           begin
           leftrotate(x);
           rightrotate(x);
           end;
        end
     else
        begin
        if x=right[fa[x]] then
           begin
           leftrotate(fa[x]);
           leftrotate(x);
           end
        else
           begin
           rightrotate(x);
           leftrotate(x);
           end;
        end;
     end;
  end;
if y=0 then root:=x;
end;
procedure build(x,l,r:longint);
begin
key[x]:=a[(l+r)div 2];
b[(l+r)div 2]:=x;
rev[x]:=0;
son[x]:=1;
if l=r then
   begin
   left[x]:=0; right[x]:=0;
   exit;
   end;
if l<=(l+r)div 2-1 then
   begin
   inc(tot);
   fa[tot]:=x;
   left[x]:=tot;
   build(tot,l,(l+r)div 2-1);
   end;
if r>=(l+r)div 2+1 then
   begin
   inc(tot);
   fa[tot]:=x;
   right[x]:=tot;
   build(tot,(l+r)div 2+1,r);
   end;
son[x]:=son[left[x]]+son[right[x]]+1;
end;
begin
assign(input,'sort.in');
reset(input);
assign(output,'sort.out');
rewrite(output);
readln(n);
tot:=3;
root:=1;
son[1]:=2; son[2]:=1; right[1]:=2; fa[2]:=1;
fa[3]:=2;
left[2]:=3;
for i:=1 to n do begin read(a[i]); ind[i]:=i; end;
ta:=a;
sort(1,n);
a:=ta;
build(3,1,n);
son[2]:=son[left[2]]+son[right[2]]+1;
son[1]:=son[left[1]]+son[right[1]]+1;
for i:=1 to n do
    begin
    x:=b[ind[i]];
    splay(x,0);
    ans[i]:=son[left[x]]+1-1; //l:=i; r:=son[left[x]]+1-1;
    l:=i+1;
    r:=son[left[x]]+1;

       t1:=find(root,l-1);
       splay(t1,0);
       t2:=find(root,r+1);
       splay(t2,t1);
       rev[left[t2]]:=1-rev[left[t2]];
       splay(left[t2],0);
    end;
for i:=1 to n-1 do write(ans[i],' ');
write(ans[n]);
writeln;
close(input);
close(output);
end.
