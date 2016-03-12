const maxprime=1000020; base=1000003;
var test,cnt,i,j,a,b,now,g,sum,x,t,flag,tmpsum:longint;
    res,std,n:qword;
    prime:array[0..maxprime]of longint;
    pow,ans,bel,from:array[0..2*maxprime]of longint;
    xa:array[0..2*maxprime]of qword;
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
cnt:=0;
fillchar(check,sizeof(check),false);
pow[0]:=1;
for i:=1 to 2*maxprime do pow[i]:=pow[i-1]*2 mod base;
for i:=2 to maxprime do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; from[i]:=cnt; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>maxprime then break;
        if check[i*prime[j]]=false then
           begin
           from[i*prime[j]]:=j;
           check[i*prime[j]]:=true;
           end;
        if i mod prime[j]=0 then
           begin
           from[i]:=j;
           break;
           end;
        end;
    end;
for now:=1 to test do
    begin
    readln(a,b);
    if (a=0)and(b=0) then begin writeln(0); continue; end;
    g:=gcd(a,b);
    n:=(a+b) div g;
    sum:=1;
    xa[1]:=1;
    x:=n;
    t:=from[x];
    while x>1 do
      begin
      flag:=0;
      while x mod prime[t]=0 do begin flag:=1; x:=x div prime[t]; end;
      if flag=1 then begin inc(sum); xa[sum]:=prime[t]; end;
      if x=1 then break;
      t:=from[x];
      if t=0 then

         break;
      end;

    tmpsum:=sum;
    bel[1]:=now;
    ans[1]:=n;
    res:=0;
    i:=1;
    while i<=sum do
        begin
        if n mod xa[i]<>0 then continue;
        for j:=2 to tmpsum do
            begin
            if (n mod (xa[i]*xa[j])=0)and(bel[xa[i]*xa[j]]<>now) then
               begin
               bel[xa[i]*xa[j]]:=now;
               ans[xa[i]*xa[j]]:=ans[xa[i]] div xa[j];
               ans[xa[i]]:=ans[xa[i]]-ans[xa[i]] div xa[j];
               if check[xa[i]*xa[j]] then
                  begin
                  inc(sum);
                  xa[sum]:=xa[i]*xa[j];
                  end;
               end;
            end;
        if ans[xa[i]]<>0 then
           begin
           res:=(res+quick(pow[g],xa[i])*ans[xa[i]] mod base)mod base;
           ans[xa[i]]:=0;
           end;
        inc(i);
        end;
    res:=res*quick(n,base-2) mod base;
    res:=(qword(pow[a+b])+base-res) mod base;
    writeln(res);
    end;
{close(input);
close(output);}
end.
