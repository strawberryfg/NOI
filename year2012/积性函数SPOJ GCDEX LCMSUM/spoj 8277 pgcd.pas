const max=11111111;
var now,test,n,m,j,cnt:longint;
    prime,sum,mu:array[0..max]of longint;
    check:array[0..max]of boolean;
    ans:int64;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure init;
var i,j:longint;
begin
fillchar(check,sizeof(check),false);
mu[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; mu[i]:=-1; end;
    for j:=1 to cnt do
        begin
        if qword(i)*qword(prime[j])>qword(max) then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then begin mu[i*prime[j]]:=0; break; end
           else mu[i*prime[j]]:=-mu[i];
        end;
    end;
sum[0]:=0;
for i:=1 to max do sum[i]:=sum[i-1]+mu[i];
end;
function work(x,y:longint):qword;
var i,t1,t2,p1,p2,up,t:longint; ret:int64;
begin
up:=min(x,y);
i:=1; ret:=0;
while i<=up do
  begin
  t1:=x div i; p1:=x div t1;
  t2:=y div i; p2:=y div t2;
  t:=min(up,min(p1,p2));
  ret:=ret+qword(t1)*qword(t2)*int64(sum[t]-sum[i-1]);
  i:=t+1;
  end;
exit(ret);
end;
begin
{assign(input,'pgcd.in');
reset(input);
assign(output,'pgcd.out');
rewrite(output);}
read(test);
init;
for now:=1 to test do
    begin
    read(n,m); ans:=0;
    for j:=1 to cnt do
        begin
        if (prime[j]>n)or(prime[j]>m) then break;
        ans:=ans+work(n div prime[j],m div prime[j]);
        end;
    writeln(ans);
    end;
{close(input);
close(output);}
end.