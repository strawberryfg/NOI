//18:38;
const maxn=88; inf=maxlongint;
type rec=record data,value,freq:longint; end;
     info=record v,id:longint; end;
var n,cost,i,j,k,ans:longint;
    a,savea:array[0..maxn]of rec;
    b:array[0..maxn]of info;
    sum,bel:array[0..maxn]of longint;
    f:array[0..maxn,0..maxn,0..maxn]of longint;
    vis:array[0..maxn,0..maxn]of longint;
procedure cmin(var x:longint; y:longint);
begin
if y<x then x:=y;
end;
procedure sort(l,r:longint);
var i,j,cmp:longint; swap:info;
begin
i:=l; j:=r; cmp:=b[(l+r) div 2].v;
repeat
while b[i].v<cmp do inc(i);
while cmp<b[j].v do dec(j);
if not(i>j) then begin swap:=b[i]; b[i]:=b[j]; b[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure dp(l,r:longint);
var k,j:longint;
begin
if l>r then exit;
if vis[l][r]=1 then exit;
vis[l][r]:=1;
for j:=0 to n do
    for k:=l to r do
        begin
        dp(l,k-1); dp(k+1,r);
        if bel[k]>j then cmin(f[l][r][j],f[l][k-1][bel[k]]+f[k+1][r][bel[k]]+sum[r]-sum[l-1]);
        cmin(f[l][r][j],f[l][k-1][j]+f[k+1][r][j]+cost+sum[r]-sum[l-1]);      // modify node k; node k is root;
        end;
end;
begin
assign(input,'treapmod.in');
reset(input);
assign(output,'treapmod.out');
rewrite(output);
read(n,cost);
for i:=1 to n do read(a[i].data);
for i:=1 to n do read(a[i].value);
for i:=1 to n do read(a[i].freq);
savea:=a;
for i:=1 to n do begin b[i].v:=a[i].data; b[i].id:=i; end;    // key
sort(1,n);
sum[0]:=0;
for i:=1 to n do a[i]:=savea[b[i].id];
for i:=1 to n do begin b[i].v:=a[i].value; b[i].id:=i; end;   // ran
sort(1,n);
for i:=1 to n do bel[b[i].id]:=i;
for i:=1 to n do sum[i]:=sum[i-1]+a[i].freq;
for i:=1 to n do for j:=i to n do for k:=0 to n do f[i][j][k]:=inf;
dp(1,n);
ans:=inf;
for k:=0 to n do
    cmin(ans,f[1][n][k]);
writeln(ans);
close(input);
close(output);
end.