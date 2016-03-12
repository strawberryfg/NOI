const maxprime=500020; base=1000003;
var cnt,test,now,i,j,a,b,g,n:longint;
    std,ans:qword;
    prime:array[0..maxprime]of longint;
    pow:array[0..2*maxprime]of longint;
    phi:array[0..maxprime]of longint;
    check:array[0..maxprime]of boolean;
function gcd(a,b:longint):longint;
begin
if b=0 then exit(a)
   else exit(gcd(b,a mod b));
end;
function quick(a,b:longint):qword;
begin
std:=a;
quick:=1;
while b>0 do
  begin
  if b mod 2=1 then quick:=quick*std mod base;
  std:=std*std mod base;
  b:=b div 2;
  end;
end;
begin
{assign(input,'transposing.in');
reset(input);
assign(output,'transposing.out');
rewrite(output);}
readln(test);
phi[1]:=1;
fillchar(check,sizeof(check),false);
cnt:=0;
for i:=2 to maxprime do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>maxprime then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then
           begin
           phi[i*prime[j]]:=phi[i]*prime[j];
           break;
           end
        else
           phi[i*prime[j]]:=phi[i]*(prime[j]-1);
        end;
    end;
pow[0]:=1;
for i:=1 to 2*maxprime do pow[i]:=pow[i-1]*2 mod base;
for now:=1 to test do
    begin
    readln(a,b);
    if (a=0)and(b=0) then begin writeln(0); continue; end;
    g:=gcd(a,b);
    n:=(a+b)div g;
    ans:=0;
    for i:=1 to trunc(sqrt(n)) do
        begin
        if n mod i=0 then
           begin
           ans:=(ans+phi[n div i]*quick(pow[g],i) mod base)mod base;
           if i*i<>n then
              ans:=(ans+phi[i]*quick(pow[g],n div i) mod base)mod base;
           end;
        end;
    ans:=ans*quick(n,base-2) mod base;
    ans:=(qword(pow[a+b])+base-ans) mod base;
    writeln(ans);
    end;
{close(input);
close(output);}
end.