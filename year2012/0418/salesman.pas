const maxn=500200; maxdate=502000; inf=100000000;
type rec=record max:longint; end;
var n,u,d,s,i,j,k,x,res:longint;
    t,p,v,f,fd,fu,a,b,bel,sta:array[0..maxn]of longint;
    tree:array[1..2,0..4*maxn]of rec;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure sort(l,r: longint);
var i,j,x,y,tmp: longint;
begin
i:=l; j:=r; x:=t[(l+r) div 2]; y:=p[(l+r)div 2];
repeat
while (t[i]<x)or((t[i]=x)and(p[i]<y)) do inc(i);
while (x<t[j])or((x=t[j])and(y<p[j])) do dec(j);
if not(i>j) then
   begin
   tmp:=t[i]; t[i]:=t[j]; t[j]:=tmp;
   tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
   tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp;
   tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
   inc(i); dec(j);
   end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r: longint);
var i,j,x,tmp: longint;
begin
i:=l; j:=r; x:=sta[(l+r) div 2];
repeat
while sta[i]<x do inc(i);
while x<sta[j] do dec(j);
if not(i>j) then
   begin
   tmp:=sta[i]; sta[i]:=sta[j]; sta[j]:=tmp;
   tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp;
   inc(i); dec(j);
   end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
procedure init(f,t,x:longint);
begin
tree[1][x].max:=-inf; tree[2][x].max:=-inf;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure modify(f,t,v,x,opt,l,r:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   tree[opt][x].max:=v;
   exit;
   end;
mid:=(l+r)div 2;
if f<=mid then modify(f,t,v,x*2,opt,l,mid);
if t>mid then modify(f,t,v,x*2+1,opt,mid+1,r);
tree[opt][x].max:=max(tree[opt][x*2].max,tree[opt][x*2+1].max);
end;
function query(f,t,x,opt,l,r:longint):longint;
var a,b,mid:longint;
begin
mid:=(l+r)div 2;
if (f<=l)and(r<=t) then exit(tree[opt][x].max)
   else  begin
         if f<=mid then a:=query(f,t,x*2,opt,l,mid) else a:=-inf;
         if t>mid then b:=query(f,t,x*2+1,opt,mid+1,r) else b:=-inf;
         query:=max(a,b);
         end;
end;
begin
assign(input,'salesman.in');
reset(input);
assign(output,'salesman.out');
rewrite(output);
readln(n,u,d,s);
for i:=1 to n do readln(t[i],p[i],v[i]);
for i:=1 to n+1 do a[i]:=i;
b:=a;
sta:=p;
sta[n+1]:=s;
p[n+1]:=s;
v[n+1]:=0;
t[n+2]:=-1;
f[0]:=0;
sort(1,n);
sort2(1,n+1);
for i:=1 to n+1 do bel[b[i]]:=i;
for i:=1 to n+1 do f[i]:=-inf;
init(1,n+1,1);
modify(bel[n+1],bel[n+1],0+d*s,1,1,1,n+1);
modify(bel[n+1],bel[n+1],0-u*s,1,2,1,n+1);
i:=1;
while i<=n+1 do
  begin
  j:=i;
  while (j<=n+1) do
     begin
     x:=bel[a[j]];
     res:=-inf;
     if x-1>=1 then
        res:=query(1,x-1,1,1,1,n+1);
     if res<>-inf then
        f[j]:=max(f[j],res-d*p[j]+v[j]);
     res:=-inf;
     if x+1<=n+1 then
        res:=query(x+1,n+1,1,2,1,n+1);
     if res<>-inf then
        f[j]:=max(f[j],res+u*p[j]+v[j]);
     if t[j]<>t[j+1] then break;
     inc(j);
     end;
  fu[j]:=f[j];
  for k:=j-1 downto i do
      fu[k]:=max(f[k],fu[k+1]+v[k]-u*(p[k+1]-p[k]));
  fd[i]:=f[i];
  for k:=i+1 to j do
      fd[k]:=max(f[k],fd[k-1]+v[k]-d*(p[k]-p[k-1]));
  for k:=i to j do
      begin
      f[k]:=max(fu[k],fd[k]);
      if f[k]<>-inf then
         begin
         modify(bel[a[k]],bel[a[k]],f[k]+d*p[k],1,1,1,n+1);
         modify(bel[a[k]],bel[a[k]],f[k]-u*p[k],1,2,1,n+1);
         end;
      end;
  i:=j+1;
  end;
if f[n+1]<0 then f[n+1]:=0;
writeln(f[n+1]);
close(input);
close(output);
end.
