const maxn=320; eps=1e-12;
var h,smaller:array[0..maxn]of longint;
    i,n,cnt,j,k:longint;
    ans:extended;
    f:array[0..maxn,0..maxn]of extended;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=h[(l+r) div 2];
repeat
while h[i]<x do inc(i);
while x<h[j] do dec(j);
if not(i>j) then begin y:=h[i]; h[i]:=h[j]; h[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function p(x,y:longint):extended;
begin
exit(f[x][y]);
end;
begin
assign(input,'queue.in');
reset(input);
assign(output,'queue.out');
rewrite(output);
readln(n);
for i:=1 to n do read(h[i]);
for i:=0 to n do f[i][0]:=1;
for i:=1 to n do
    for j:=1 to i do
        begin
        f[i][j]:=1.0;
        for k:=1 to j do
            f[i][j]:=f[i][j]*(i+1-k);
        end;
sort(1,n);
cnt:=0;
for i:=1 to n do
    begin
    if h[i]<>h[i-1] then cnt:=i-1;
    smaller[i]:=cnt;
    end;
ans:=0;
for i:=1 to n do
    begin
    for j:=1 to smaller[i]+1 do  //view
        begin
        ans:=ans+j*p(smaller[i],j-1)*p(n-j,n-j)/p(n,n);
        if (j+1<=n)and(n-1-j>=0) then
            ans:=ans+j*(n-j)*p(smaller[i],j-1)*(n-smaller[i]-1)*p(n-1-j,n-1-j)/p(n,n);
        end;
    end;
writeln(round(ans*100)/100:0:2);
close(input);
close(output);
end.
