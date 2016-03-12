const maxn=300200;
var n,m,cnt,ans,l,r,i,j:longint;
    a,b,id,st,en:array[0..maxn]of longint;
    tree:array[0..4*maxn]of longint;
procedure sort(l,r: longint);
var i,j,cmpb,cmpid,swap: longint;
begin
i:=l; j:=r; cmpb:=b[(l+r) div 2]; cmpid:=id[(l+r)div 2];
repeat
while (b[i]<cmpb)or((b[i]=cmpb)and(id[i]<cmpid)) do inc(i);
while (cmpb<b[j])or((cmpb=b[j])and(cmpid<id[j])) do dec(j);
if not(i>j) then begin swap:=b[i]; b[i]:=b[j]; b[j]:=swap; swap:=id[i]; id[i]:=id[j]; id[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function check(v,l,r:longint):boolean;
var le,ri,mid,ans1,ans2:longint;
begin
le:=st[v]; ri:=en[v]; ans1:=-1;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if (id[mid]>=l) then begin ans1:=mid; ri:=mid-1; end
     else le:=mid+1;
  end;
if ans1=-1 then exit(false);
le:=st[v]; ri:=en[v]; ans2:=-1;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if (id[mid]<=r) then begin ans2:=mid; le:=mid+1; end
     else ri:=mid-1;
  end;
if ans2=-1 then exit(false);
if ans2-ans1+1>(r-l+1)div 2 then exit(true);
exit(false);
end;
procedure init(l,r,x:longint);
begin
if l=r then begin tree[x]:=a[l]; exit; end;
init(l,(l+r)div 2,x*2);
init((l+r)div 2+1,r,x*2+1);
if tree[x*2]<>0 then
   if check(tree[x*2],l,r) then
      tree[x]:=tree[x*2];
if tree[x*2+1]<>0 then
   if check(tree[x*2+1],l,r) then
      tree[x]:=tree[x*2+1];
end;
procedure query(l,r,f,t,x:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   if check(tree[x],f,t) then ans:=tree[x];
   exit;
   end;
mid:=(l+r) div 2;
if f<=mid then query(l,mid,f,t,x*2);
if ans<>0 then exit;
if t>mid then query(mid+1,r,f,t,x*2+1);
end;
begin
{assign(input,'j.in');
reset(input);
assign(output,'j.out');
rewrite(output);}
readln(n,cnt);
for i:=1 to n do read(a[i]);
b:=a;
for i:=1 to n do id[i]:=i;
sort(1,n);
i:=1;
while i<=n do
  begin
  j:=i;
  while (j+1<=n)and(b[j+1]=b[i]) do inc(j);
  st[b[i]]:=i; en[b[i]]:=j;
  i:=j+1;
  end;
init(1,n,1);
readln(m);
for i:=1 to m do
    begin
    readln(l,r);
    ans:=0;
    query(1,n,l,r,1);
    if ans=0 then writeln('no')
       else writeln('yes ',ans);
    end;
{close(input);
close(output);}
end.