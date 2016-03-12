const maxn=31; base=4173577; eps=1e-14;
type arr=array[0..maxn]of longint;
var n,m,i,x,y,t1,t2,cn2:longint;
    fa,a:arr;
    ans:extended;
    pow:array[0..maxn]of longint;
    f:array[0..base+10]of extended;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
function calchash(sta:arr):longint;
var i:longint; ret:longint;
begin
ret:=0;
for i:=1 to n do ret:=(ret+pow[i-1]*sta[i]) mod base;
exit(ret);
end;
procedure sort(var a:arr;l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]>x do inc(i);
while x>a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(a,l,j);
if i<r then sort(a,i,r);
end;
function solve(a:arr):extended;
var pd:longint; ret1:longint; res,sum:extended; i,j,savei,savej:longint;
    b:arr;
begin
b:=a;
sort(b,1,n);
pd:=0;
ret1:=calchash(b);
if abs(f[ret1])>eps then exit(f[ret1]);
for i:=1 to n do if b[i]<>0 then begin inc(pd); if pd>1 then break; end;
if pd=1 then exit(0);
res:=0.0; sum:=0.0;
for i:=1 to n-1 do
    begin
    if b[i]=0 then break;
    for j:=i+1 to n do
        begin
        if b[j]=0 then break;
        savei:=b[i]; savej:=b[j];
        b[i]:=b[i]+b[j]; b[j]:=0;
        res:=res+savei*savej/cn2*solve(b);
        b[i]:=savei; b[j]:=savej;
        end;
    end;
for i:=1 to n do sum:=sum+b[i]*(b[i]-1)/2/cn2;
res:=res+1.0;
f[ret1]:=res/(1-sum);
solve:=f[ret1];
end;
begin
{assign(input,'interconnect.in');
reset(input);
assign(output,'interconnect.out');
rewrite(output);}
readln(n,m);
for i:=1 to n do fa[i]:=i;
for i:=1 to m do
    begin
    readln(x,y);
    t1:=getfa(x); t2:=getfa(y);
    if t1<>t2 then fa[t2]:=t1;
    end;
for i:=1 to n do inc(a[getfa(i)]);
pow[0]:=1;
for i:=1 to n do pow[i]:=pow[i-1]*qword(999983) mod base;
cn2:=n*(n-1) div 2;
ans:=solve(a);
writeln(ans:0:6);
{close(input);
close(output);}
end.