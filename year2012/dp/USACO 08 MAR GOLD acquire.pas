const maxn=50020; maxv=1000020;
var n,i,j,cnt,head,tail,sum:longint;
    a,b,c,xa,xb,bit,stack:array[0..maxn]of longint;
    bel:array[0..maxv]of longint;
    f:array[0..maxn]of int64;
procedure sort(l,r:longint);
var i,j,cmpa,cmpb,tmp:longint;
begin
i:=l; j:=r; cmpa:=a[(l+r) div 2]; cmpb:=b[(l+r) div 2];
repeat
while (a[i]>cmpa)or((a[i]=cmpa)and(b[i]>cmpb)) do inc(i);
while (cmpa>a[j])or((cmpa=a[j])and(cmpb>b[j])) do dec(j);
if not(i>j) then begin tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp; tmp:=b[i]; b[i]:=b[j]; b[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r:longint);
var i,j,cmp,tmp:longint;
begin
i:=l; j:=r; cmp:=c[(l+r) div 2];
repeat
while (c[i]<cmp) do inc(i);
while (cmp<c[j]) do dec(j);
if not(i>j) then begin tmp:=c[i]; c[i]:=c[j]; c[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
function query(x:longint):longint;
begin
query:=0; while x>0 do begin query:=query+bit[x]; x:=x-x and -x; end;
end;
procedure modify(x,d:longint);
begin
while x<=cnt do begin bit[x]:=bit[x]+d; x:=x+x and -x; end;
end;
function check(u,v,i:longint):boolean;
var res:int64;
begin
res:=f[u]+int64(xa[u+1])*int64(xb[i])-f[v]-int64(xa[v+1])*int64(xb[i]);
if res>=0 then check:=true else check:=false;
end;
function calc(k,j,i:longint):boolean;
var res:int64;
begin
res:=(f[k]-f[j])*(int64(xa[j+1])-int64(xa[i+1]))-(f[j]-f[i])*(int64(xa[k+1])-int64(xa[j+1]));
if res<=0 then calc:=true else calc:=false;
end;
begin
{assign(input,'acquire.in');
reset(input);
assign(output,'acquire.out');
rewrite(output);}
readln(n);
for i:=1 to n do read(a[i],b[i]);
sort(1,n);
c:=b;
sort2(1,n);
i:=1; cnt:=0;
while i<=n do
  begin
  j:=i;
  while (j+1<=n)and(c[j+1]=c[i]) do inc(j);
  inc(cnt);
  bel[c[i]]:=cnt;
  i:=j+1;
  end;
sum:=0;
for i:=1 to n do
    begin
    if query(cnt)-query(bel[b[i]]-1)>0 then continue;
    inc(sum); xa[sum]:=a[i]; xb[sum]:=b[i];
    modify(bel[b[i]],1);
    end;
head:=1; tail:=1; stack[1]:=0; f[0]:=0;
for i:=1 to sum do
    begin
    while (head<tail)and(check(stack[head],stack[head+1],i)) do inc(head);
    f[i]:=f[stack[head]]+int64(xa[stack[head]+1])*int64(xb[i]);
    while (head<tail)and(calc(stack[tail-1],stack[tail],i)) do dec(tail);
    inc(tail); stack[tail]:=i;
    end;
writeln(f[sum]);
{close(input);
close(output);}
end.