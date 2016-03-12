//21:51;
const maxn=1000200; inf=maxlongint;
var root,tot,n,m,i,j,x,y,st,l,r,t,c,cnt,u,kind,top,now:longint;
    lmax,rmax,max,sum,left,right,son,fa:array[0..maxn]of longint;
    rev,key,a:array[0..maxn]of longint;
    flag:array[0..maxn]of boolean;
    ch:char;
    p:array[0..4*maxn]of longint;
function getmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure update(x:longint);
var t1,t2,t:longint;
begin
if x=0 then exit;
son[x]:=son[left[x]]+son[right[x]]+1;
sum[x]:=sum[left[x]]+sum[right[x]]+key[x];
lmax[x]:=getmax(lmax[left[x]],sum[left[x]]+key[x]+getmax(lmax[right[x]],0));
rmax[x]:=getmax(rmax[right[x]],sum[right[x]]+key[x]+getmax(rmax[left[x]],0));
max[x]:=getmax(max[left[x]],max[right[x]]);
max[x]:=getmax(max[x],key[x]);
t1:=rmax[left[x]]; if t1=-inf then t1:=0;
t2:=lmax[right[x]]; if t2=-inf then t2:=0;
max[x]:=getmax(max[x],key[x]+t1+t2);
t:=getmax(rmax[left[x]],lmax[right[x]]);
if t<>-inf then max[x]:=getmax(max[x],key[x]+t);
end;
procedure lazydown(x:longint);
var tmp:longint;
begin
if x=0 then exit;
if rev[x]<>0 then
   begin
   if left[x]<>0 then rev[left[x]]:=1-rev[left[x]];
   if right[x]<>0 then rev[right[x]]:=1-rev[right[x]];
   rev[x]:=0;
   tmp:=left[x]; left[x]:=right[x]; right[x]:=tmp;
   tmp:=lmax[x]; lmax[x]:=rmax[x]; rmax[x]:=tmp;
   end;
if flag[x] then
   begin
   if left[x]<>0 then
      begin
      flag[left[x]]:=true;
      key[left[x]]:=key[x];
      end;
   if right[x]<>0 then
      begin
      flag[right[x]]:=true;
      key[right[x]]:=key[x];
      end;
   if key[x]<0 then
      begin
      lmax[x]:=key[x]; rmax[x]:=key[x]; max[x]:=key[x];
      end
   else
      begin
      lmax[x]:=key[x]*son[x]; rmax[x]:=key[x]*son[x]; max[x]:=key[x]*son[x];
      end;
   sum[x]:=key[x]*son[x];
   flag[x]:=false;
   end
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
lazydown(y);
lazydown(x);
lazydown(right[y]);
lazydown(left[x]);
lazydown(right[x]);
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
fa[x]:=fa[y];
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[y]:=x;
right[x]:=y;
update(y);
update(x);
end;
procedure clear(var x:longint);
begin
if x=0 then exit;
inc(top);
p[top]:=x;
clear(left[x]);
clear(right[x]);
x:=0;
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
lazydown(y);
lazydown(x);
lazydown(left[y]);
lazydown(left[x]);
lazydown(right[x]);
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
fa[x]:=fa[y];
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[y]:=x;
left[x]:=y;
update(y);
update(x);
end;
function find(x,remain:longint):longint;
begin
lazydown(x);
if son[left[x]]>=remain then exit(find(left[x],remain))
   else if son[left[x]]+1=remain then exit(x)
           else exit(find(right[x],remain-1-son[left[x]]));
end;
procedure splay(x,y:longint);
begin
//lazydown(x);
while fa[x]<>y do
  begin
  if fa[fa[x]]=y then
     begin
     if x=left[fa[x]] then rightrotate(x)
        else leftrotate(x)
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
           end
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
procedure delete;
var x,y:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
clear(left[y]);
left[y]:=0;
splay(y,0);
end;
procedure modify;
var x,y:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
flag[left[y]]:=true;
key[left[y]]:=c;
splay(left[y],0);
end;
procedure reverse;
var x,y:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
rev[left[y]]:=1-rev[left[y]];
splay(left[y],0);
end;
procedure insert(k,v:longint);
var x,y,now:longint;
begin
x:=find(root,k+1);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
if top>0 then begin now:=p[top]; dec(top); end
   else begin inc(tot); now:=tot; end;
