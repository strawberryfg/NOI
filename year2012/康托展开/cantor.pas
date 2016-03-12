const maxn=100;
var n,i,j,res,ans:longint;
    a,fac:array[0..maxn]of longint;
begin
assign(input,'cantor.in');
reset(input);
assign(output,'cantor.out');
rewrite(output);
readln(n);
for i:=1 to n do read(a[i]);
fac[0]:=1;
for i:=1 to n do fac[i]:=fac[i-1]*i;
ans:=0;
for i:=1 to n-1 do
    begin
    res:=0;
    for j:=i+1 to n do if a[j]<a[i] then inc(res);
    ans:=ans+fac[n-i]*res;
    end;
inc(ans);
writeln(ans);
close(input);
close(output);
end.
