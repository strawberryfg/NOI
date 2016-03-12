const maxn=111111; base=9901;
var n,most,cnt,i,j,ll,rr,ans:longint;
    a,b,w,f,bit:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i);
while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function find(x:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=cnt;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if w[mid]<x then le:=mid+1
     else if w[mid]>x then ri:=mid-1
        else exit(mid);
  end;
end;
function findr(x:longint):longint;  // <=
var le,ri,mid,ans:longint;
begin
le:=1; ri:=cnt;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if w[mid]<=x then begin ans:=mid; le:=mid+1; end
     else ri:=mid-1;
  end;
exit(ans);
end;
function findl(x:longint):longint;  // >=
var le,ri,mid,ans:longint;
begin
le:=1; ri:=cnt;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if w[mid]>=x then begin ans:=mid; ri:=mid-1; end
     else le:=mid+1;
  end;
exit(ans);
end;
procedure modify(x,v:longint);
begin
while x<=cnt do begin bit[x]:=(bit[x]+v) mod base; x:=x+x and -x; end;
end;
function query(x:longint):longint;
var ret:longint;
begin
ret:=0;
while x>0 do begin ret:=(ret+bit[x]) mod base; x:=x-x and -x; end;
exit(ret);
end;
begin
assign(input,'travers.in');
reset(input);
assign(output,'travers.out');
rewrite(output);
read(n,most);
for i:=1 to n do read(b[i]);
a:=b;
sort(1,n);
i:=1; cnt:=0;
while i<=n do
  begin
  j:=i;
  while (j+1<=n)and(a[i]=a[j+1]) do inc(j);
  inc(cnt); w[cnt]:=a[i];
  i:=j+1;
  end;
for i:=1 to n do a[i]:=find(b[i]);
f[1]:=1; modify(a[1],f[1]);
for i:=2 to n do
    begin
    ll:=a[i]; rr:=findr(b[i]+most);
    if ll<=rr then f[i]:=(query(rr)+base-query(ll-1)) mod base;
    ll:=findl(b[i]-most); rr:=a[i]-1;
    if ll<=rr then f[i]:=(f[i]+query(rr)+base-query(ll-1)) mod base;
    f[i]:=(f[i]+1) mod base;
    modify(a[i],f[i]);
    end;
ans:=0;
for i:=1 to n do ans:=(ans+f[i]) mod base;
ans:=(ans+base-n mod base) mod base;
{for i:=1 to n do write(f[i],' ');
writeln;
writeln('-----');}
writeln(ans);
close(input);
close(output);
end.