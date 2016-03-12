const maxm=5000; maxn=10010; inf=maxlongint;
var test,now,n,m,i,j,len,l,r,k,res:longint;
    a:array[0..maxn]of longint;
    f,s:array[0..maxm+5,0..maxn] of longint;
function min(x,y:longint):longint;
begin
if x<y then min:=x else min:=y;
end;
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
begin
{assign(input,'division.in');
reset(input);
assign(output,'e:\wqf\division.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    readln(n,m);
    for i:=1 to n do read(a[i]);
    sort(1,n);
    for i:=0 to m do for j:=1 to n do f[i][j]:=inf;
    f[0][0]:=0;
    for i:=1 to m+1 do for j:=1 to n do s[i][j]:=inf;
    for i:=1 to m do f[i][i]:=0;
    for len:=1 to n-m do
        begin
        for i:=1 to min(m,n-len) do
            begin
            l:=s[i][i+len-1]; if l=inf then l:=i-1;
            r:=s[i+1][i+len]; if r=inf then r:=i+len-1;
            for k:=l to r do
                begin
                if f[i-1][k]=inf then continue;
                res:=f[i-1][k]+(a[i+len]-a[k+1])*(a[i+len]-a[k+1]);
                if res<=f[i][i+len] then
                   begin
                   f[i][i+len]:=res;
                   s[i][i+len]:=k;
                   end;
                end;
            end;
        end;
    writeln('Case ',now,': ',f[m][n]);
    end;
{close(input);
close(output);}
end.