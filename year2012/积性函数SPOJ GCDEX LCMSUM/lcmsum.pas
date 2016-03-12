const max=1000200;
var test,n,i,j,t,x,u,cnt:longint;
    phi,f:array[0..max]of qword;
    ans:qword;
    check:array[0..max]of boolean;
    prime:array[0..max]of longint;
function pow(x,y:qword):qword;
var i,res:qword;
begin
res:=1;
i:=1;
while i<=y do begin res:=res*x; i:=i+1; end;
pow:=res;
end;
begin
{assign(input,'lcmsum.in');
reset(input);
assign(output,'lcmsum.out');
rewrite(output);}
readln(test);
phi[1]:=1;
fillchar(check,sizeof(check),false);
f[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; f[i]:=pow(i,3)-pow(i,2)+qword(i); end;
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
           f[i*prime[j]]:=f[t]*(pow(prime[j],3)*f[x]-(prime[j]-1)*x*prime[j]);
           break;
           end
        else
           begin
           phi[i*prime[j]]:=phi[i]*(prime[j]-1);
           f[i*prime[j]]:=f[i]*f[prime[j]];
           end;
        end;
    end;
for u:=1 to test do
    begin
    readln(n);
    ans:=(f[n]+n)div 2;
    writeln(ans);
    end;
{close(input);
close(output);}
end.