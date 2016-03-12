const max=1111111;
var n,i,cnt:longint;
    check:array[0..max]of boolean;
    prime,phi:array[0..max]of longint;
    f:array[0..max]of qword;
    ans:qword;
procedure init;
var i,j:longint; x,tmp,t,res:qword;
begin
fillchar(check,sizeof(check),false); cnt:=0; phi[1]:=1; f[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; f[i]:=qword(i)*qword(i)*qword(i)-qword(i)*qword(i)+qword(i); end;
    for j:=1 to cnt do
        begin
        if qword(prime[j])*qword(i)>qword(max) then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then
           begin
           phi[i*prime[j]]:=phi[i]*prime[j];
           x:=i; res:=1;
           while x mod prime[j]=0 do
             begin
             x:=x div prime[j]; res:=res*prime[j];
             end;
           t:=res;
           tmp:=qword(prime[j])*f[res]+t*t*t*qword(prime[j])*qword(prime[j])*qword(prime[j]-1);
           f[i*prime[j]]:=f[x]*tmp;
           break;
           end
        else
           begin
           phi[i*prime[j]]:=phi[i]*(prime[j]-1);
           f[i*prime[j]]:=f[i]*f[prime[j]];
           end;
        end
    end;
end;
begin
assign(input,'prime.in');
reset(input);
assign(output,'prime.out');
rewrite(output);
read(n);
init;
ans:=0;
for i:=1 to trunc(sqrt(n)) do
    begin
    if n mod i=0 then
       begin
       ans:=ans+qword(i)*qword(phi[i]);
       if qword(i)*qword(i)<>qword(n) then ans:=ans+qword(n div i)*qword(phi[n div i]);
       end;
    end;
ans:=ans*qword(n);
writeln(ans);
writeln(f[n]);
close(input);
close(output);
end.