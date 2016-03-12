const maxa=1500; maxb=51; base=1000000007; base2=2000000014;
var n,m,k,ans:longint;
    c:array[0..maxa,0..maxb]of longint;
    f:array[-5..maxb,-5..maxb]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure init;
var i,j:longint;
begin
c[0][0]:=1;
for i:=1 to maxa do
    begin
    c[i][0]:=1; c[i][1]:=i;
    for j:=2 to maxb do
        c[i][j]:=(c[i-1][j-1]+c[i-1][j]) mod base;
    end;
end;
function pow(x,step:longint):longint;
var ret:longint;
begin
ret:=1;
while step>0 do
  begin
  if step mod 2=1 then ret:=qword(ret)*qword(x) mod base;
  step:=step div 2; if step=0 then break;
  x:=qword(x)*qword(x) mod base; 
  end;
exit(ret);
end;
function dp(x,y:longint):longint;
var tmp,ret,t,u,v:longint;
begin
if y>x*(x-1) div 2 then exit(0);
if f[x][y]<>0 then exit(f[x][y]);
if x=1 then exit(1);
if y<x-1 then exit(0);
ret:=c[x*(x-1) div 2][y];
for u:=1 to x-1 do
    for v:=u-1 to min(y,u*(u-1) div 2) do
        begin
        tmp:=qword(dp(u,v))*qword(c[x-1][u-1]) mod base;
        t:=(x-u)*(x-u-1) div 2;
        tmp:=qword(tmp)*qword(c[t][y-v]) mod base;
        ret:=(ret+base-tmp) mod base;
        end;
f[x][y]:=ret;
exit(ret);
end;
procedure solve0;
begin
ans:=dp(n,k);
writeln(ans);
end;
function solve1(n,k:longint):longint;
var u,v,tmp,ret,ans:longint;
begin
ans:=qword(dp(n-1,k-2))*qword(c[n-1][2]) mod base;
ret:=0;
for u:=1 to n-2 do
    for v:=u-1 to u*(u-1) div 2 do
        begin
        if k-2-v<0 then break;
        tmp:=qword(dp(u,v))*qword(dp(n-1-u,k-2-v)) mod base;
        tmp:=qword(tmp)*qword(u) mod base*qword(n-1-u) mod base;
        tmp:=qword(tmp)*qword(c[n-1][u]) mod base;
        ret:=(qword(ret)+qword(tmp)) mod base;
        end;
ret:=qword(ret)*qword(pow(2,base-2)) mod base;
ans:=(ans+ret) mod base;
exit(ans);
end;
procedure solve2;
var u,v,tmp,ret:longint;
begin
ret:=0; ans:=0;
for u:=1 to n-3 do
    for v:=u-1 to u*(u-1) div 2 do
        begin
        if k-3-v<0 then break;
        tmp:=qword(dp(u,v))*qword(dp(n-2-u,k-3-v)) mod base;
        tmp:=qword(tmp)*qword(u) mod base*qword(n-2-u) mod base;
        tmp:=qword(tmp)*qword(c[n-2][u]) mod base;
        ret:=(qword(ret)+qword(tmp)) mod base;
        end;
ans:=(ans+ret) mod base;
ret:=0;
for u:=1 to n-2 do
    for v:=u-1 to u*(u-1) div 2 do
        begin
        if k-2-v<0 then break;
        tmp:=qword(solve1(u,v))*qword(dp(n-1-u,k-2-v)) mod base;
        tmp:=qword(tmp)*qword(u-1) mod base*qword(n-1-u) mod base;
        tmp:=qword(tmp)*qword(c[n-2][u-1]) mod base;
        ret:=(qword(ret)+qword(tmp)) mod base;
        end;
ans:=(ans+ret) mod base;
ret:=0;
ret:=qword(dp(n-2,k-3))*qword(n-2) mod base*qword(n-2) mod base;
ans:=(ans+ret) mod base;
ret:=0;
ret:=qword(solve1(n-1,k-2))*qword(c[n-2][2]) mod base;
ans:=(ans+ret) mod base;
writeln(ans);
end;
begin
assign(input,'kingdomandcities.in');
reset(input);
assign(output,'kingdomandcities.out');
rewrite(output);
readln(n,m,k);
init;
if m=0 then solve0
   else if m=1 then begin ans:=solve1(n,k); writeln(ans); end
           else solve2;
close(input);
close(output);
end.