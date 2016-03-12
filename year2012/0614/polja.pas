const maxn=2888;
type rec=array[0..maxn]of longint;
     atype=record x1,y1,x2,y2,c:longint; end;
var n,i,j,k:longint;
    ans:qword;
    a:array[0..maxn]of atype;
    xx,yy,b:rec;
    up,g:array[0..maxn,0..maxn]of longint;
    ll,rr:array[0..maxn]of longint;
    q:array[0..maxn]of longint;
function max(x,y:qword):qword;
begin
if x>y then exit(x) else exit(y);
end;
procedure sort(var a:rec;l,r:longint);
var i,j,cmp,swap:longint;
begin
i:=l; j:=r; cmp:=a[random(r-l)+l];
repeat
while a[i]<cmp do inc(i);
while cmp<a[j] do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(a,l,j);
if i<r then sort(a,i,r);
end;
function find(a:rec; v:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=a[0];
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if a[mid]<v then le:=mid+1
     else if a[mid]>v then ri:=mid-1
             else exit(mid);
  end;
end;
procedure work(ny:longint);
var i,j,head,tail:longint;
begin
for i:=1 to xx[0]-1 do begin ll[i]:=i; rr[i]:=i; end;
i:=1;
while i<=xx[0]-1 do
  begin
  j:=i;
  while (j<=xx[0]-1)and(g[j][ny]=0) do inc(j);
  if j>xx[0]-1 then break;
  i:=j;
  while (j+1<=xx[0]-1)and(g[j+1][ny]=g[i][ny]) do inc(j);
  head:=1; tail:=0;
  for k:=i to j do
      begin
      while (head<=tail)and(up[k][ny]>up[q[tail]][ny]) do begin rr[q[tail]]:=k-1; dec(tail); end;
      inc(tail); q[tail]:=k;
      end;
  if (j=xx[0]-1)or(g[j+1][ny]<>g[j][ny])and(head<=tail) then for k:=head to tail do rr[q[k]]:=j;
  i:=j+1;
  end;
i:=xx[0]-1;
while i>=1 do
  begin
  j:=i;
  while (j>=1)and(g[j][ny]=0) do dec(j);
  if j<1 then break;
  i:=j;
  while (j-1>=1)and(g[j-1][ny]=g[i][ny]) do dec(j);
  head:=1; tail:=0;
  for k:=i downto j do
      begin
      while (head<=tail)and(up[k][ny]>up[q[tail]][ny]) do begin ll[q[tail]]:=k+1; dec(tail); end;
      inc(tail); q[tail]:=k;
      end;
  if (j=1)or(g[j-1][ny]<>g[j][ny])and(head<=tail) then for k:=head to tail do ll[q[k]]:=j;
  i:=j-1;
  end;
for i:=1 to xx[0]-1 do
    if g[i][ny]<>0 then
       ans:=max(ans,qword(xx[rr[i]+1]-xx[ll[i]])*qword(yy[ny+1]-yy[up[i][ny]]));
end;
begin
assign(input,'polja.in');
reset(input);
assign(output,'polja.out');
rewrite(output);
readln(n);
randomize;
for i:=1 to n do
    begin
    readln(a[i].x1,a[i].y1,a[i].x2,a[i].y2,a[i].c);
    xx[2*i-1]:=a[i].x1; xx[2*i]:=a[i].x2;
    yy[2*i-1]:=a[i].y1; yy[2*i]:=a[i].y2;
    end;
sort(xx,1,2*n);
sort(yy,1,2*n);
i:=1; b[0]:=0;
while i<=2*n do
  begin
  j:=i;
  while (j+1<=2*n)and(xx[i]=xx[j+1]) do inc(j);
  inc(b[0]); b[b[0]]:=xx[i];
  i:=j+1;
  end;
xx:=b;
i:=1; b[0]:=0;
while i<=2*n do
  begin
  j:=i;
  while (j+1<=2*n)and(yy[i]=yy[j+1]) do inc(j);
  inc(b[0]); b[b[0]]:=yy[i];
  i:=j+1;
  end;
yy:=b;
for i:=1 to n do
    begin
    a[i].x1:=find(xx,a[i].x1); a[i].x2:=find(xx,a[i].x2);
    a[i].y1:=find(yy,a[i].y1); a[i].y2:=find(yy,a[i].y2);
    end;
for i:=1 to n do
    for j:=a[i].x1 to a[i].x2-1 do
        for k:=a[i].y1 to a[i].y2-1 do
            g[j][k]:=a[i].c;
for i:=1 to xx[0]-1 do if g[i][1]<>0 then up[i][1]:=1;
for j:=1 to yy[0]-1 do
    for i:=1 to xx[0]-1 do
        if g[i][j]<>g[i][j-1] then up[i][j]:=j
           else up[i][j]:=up[i][j-1];
ans:=0;
for i:=1 to yy[0]-1 do work(i);
writeln(ans);
close(input);
close(output);
end.