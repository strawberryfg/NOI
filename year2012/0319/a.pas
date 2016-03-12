const maxn=5020;
var a,b,c:array[0..maxn]of longint;
    n,m,i,j,k,u,tot,sum:longint;
procedure sort(l,r: longint);
var i,j,x,tmp: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]>x do inc(i);
while x>a[j] do dec(j);
if not(i>j) then begin tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
begin
assign(input,'a.in');
reset(input);
assign(output,'a.out');
rewrite(output);
readln(n,m);
for i:=1 to n do read(a[i]);
for i:=1 to m do begin read(b[i]); sum:=sum+b[i]; end;
sort(1,n);
for i:=1 to m do
    begin
    for j:=1 to b[i] do a[j]:=a[j]-1;
    if b[i]=0 then continue;
    j:=1;
    k:=b[i]+1;
    tot:=0;
    while (j<=b[i])and(k<=n) do
      begin
      if a[k]>=a[j] then begin inc(tot); c[tot]:=a[k]; inc(k); end
         else begin inc(tot); c[tot]:=a[j]; inc(j); end;
      end;
    if j<=b[i] then for u:=j to b[i] do begin inc(tot); c[tot]:=a[u]; end;
    if k<=n then for u:=k to n do begin inc(tot); c[tot]:=a[u]; end;
    a:=c;
    end;
for i:=1 to n do if a[i]>0 then sum:=sum+a[i];
writeln(sum);
close(input);
close(output);
end.