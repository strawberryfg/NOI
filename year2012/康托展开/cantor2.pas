const maxn=100;
var n,m,i,j,t,ans:longint;
    fac,d:array[0..maxn]of longint;
begin
assign(input,'cantor2.in');
reset(input);
assign(output,'cantor2.out');
rewrite(output);
readln(n,m);
fac[0]:=1;
for i:=1 to n do fac[i]:=fac[i-1]*i;
ans:=0;
dec(m);
for i:=1 to n do
    begin
    t:=m div fac[n-i];
    inc(t);
    for j:=t downto 1 do
        if d[j]=1 then
           begin
           inc(t);
           while d[t]=1 do inc(t);
           end;
    d[t]:=1;
    ans:=ans*10+t;
    m:=m mod fac[n-i];
    end;
writeln(ans);
close(input);
close(output);
end.
