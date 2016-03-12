const max=50020;
type rec=record l,r,c:longint; end;
var i,j,cnt,test,u,a,b,c,d,k,tot1,tot2:longint;
    prime,mu:array[0..max]of longint;
    summ:array[0..max]of int64;
    check:array[0..max]of boolean;
    ans:int64;
    up,down:array[0..max]of rec;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function fmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function work2(a,b,d:longint):int64;
var d1,i,t,j,k,p:longint;
    tmp,res,ra,rb,r1,r2:int64;
begin
res:=0;
d1:=min(a,b);
res:=0;
i:=1;
while i<=d1 do
  begin
  ra:=a div (i); r1:=a div (ra);
  rb:=b div (i); r2:=b div (rb);
  t:=min(r1,r2);
  if t>d1 then t:=d1;
  res:=res+ra*rb*(summ[t]-summ[i-1]);
  i:=t+1;
  end;
exit(res);
end;
begin
assign(input,'homework.in');
reset(input);
{assign(output,'homework.out');
rewrite(output);}
mu[1]:=1;
fillchar(check,sizeof(check),false);
cnt:=0;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; mu[i]:=-1; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>max then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then begin mu[i*prime[j]]:=0; break; end
           else mu[i*prime[j]]:=-mu[i];
        end;
    end;
summ[0]:=0;
for i:=1 to max do summ[i]:=summ[i-1]+int64(mu[i]);
readln(test);
for u:=1 to test do
    begin
//    readln(a,b,c,d,k);
    ans:=0;
//    ans:=work2(b,d,k)-work2(b,c-1,k)-work2(a-1,d,k)+work2(a-1,c-1,k);
    readln(a,b,d);
    ans:=work2(a div d,b div d,d);
    writeln(ans);
    end;
close(input);
close(output);
end.
