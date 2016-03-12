const maxn=1111111; maxtree=11111111; maxx=333; inf=maxlongint;
type segtype=record ll,rr,v:longint; end;
var n,i,j,k,mmax,tot,t,res:longint;
    s,ts,r,tr,a,cnt,h,fans,fmax:array[0..maxn]of longint;
    f:array[0..511111,0..24]of longint;
    pow:array[0..25]of longint;
    col:array[0..maxtree]of longint;
    seg:array[0..maxn]of segtype;
    ch:char;
procedure sort(l,r:longint);
var i,j,cmp:longint; swap:segtype;
begin
i:=l; j:=r; cmp:=seg[(l+r) div 2].v;
repeat
while seg[i].v>cmp do inc(i);
while cmp>seg[j].v do dec(j);
if not(i>j) then begin swap:=seg[i]; seg[i]:=seg[j]; seg[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure pushdown(x:longint);
begin
if col[x]<>0 then
   begin
   col[x*2]:=col[x]; col[x*2+1]:=col[x];
   col[x]:=0;
   end;
end;
procedure modify(l,r,x,f,t,v:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   col[x]:=v;
   exit;
   end;
pushdown(x);
mid:=(l+r) div 2;
if f<=mid then modify(l,mid,x*2,f,t,v);
if t>mid then modify(mid+1,r,x*2+1,f,t,v);
end;
function get(l,r,x,f,t:longint):longint;
var mid:longint;
begin
if (f<=l)and(r<=t) then exit(col[x]);
pushdown(x);
mid:=(l+r) div 2;
if f<=mid then exit(get(l,mid,x*2,f,t));
if t>mid then exit(get(mid+1,r,x*2+1,f,t));
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function rmq(x,y:longint):longint;
var t:longint;
begin
t:=trunc(ln(y-x+1)/ln(2));
exit(max(f[x][t],f[y+1-pow[t]][t]));
end;
begin
assign(input,'string.in');
reset(input);
assign(output,'string.out');
rewrite(output);
n:=0;
while not eoln do begin inc(n); read(ch); a[n]:=ord(ch); end;
for i:=1 to n do inc(cnt[a[i]]);
for i:=1 to maxx do cnt[i]:=cnt[i-1]+cnt[i];
for i:=n downto 1  do
    begin
    s[cnt[a[i]]]:=i;
    dec(cnt[a[i]]);
    end;
r[s[1]]:=1;
j:=1;
for i:=2 to n do
    begin
    if a[s[i]]<>a[s[i-1]] then inc(j);
    r[s[i]]:=j;
    end;
k:=j; j:=1;
while k<n do
  begin
  tr:=r;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n do inc(cnt[r[i+j]]);
  for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1  do
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
  r[s[1]]:=1;
  k:=1;
  for i:=2 to n do
      begin
      if (tr[s[i]]<>tr[s[i-1]])or(tr[s[i]+j]<>tr[s[i-1]+j]) then
         inc(k);
      r[s[i]]:=k;
      end;
  j:=j*2;
  end;
j:=0; h[1]:=0;
for i:=1 to n do
    begin
    if r[i]>1 then
       begin
       k:=s[r[i]-1];
       while (a[i+j]=a[k+j])and(a[i+j]<>0)and(a[k+j]<>0) do inc(j);
       h[r[i]]:=j;
       if j>0 then dec(j);
       end;
    end;
for i:=0 to n do begin fans[i]:=inf; fmax[i]:=-inf; end;
tot:=0;
for i:=1 to n do
    begin
    mmax:=0;
    if r[i]<>1 then
       begin
       if h[r[i]]>mmax then mmax:=h[r[i]];
       end;
    if r[i]<>n then
       begin
       if h[r[i]+1]>mmax then mmax:=h[r[i]+1];
       end;
    if (mmax<>n-i+1) then
       begin
       if mmax<>0 then
          begin
          inc(tot);
          seg[tot].ll:=i; seg[tot].rr:=i+mmax-1; seg[tot].v:=mmax+1;
          end;
       if i>fmax[i+mmax-1] then fmax[i+mmax-1]:=i;
       end;
    end;
sort(1,tot);
for i:=1 to tot do
    modify(1,n,1,seg[i].ll,seg[i].rr,seg[i].v);
t:=trunc(ln(n)/ln(2));
for i:=0 to n do f[i][0]:=fmax[i];
pow[0]:=1;
for i:=1 to 24 do pow[i]:=pow[i-1]*2;
for j:=1 to t do
    for i:=0 to n+1-pow[j] do
        begin
        f[i][j]:=max(f[i][j-1],f[i+pow[j-1]][j-1]);
        end;
for i:=1 to n do
    begin
    res:=get(1,n,1,i,i);
    if res<>0 then fans[i]:=res;
    end;
for i:=1 to n do
    begin
    res:=rmq(0,i-1);
    if (res<>-inf)and(i-res+1<fans[i]) then fans[i]:=i-res+1;
    end;
for i:=1 to n do writeln(fans[i]);
close(input);
close(output);
end.
