const max=1111111;
var n,cnt:longint;
    ans:qword;
    check:array[0..max]of boolean;
    prime,phi:array[0..max]of longint;
    f,sum:array[0..max]of qword;
procedure init;
var i,j,x,ret:longint;
begin
fillchar(check,sizeof(check),false);
phi[1]:=1; f[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; f[i]:=2*i-1; end;
    for j:=1 to cnt do
        begin
        if qword(prime[j])*qword(i)>qword(max) then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then
           begin
           phi[i*prime[j]]:=phi[i]*prime[j];
           x:=i; ret:=1;
           while x mod prime[j]=0 do
             begin
             ret:=ret*prime[j];
             x:=x div prime[j];
             end;
           f[i*prime[j]]:=qword(prime[j])*f[x]*(f[ret]+qword(phi[ret]));
           break;
           end
        else
           begin
           phi[i*prime[j]]:=phi[i]*(prime[j]-1);
           f[i*prime[j]]:=f[i]*f[prime[j]];
           end;
        end;
    end;
sum[0]:=0;
for i:=1 to max do sum[i]:=sum[i-1]+f[i];
end;
begin
assign(input,'stroll.in');
reset(input);
assign(output,'stroll.out');
rewrite(output);
init;
read(n);
while n<>0 do
  begin
  if n<=1 then begin writeln(0); read(n); continue; end;
  ans:=2*(sum[n]-sum[1])-(qword(2)+qword(n))*qword(n-1) div 2+1;
  ans:=ans-(qword(1)+qword(n))*qword(n) div 2;
  ans:=ans div 2;
  writeln(ans);
  read(n);
  end;
close(input);
close(output);
end.