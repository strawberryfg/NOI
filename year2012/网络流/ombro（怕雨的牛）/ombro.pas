const maxn=800;
var a,b,hash,h,fa,info:array[0..maxn]of longint;
    f,tc,c:array[0..maxn,0..maxn]of int64;
    d,e:array[0..maxn*maxn]of int64;
    his:array[0..maxn]of int64;
    ans:int64;
    inf:int64;
    n,m,i,j,k,tot,cnt,x,y,z,le,ri,mid,s,t,sum:longint;
procedure sort(l,r: longint);
var i,j: longint;
    x,y:int64;
begin
i:=l; j:=r; x:=d[(l+r) div 2];
repeat
while d[i]<x do inc(i);
while x<d[j] do dec(j);
if not(i>j) then begin y:=d[i]; d[i]:=d[j]; d[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function check(x:longint):boolean;
var i,j,st,min,num:longint;
    flag:boolean;
    now,res:int64;
begin
c:=tc;
for i:=1 to n do
    for j:=1 to n do
        begin
        if (f[i][j]<>inf)and(f[i][j]<=e[x])and(b[j]>0) then
           begin
           c[i][j+n]:=inf;
           end;
        end;
now:=inf;
fillchar(hash,sizeof(hash),0);
hash[0]:=2*n+2;
fillchar(h,sizeof(h),0);
fillchar(info,sizeof(info),0);
fillchar(fa,sizeof(fa),0);
i:=s;
res:=0;
if x=200 then
   i:=i;
while h[s]<2*n+2 do
  begin
  flag:=false;
  his[i]:=now;
  st:=info[i];
  for j:=st to t do
      begin
      if (c[i][j]>0)and(h[j]+1=h[i]) then
         begin
         fa[j]:=i;
         flag:=true;
         if c[i][j]<now then now:=c[i][j];
         info[i]:=j;
         i:=j;
         if i=t then
            begin
            res:=res+now;
            while i<>s do
              begin
              dec(c[fa[i]][i],now);
              inc(c[i][fa[i]],now);
              i:=fa[i];
              end;
            now:=inf;
            end;
         break;
         end;
      end;
  if not flag then
     begin
     min:=2*n+1; num:=-1;
     for j:=s to t do
         begin
         if (c[i][j]>0)and(h[j]<min) then
            begin
            min:=h[j];
            num:=j;
            end;
         end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     info[i]:=num;
     inc(hash[h[i]]);
     if i<>s then begin i:=fa[i]; now:=his[i]; end;
     end;
  end;
if res=sum then
   exit(true)
else
   exit(false);
end;
begin
assign(input,'ombro.in');
reset(input);
assign(output,'ombro.out');
rewrite(output);
inf:=1844674407370955166;
readln(n,m);
sum:=0;
for i:=1 to n do
    begin
    readln(a[i],b[i]);
    sum:=sum+a[i];
    end;
for i:=1 to n do
    for j:=1 to n do
        f[i][j]:=inf;
for i:=1 to n do f[i][i]:=0;
for i:=1 to m do
    begin
    readln(x,y,z);
    if z<f[x][y] then
       begin
       f[x][y]:=z;
       f[y][x]:=z;
       end;
    end;
for k:=1 to n do
    for i:=1 to n do
        for j:=1 to n do
            begin
            if (i<>j)and(j<>k)and(i<>k)and(f[i][k]<>inf)and(f[k][j]<>inf)and(f[i][k]+f[k][j]<f[i][j]) then
               f[i][j]:=f[i][k]+f[k][j];
            end;
tot:=0;
for i:=1 to n do
    for j:=1 to n do
        begin
        if f[i][j]<>inf then
           begin
           inc(tot);
           d[tot]:=f[i][j];
           end;
        end;
sort(1,tot);
i:=1;  cnt:=0;
while i<=tot do
  begin
  j:=i;
  while (j+1<=tot)and(d[j+1]=d[i]) do inc(j);
  inc(cnt);
  e[cnt]:=d[i];
  i:=j+1;
  end;
s:=0; t:=2*n+1;
for i:=1 to n do
    begin
    tc[s][i]:=a[i];
    tc[i+n][t]:=b[i];
    end;
le:=1; ri:=cnt; ans:=-1;
while le<=ri do
  begin
  mid:=(le+ri)div 2;
  if check(mid) then
     begin
     ans:=e[mid];
     ri:=mid-1;
     end
  else
     le:=mid+1;
  end;
writeln(ans);
close(input);
close(output);
end.
