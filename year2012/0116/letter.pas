const maxn=100020;
var n,m,i,x,y,j,k,t,ans,t1,t2:longint;
    cnt,r,tr,s,ts,h,g,up,a,down:array[0..maxn]of longint;
    f:array[0..maxn,0..18]of longint;
    two:array[0..18]of longint;
    ch:char;
procedure pre;
var i:longint;
begin
two[0]:=1;
for i:=1 to 18 do two[i]:=two[i-1]*2;
end;
function check(x:longint):longint;
var i:longint;
begin
for i:=0 to 17 do
    if (x>=two[i])and(x<two[i+1]) then exit(i);
end;
function query(l,r:longint):longint;
var t,res:longint;
begin
t:=check(r-l+1);
res:=f[l][t];
if f[r+1-two[t]][t]<res then res:=f[r+1-two[t]][t];
exit(res);
end;
begin
assign(input,'letter.in');
reset(input);
assign(output,'letter.out');
rewrite(output);
pre;
readln(n,m);
i:=0;
while i<n do
  begin
  read(ch);
  while (ord(ch)=13)or(ord(ch)=10)or(ord(ch)=32) do read(ch);
  inc(i);
  a[i]:=ord(ch);
  end;
inc(i);
a[i]:=ord('&');
i:=0;
while i<m do
  begin
  read(ch);
  while (ord(ch)=13)or(ord(ch)=10)or(ord(ch)=32) do read(ch);
  inc(i);
  a[i+n+1]:=ord(ch);
  end;
fillchar(cnt,sizeof(cnt),0);
x:=n; y:=m;
n:=n+m+1;
for i:=1 to n do inc(cnt[a[i]]);
for i:=1 to 300 do cnt[i]:=cnt[i-1]+cnt[i];
for i:=n downto 1 do
    begin
    s[cnt[a[i]]]:=i;
    dec(cnt[a[i]]);
    end;
r[s[1]]:=1; j:=1;
for i:=2 to n do
    begin
    if (a[s[i-1]]<>a[s[i]]) then inc(j);
    r[s[i]]:=j;
    end;
k:=j; j:=1;
while k<n do
  begin
  fillchar(cnt,sizeof(cnt),0);
  tr:=r;
  for i:=1 to n do inc(cnt[r[i+j]]);
  for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1 do
      begin
      ts[cnt[r[i+j]]]:=i;
      dec(cnt[r[i+j]]);
      end;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n do
      begin
      r[i]:=tr[ts[i]];
      inc(cnt[r[i]]);
      end;
  for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1 do
      begin
      s[cnt[r[i]]]:=ts[i];
      dec(cnt[r[i]]);
      end;
  k:=1;
  r[s[1]]:=1;
  for i:=2 to n do
      begin
      if (tr[s[i-1]]<>tr[s[i]])or(tr[s[i-1]+j]<>tr[s[i]+j]) then inc(k);
      r[s[i]]:=k;
      end;
  j:=j*2;
  end;
h[1]:=0; j:=0;

for i:=1 to n do
    begin
    if r[i]>1 then
       begin
       k:=s[r[i]-1];
       while (k+j<=n)and(i+j<=n)and(a[i+j]=a[k+j])do inc(j);
       h[r[i]]:=j;
       if j>0 then dec(j);
       end;
    end;
t:=check(n);
for i:=1 to n do f[i][0]:=h[i];
for j:=1 to t do
    begin
    for i:=1 to n+1-two[j] do
        begin
        f[i][j]:=f[i][j-1];
        if f[i+two[j-1]][j-1]<f[i][j] then
           f[i][j]:=f[i+two[j-1]][j-1];
        end;
    end;
for i:=1 to n do
    begin
    if s[i]<=x then g[i]:=1 else g[i]:=2;
    end;
j:=0;
for i:=1 to n do
    begin
    if g[i]=1 then j:=i
       else begin
            up[i]:=j;
            end;
    end;
j:=n+1;
for i:=n downto 1 do
    begin
    if g[i]=1 then j:=i
       else
           begin
           down[i]:=j;
           end;
    end;
j:=x+2;
while j<=n do
  begin
  inc(ans);
  if up[r[j]]=0 then
     t1:=0
  else
     t1:=query(up[r[j]]+1,r[j]);
  if down[r[j]]=n+1 then
     t2:=0
  else
     t2:=query(r[j]+1,down[r[j]]);
  if t1>t2 then j:=j+t1
     else j:=j+t2;
  end;
writeln(ans);
close(input);
close(output);
end.