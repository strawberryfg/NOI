const maxn=200000;
var a,b,xa:array[0..maxn]of longint;
    bit:array[0..maxn]of qword;
    ans:array[0..10]of qword;
    sta:array[0..100]of longint;
    sum:qword;
    n,i,j,cnt:longint;
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
  if b[mid]<x then le:=mid+1
     else if b[mid]>x then ri:=mid-1
             else exit(mid);
  end;
end;
function query(x:longint):qword;
begin
query:=0;
while x>0 do begin query:=query+bit[x]; x:=x-x and -x; end;
end;
procedure modify(x,d:longint);
begin
while x<=cnt do begin bit[x]:=bit[x]+qword(d); x:=x+x and -x; end;
end;
procedure work;
var j,k:longint;
begin
for j:=1 to n-1 do
    begin
    for k:=j+1 to n do
        begin
        if a[j]<a[k] then
           begin
           ans[1]:=ans[1]+query(a[j]-1);
           if a[j]+1<a[k] then ans[3]:=ans[3]+query(a[k]-1)-query(a[j]);
           if a[k]<>cnt then ans[5]:=ans[5]+query(cnt)-query(a[k]);
           end
        else if a[j]>a[k] then
                begin
                ans[2]:=ans[2]+query(a[k]-1);
                if a[k]+1<a[j] then ans[4]:=ans[4]+query(a[j]-1)-query(a[k]);
                if a[j]<>cnt then ans[6]:=ans[6]+query(cnt)-query(a[j]);
                end;
        end;
    modify(a[j],1);
    end;
end;
procedure divide(x,y:qword);
var i:longint; now:qword;
begin
if x=y then
   begin
   write('1.');
   for i:=1 to 20 do write(0);
   writeln;
   exit;
   end;
now:=x;
for i:=1 to 20 do
    begin
    now:=now*qword(10);
    sta[i]:=now div y;
    now:=now mod y;
    end;
write('0.');
for i:=1 to 20 do write(sta[i]);
writeln;
end;
begin
assign(input,'shape.in');
reset(input);
assign(output,'shape.out');
rewrite(output);
readln(n);
for i:=1 to n do read(a[i]);
xa:=a;
sort(1,n);
i:=1; cnt:=0;
while i<=n do
  begin
  j:=i;
  while (j+1<=n)and(a[j+1]=a[i]) do inc(j);
  inc(cnt); b[cnt]:=a[i];
  i:=j+1;
  end;
for i:=1 to n do a[i]:=find(xa[i]);
work;
sum:=0;
for i:=1 to 6 do sum:=sum+ans[i];
for i:=1 to 6 do divide(ans[i],sum);
close(input);
close(output);
end.
