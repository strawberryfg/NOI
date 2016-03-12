const maxn=555; eps=1e-12; max=100020;
      prime:array[1..13]of int64=
(2,11,37,91,149,997,999983,1000000007,2147483647,9999991,1225517,
10487999,10487053);
      maxans=100020;
type rec=record u,v,flag:longint; num:extended; end;
var n,i,num,j,cnt,x,sum:longint;
    a:array[0..maxn]of int64;
    ans,ans2:array[0..maxans]of rec;
    powp,powq:array[0..maxn]of int64;
    xa,xb:array[0..max]of longint;
function check(opt,p,q:longint):boolean;
var i,j,t:longint;
    ret:int64;
begin
for i:=1 to 13 do
    begin
    powp[0]:=1;
    for j:=1 to n do powp[j]:=powp[j-1]*int64(p) mod prime[i];
    powq[0]:=1;
    for j:=1 to n do powq[j]:=powq[j-1]*int64(q) mod prime[i];
    ret:=0;
    t:=1;
    for j:=0 to n do
        begin
        ret:=(ret+t*a[j]*powp[j] mod prime[i]*powq[n-j] mod prime[i]) mod prime[i];
        t:=t*opt;
        end;
    if ret<>0 then exit(false);
    end;
exit(true);
end;
procedure sort(l,r: longint);
var i,j: longint;
    cmp:extended;
    swap:rec;
begin
i:=l; j:=r; cmp:=ans[(l+r) div 2].num;
repeat
while (cmp-ans[i].num>eps) do inc(i);
while (ans[j].num-cmp>eps) do dec(j);
if not(i>j) then begin swap:=ans[i]; ans[i]:=ans[j]; ans[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function gcd(x,y:longint):longint;
begin
if y=0 then exit(x) else exit(gcd(y,x mod y));
end;
begin
assign(input,'akai.in');
reset(input);
assign(output,'akai.out');
rewrite(output);
readln(n);
for i:=0 to n do read(a[i]);
for i:=0 to n do if a[i]<>0 then begin num:=i; break; end;
for i:=1 to trunc(sqrt(abs(a[num]))) do
    if a[num] mod i=0 then
       begin
       inc(xa[0]); xa[xa[0]]:=i;
       if i*i<>abs(a[num]) then begin inc(xa[0]); xa[xa[0]]:=abs(a[num])div i; end;
       end;
for i:=1 to trunc(sqrt(abs(a[n]))) do
    if a[n] mod i=0 then
       begin
       inc(xb[0]); xb[xb[0]]:=i;
       if i*i<>abs(a[n]) then begin inc(xb[0]); xb[xb[0]]:=abs(a[n])div i; end;
       end;
for i:=1 to xa[0] do
    begin
    for j:=1 to xb[0] do
        begin
        if check(1,xa[i],xb[j]) then
           begin
           inc(cnt); ans[cnt].u:=xa[i]; ans[cnt].v:=xb[j]; ans[cnt].flag:=1; ans[cnt].num:=xa[i]/xb[j];
           end;
        if check(-1,xa[i],xb[j]) then
           begin
           inc(cnt); ans[cnt].u:=xa[i]; ans[cnt].v:=xb[j]; ans[cnt].flag:=-1; ans[cnt].num:=-xa[i]/xb[j];
           end;
        end;
    end;
if a[0]=0 then begin inc(cnt); ans[cnt].u:=0; ans[cnt].v:=0; ans[cnt].flag:=1; ans[cnt].num:=0; end;
for i:=1 to cnt do
    begin
    if (ans[i].u=0)and(ans[i].v=0) then continue;
    if ans[i].v=1 then continue;
    x:=gcd(ans[i].u,ans[i].v);
    ans[i].u:=ans[i].u div x;
    ans[i].v:=ans[i].v div x;
    end;
sort(1,cnt);
i:=1;
while i<=cnt do
  begin
  j:=i;
  while (j+1<=cnt)and(ans[i].flag=ans[j+1].flag)and(ans[i].u=ans[j+1].u)and(ans[i].v=ans[j+1].v) do inc(j);
  inc(sum); ans2[sum]:=ans[i];
  i:=j+1;
  end;
writeln(sum);
for i:=1 to sum do
    begin
    if (ans2[i].u=0)and(ans2[i].v=0) then
      begin
      writeln(0);
      continue;
      end;
    if ans2[i].flag=-1 then write('-');
    if ans2[i].v=1 then write(ans2[i].u)
       else write(ans2[i].u,'/',ans2[i].v);
    writeln;
    end;
close(input);
close(output);
end.