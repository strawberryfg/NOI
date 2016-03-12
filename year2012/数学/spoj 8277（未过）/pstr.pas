const max=1111111; base=1000000007;
var test,now,cnt,i,num,n:longint;
    check:array[0..max]of boolean;
    prime,mu:array[0..max]of longint;
    ans:qword;
procedure init;
var i,j:longint;
begin
fillchar(check,sizeof(check),false); mu[1]:=1;
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
end;
function pow(x:qword; y:longint):qword;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x mod base;
  y:=y div 2; if y=0 then break;
  x:=x*x mod base;
  end;
end;
begin
assign(input,'pstr.in');
reset(input);
assign(output,'pstr.out');
rewrite(output);
init;
read(test);
for now:=1 to test do
    begin
    read(num,n); ans:=0;
    for i:=1 to trunc(sqrt(n)) do
        begin
        if n mod i=0 then
           begin
           ans:=(ans+base+mu[n div i]*pow(num,i)) mod base;
           if i*i<>n then ans:=(ans+base+mu[i]*pow(num,n div i)) mod base;
           end;
        end;
    writeln(ans);
    end;
close(input);
close(output);
end.
