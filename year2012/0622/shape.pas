const maxn=200000;
var a,b,xa:array[0..maxn]of longint;
    bit,bit2,qx,qd,hx,hd:array[0..maxn]of qword;
    ans:array[0..10]of qword;
    sta:array[0..100]of longint;
    sum:qword;
    n,i,j,cnt:longint;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i); while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j); if i<r then sort(i,r);
end;
function find(x:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=cnt;
while le<=ri do begin mid:=(le+ri) div 2; if b[mid]<x then le:=mid+1 else if b[mid]>x then ri:=mid-1 else exit(mid); end;
end;
procedure init;
begin
fillchar(bit,sizeof(bit),0);
fillchar(bit2,sizeof(bit2),0);
end;
function query(x:longint):qword;
begin
query:=0;
while x>0 do begin query:=query+bit[x]; x:=x-x and -x; end;
end;
procedure modify(x:longint);
begin
while x<=cnt do begin bit[x]:=bit[x]+qword(1); x:=x+x and -x; end;
end;
function query2(x:longint):qword;
begin
query2:=0;
while x>0 do begin query2:=query2+bit2[x]; x:=x-x and -x; end;
end;
procedure modify2(x:longint;d:qword);
begin
while x<=cnt do begin bit2[x]:=bit2[x]+qword(d); x:=x+x and -x; end;
end;
procedure workqian;
var i:longint;
begin
init; for i:=1 to n do begin qx[i]:=query(a[i]-1); qd[i]:=query(cnt)-query(a[i]); modify(a[i]); end;
end;
procedure workhou;
var i:longint;
begin
init; for i:=n downto 1 do begin hx[i]:=query(a[i]-1); if a[i]<>cnt then hd[i]:=query(cnt)-query(a[i]); modify(a[i]); end;
end;
procedure work;
var i:longint; res,res2:qword;
begin
//1:
ans[1]:=0;
for i:=2 to n-1 do ans[1]:=ans[1]+qx[i]*hd[i];
ans[6]:=0;
//6:
for i:=2 to n-1 do ans[6]:=ans[6]+qd[i]*hx[i];
//2:
init;
ans[2]:=0;
for i:=n downto 1 do
    begin
    res:=query(cnt)-query(a[i]);
    if res<>0 then
       begin
       res:=res*(res-1) div 2;
       res2:=query2(cnt)-query2(a[i]);
       res:=res-res2;
       ans[2]:=ans[2]+res;
       end;
    modify2(a[i],query(a[i])-query(a[i]-1));
    modify(a[i]);
    end;
ans[2]:=ans[2]-ans[1];
init;
ans[5]:=0;
for i:=n downto 1 do
    begin
    res:=query(a[i]-1);
    if res<>0 then
       begin
       res:=res*(res-1) div 2;
       res2:=query2(a[i]-1);
       res:=res-res2;
       ans[5]:=ans[5]+res;
       end;
    modify2(a[i],query(a[i])-query(a[i]-1));
    modify(a[i]);
    end;
ans[5]:=ans[5]-ans[6];
init;
ans[4]:=0;
for i:=1 to n do
    begin
    res:=query(cnt)-query(a[i]);
    if res<>0 then
       begin
       res:=res*(res-1) div 2;
       res2:=query2(cnt)-query2(a[i]);
       res:=res-res2;
       ans[4]:=ans[4]+res;
       end;
    modify2(a[i],query(a[i])-query(a[i]-1));
    modify(a[i]);
    end;
ans[4]:=ans[4]-ans[6];
init;
ans[3]:=0;
for i:=1 to n do
    begin
    res:=query(a[i]-1);
    if res<>0 then
       begin
       res:=res*(res-1) div 2;
       res2:=query2(a[i]-1);
       res:=res-res2;
       ans[3]:=ans[3]+res;
       end;
    modify2(a[i],query(a[i])-query(a[i]-1));
    modify(a[i]);
    end;
ans[3]:=ans[3]-ans[1];
end;
procedure divide(x,y:qword);
var i:longint; now:qword;
begin
if x=y then begin write('1.'); for i:=1 to 20 do write(0); writeln; exit; end;
now:=x;
for i:=1 to 20 do begin now:=now*qword(10); sta[i]:=now div y; now:=now mod y; end;
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
workqian;
workhou;
work;
sum:=0;
for i:=1 to 6 do sum:=sum+ans[i];
for i:=1 to 6 do divide(ans[i],sum);
close(input);
close(output);
end.