const maxn=1000000; inf=maxlongint;
var n,m,k,i,j,fmin,max,ans,v,le,ri,mid,tmp:longint;
    ll,rr,h,left,right,a,b,sa,sb:array[0..maxn]of int64;
    s:array[0..maxn]of char;
    res:int64;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure sort1(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i);
while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort1(l,j);
if i<r then sort1(i,r);
end;
procedure sort2(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=b[(l+r) div 2];
repeat
while b[i]<x do inc(i);
while x<b[j] do dec(j);
if not(i>j) then begin y:=b[i]; b[i]:=b[j]; b[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
begin
assign(input,'cover.in');
reset(input);
assign(output,'cover.out');
rewrite(output);
readln(n,m,k);
for i:=1 to n do read(s[i]);
fmin:=inf;
for i:=1 to m do
    begin
    readln(ll[i],rr[i]);
    if rr[i]-ll[i]<fmin then fmin:=rr[i]-ll[i];
    end;
a:=ll; b:=rr;
sort1(1,m);
sort2(1,m);
for i:=1 to m do sa[i]:=sa[i-1]+a[i];
for i:=1 to m do sb[i]:=sb[i-1]+b[i];
for i:=1 to n do
    begin
    le:=1; ri:=m;
    tmp:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if a[mid]<=i then le:=mid+1
         else begin
              tmp:=mid;
              ri:=mid-1;
              end;
      end;
    if tmp=-1 then res:=0
       else begin
            res:=int64(i)*int64(m-tmp+1);
            res:=sa[m]-sa[tmp-1]-res;
            end;
    left[i]:=res;
    le:=1; ri:=m;
    tmp:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if b[mid]<i then begin le:=mid+1; tmp:=mid; end
         else ri:=mid-1;
      end;
    if tmp=-1 then res:=0
       else res:=int64(i)*int64(tmp)-sb[tmp];
    right[i]:=res;
    end;
ans:=0;
j:=1;
fillchar(h,sizeof(h),0);
h[ord(s[1])]:=1;
inc(fmin);
for i:=1 to n do
    begin
    if i>1 then dec(h[ord(s[i-1])]);
    while (j+1<=n)and(j+1-i+1<=fmin)and(left[i]+right[j+1]<=k)do
       begin
       inc(j);
       inc(h[ord(s[j])]);
       end;
    if (left[i]+right[j]<=k)and(j-i+1<=fmin) then
       begin
       max:=0;
       for v:=1 to 26 do
           if h[96+v]>max then
              max:=h[96+v];
       if max>ans then
          begin
          ans:=max;
          if ans=1930 then
             writeln(i,',',j);
          end;
       end;
    if i=j then
       begin
       inc(j);
       inc(h[ord(s[j])]);
       end;
    end;
writeln(ans);
close(input);
close(output);
end.