left[y]:=now;
fa[now]:=y;
lmax[now]:=v; rmax[now]:=v; max[now]:=v; son[now]:=1;
sum[now]:=v; flag[now]:=false; key[now]:=v;
rev[now]:=0; left[now]:=0; right[now]:=0;
update(y);
update(x);
splay(now,0);
end;
procedure build(x,l,r:longint);
var v,now:longint;
begin
key[x]:=a[(l+r)div 2];
flag[x]:=false; rev[x]:=0;
son[x]:=1;
if l=r then
   begin
   now:=x;
   v:=a[l];
   lmax[now]:=v; rmax[now]:=v; max[now]:=v; son[now]:=1;
   sum[now]:=v; flag[now]:=false; key[now]:=v;
   rev[now]:=0; left[now]:=0; right[now]:=0;
   exit;
   end;
if l<=(l+r)div 2-1 then
   begin
   if top>0 then begin now:=p[top]; dec(top); end
      else begin inc(tot); now:=tot; end;
   left[x]:=now;
   fa[now]:=x;
   build(now,l,(l+r)div 2-1);
   end;
if (l+r)div 2+1<=r then
   begin
   if top>0 then begin now:=p[top]; dec(top); end
      else begin inc(tot); now:=tot; end;
   right[x]:=now;
   fa[now]:=x;
   build(now,(l+r)div 2+1,r);
   end;
update(x);
end;
procedure query(ind:longint);
var x,y:longint;
begin
if ind=1 then
   begin
   x:=find(root,l);
   y:=find(root,r+2);
   end
else begin x:=1; y:=2; end;
splay(x,0);
splay(y,x);
if ind=1 then writeln(sum[left[y]]) else writeln(max[left[y]]);
end;
begin
assign(input,'sequence.in');
reset(input);
assign(output,'sequence.out');
rewrite(output);
kind:=1;
for u:=1 to kind do
begin
top:=0;
readln(n,m);
root:=1;
lmax[0]:=-inf; rmax[0]:=-inf; max[0]:=-inf;
fa[2]:=1; right[1]:=2; son[1]:=2; son[2]:=1;
flag[1]:=false; flag[2]:=false;
for i:=1 to n do begin read(a[i]); end;
tot:=3;
fa[3]:=2;
left[2]:=3;
build(3,1,n);
splay(3,0);
readln;
for i:=1 to m do
    begin
    read(ch);
    if ch='I' then
       begin
       for j:=1 to 6 do read(ch);
       read(x); read(cnt); st:=x;
       for j:=1 to cnt do
           begin
           read(a[j]);
           end;
       x:=find(root,st+1);
       y:=find(root,st+2);
       splay(x,0);
       splay(y,x);
       if top>0 then begin now:=p[top]; dec(top); end
          else begin inc(tot); now:=tot; end;
       left[y]:=now; fa[now]:=y;
       build(now,1,cnt);
       update(y);
       update(x);
       splay(now,0);
       end
    else if ch='D' then
            begin
            for j:=1 to 6 do read(ch);
            read(l,r); r:=l+r-1;
            delete;
            end
         else if ch='M' then
                 begin
                 read(ch); read(ch);
                 if ch='K' then
                    begin
                    for j:=1 to 7 do read(ch);
                    read(l,r,c); r:=l+r-1;
                    modify;
                    end
                 else
                    begin
                    for j:=1 to 4 do read(ch);
                    query(2);
                    end;
                 end
              else if ch='R' then
                      begin
                      for j:=1 to 7 do read(ch);
                      read(l,r); r:=l+r-1;
                      reverse;
                      end
                   else if ch='G' then
                           begin
                           for j:=1 to 7 do read(ch);
                           read(l,r); r:=l+r-1;
                           query(1);
                           end;
    readln;
    end;
end;
close(input);
close(output);
end.
