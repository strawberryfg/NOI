const max=1000200;
var cnt,i,j:longint;
    n,ans,t,x,tmp:qword;
    prime,phi,f,sf:array[0..max]of qword;
    check:array[0..max]of boolean;
begin
{assign(input,'gcdex.in');
reset(input);
assign(output,'gcdex.out');
rewrite(output);}
phi[1]:=1;
cnt:=0;
fillchar(check,sizeof(check),false);
f[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; f[i]:=2*i-1; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>max then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then
           begin
           phi[i*prime[j]]:=phi[i]*prime[j];
           t:=i; x:=1;
           while t mod prime[j]=0 do
              begin
              t:=t div prime[j];
              x:=x*prime[j];
              end;
           f[i*prime[j]]:=f[t]*(prime[j]*f[x]+phi[x*prime[j]]);
           break;
           end
        else
           begin
           phi[i*prime[j]]:=phi[i]*(prime[j]-1);
           f[i*prime[j]]:=f[i]*(2*prime[j]-1);
           end;
        end;
    end;
sf[0]:=0;
for i:=1 to max do sf[i]:=sf[i-1]+f[i];
readln(n);
while n<>0 do
  begin
  tmp:=(n+1)*n div 2;
  ans:=sf[n]-tmp;
  writeln(ans);
  readln(n);
  end;
{close(input);
close(output);}
end.