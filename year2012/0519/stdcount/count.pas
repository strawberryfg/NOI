const maxn=1000020; base=1000000007;
var n,k,i:longint;
    g,c,h:array[0..maxn]of qword;
    ans:qword;
function pow(x:qword; y:longint):qword; inline;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x mod base;
  x:=x*x mod base;
  y:=y div 2;
  end;
end;
procedure work(x:longint); inline;
var i:longint;
begin
c[0]:=1;
for i:=1 to x do
    begin
    c[i]:=c[i-1]*(x+1-i) mod base;
    c[i]:=c[i]*h[i] mod base;
    end;
end;
begin
assign(input,'count.in');
reset(input);
assign(output,'count.out');
rewrite(output);
readln(n,k);
g[0]:=2;
g[1]:=4;
for i:=1 to n do
    h[i]:=pow(i,base-2);
for i:=2 to n-k do
    g[i]:=g[i-1]*g[i-1] mod base;
work(n-k);
ans:=g[n-k];
for i:=1 to n-k do
    begin
    if i mod 2=1 then
       ans:=(ans+base-c[i]*g[n-k-i] mod base) mod base
    else
       ans:=(ans+c[i]*g[n-k-i] mod base) mod base;
    end;
work(n);
ans:=ans*c[k] mod base;
writeln(ans);
close(input);
close(output);
end.