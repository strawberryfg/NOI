//15:23;
const inf=maxlongint; maxn=302000;
var tot,root,n,i,q,x,y,total:longint;
    son,key,sum,left,right,lmax,rmax,max,fa,a:array[0..maxn]of longint;
    ch:char;
function find(x,k:longint):longint;
begin
while son[left[x]]+1<>k do
  begin
  if son[left[x]]>=k then x:=left[x]
     else begin
          k:=k-1-son[left[x]];
          x:=right[x];
          end;
  end;
exit(x);
end;
function getmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure update(x:longint);
var t,t1,t2:longint;
begin
if x=0 then exit;
son[x]:=son[left[x]]+son[right[x]]+1;
sum[x]:=sum[left[x]]+sum[right[x]]+key[x];
lmax[x]:=getmax(lmax[left[x]],sum[left[x]]+key[x]+getmax(lmax[right[x]],0));
rmax[x]:=getmax(rmax[right[x]],sum[right[x]]+key[x]+getmax(rmax[left[x]],0));
max[x]:=getmax(getmax(max[right[x]],max[left[x]]),key[x]);
t1:=rmax[left[x]]; if t1=-inf then t1:=0;
t2:=lmax[right[x]];if t2=-inf then t2:=0;
max[x]:=getmax(max[x],key[x]+t1+t2);
t:=getmax(rmax[left[x]],lmax[right[x]]);
if t<>-inf then max[x]:=getmax(max[x],t+key[x]);
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
right[x]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
update(y);
update(x);
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
left[x]:=y;
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
update(y);
update(x);
end;
procedure splay(x,y:longint);
begin
while fa[x]<>y do
  begin
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
        end
     end;
  end;
if y=0 then root:=x;
end;
procedure insert(k,v:longint);
var x,y:longint;
begin
inc(total);
x:=find(root,k+1);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
inc(tot);
key[tot]:=v; son[tot]:=1; lmax[tot]:=v; rmax[tot]:=v; max[tot]:=v;
sum[tot]:=v;
fa[tot]:=y;
left[y]:=tot;
update(y);
update(x);
splay(tot,0);
end;
procedure build(x,l,r:longint);
begin
key[x]:=a[(l+r)div 2];
son[x]:=1;
if l=r then
   begin
   inc(tot);
   key[tot]:=a[l];
   lmax[tot]:=a[l]; rmax[tot]:=a[l]; max[tot]:=a[l];
   sum[tot]:=a[l];
   exit;
   end;
if l<=(l+r)div 2-1 then
   begin
   inc(tot);
   left[x]:=tot;
   fa[tot]:=x;
   build(tot,l,(l+r)div 2-1);
   end;
if (l+r)div 2+1<=r then
   begin
   inc(tot);
   right[x]:=tot;
   fa[tot]:=x;
   build(tot,(l+r)div 2+1,r);
   end;
update(x);
end;
procedure delete(k:longint);
var x,y:longint;
begin
dec(total);
x:=find(root,k);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
left[y]:=0;
update(y);
update(x);
splay(y,0);
end;
procedure modify(k,v:longint);
var x,y:longint;
begin
x:=find(root,k+1);
key[x]:=v;
update(x);
splay(x,0);
end;
procedure query(l,r:longint);
var x,y:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
writeln(max[left[y]]);
end;
begin
{assign(input,'gss6.in');
reset(input);}
readln(n);
for i:=1 to n do read(a[i]);
tot:=2;
son[1]:=2; son[2]:=1;
right[1]:=2; fa[2]:=1;
root:=1;
max[0]:=-inf;
lmax[0]:=-inf;
rmax[0]:=-inf;
left[2]:=3;
fa[3]:=2;
tot:=3;
build(3,1,n);
update(1);
update(2);
splay(3,0);
readln(q);
total:=n;
for i:=1 to q do
    begin
    read(ch);
    if ch='I' then
       begin
       read(ch); read(x,y);
       if x-1>total then x:=total+1;
       insert(x-1,y);
       end
    else if ch='D' then
            begin
            read(ch); read(x);

            delete(x);
            end
         else if ch='R' then
                 begin
                 read(ch); read(x,y);
                 modify(x,y);
                 end
              else begin
                   read(ch); read(x,y);
                   query(x,y);
                   end;
    readln;
    end;
//close(input);
end.
