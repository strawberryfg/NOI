const maxn=3800; base=1000000007;
var n,k:longint;
    com:array[0..maxn,0..maxn]of longint;
    f:array[0..maxn]of qword;
    ans:qword;
procedure init;
var i,j:longint;
begin
for i:=1 to n do begin com[i][0]:=1; com[i][1]:=i; com[i][i-1]:=i; com[i][i]:=1; end;
for i:=2 to n do
    begin
    for j:=2 to i-2 do
        com[i][j]:=(com[i-1][j-1]+com[i-1][j])mod base;
    end;
end;
function pow(x:qword; y:longint):qword;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x mod base;
  x:=x*x mod base;
  y:=y div 2;
  end;
end;
function pow2(x:qword; y:longint):qword;
begin
pow2:=1;
while y>0 do
  begin
  if y mod 2=1 then pow2:=pow2*x mod (base-1);
  x:=x*x mod (base-1);
  y:=y div 2;
  end;
end;
procedure work;
var i,j:longint;
    tmp:qword;
begin
f[1]:=2;
for i:=2 to n do
    begin
    if i<=4 then
       begin
       f[i]:=pow(2,i);
       f[i]:=pow(2,f[i]);
       end
    else
       begin
       f[i]:=pow2(2,i);
       f[i]:=pow(2,f[i]+base-1);
       end;
    for j:=1 to i-1 do
        begin
        tmp:=qword(com[i][j])*f[i-j] mod base;
        f[i]:=(f[i]+base-tmp) mod base;
        end;
    f[i]:=(f[i]+base-2)mod base;
    end;
end;
begin
assign(input,'count.in');
reset(input);
assign(output,'count.out');
rewrite(output);
readln(n,k);
init;
work;
f[0]:=1;
ans:=qword(com[n][k])*f[n-k] mod base;
writeln(ans);
close(input);
close(output);
end.
