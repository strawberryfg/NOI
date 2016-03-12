const maxn=100000;
      maxm=300000;
var a:array[0..maxn]of boolean;
    q,f:array[0..maxn]of longint;
    e:array[1..maxm,1..3]of longint;
    s:array[0..9]of longint;
    i,r,n,m,l,p,ans,x,y:longint;
procedure swap(var a,b:longint);
var t:longint;
begin
  t:=a;
  a:=b;
  b:=t;
end;
function get(x,k:longint):longint;
begin
  get:=x div s[k] mod 10;
end;
function replace(x,y,k:longint):longint;
begin
  replace:=y*s[k]+x mod s[k]+x div s[k+1]*s[k+1]
end;
procedure push(x,y,z:longint);
begin
  if x=y then exit;
  if a[x] then
  begin
    a[x]:=false;
    inc(r);
    q[r]:=x;
  end;
  inc(m);
  e[m][1]:=z;         //1: cost
  e[m][2]:=x;         //2: u
  e[m][3]:=y;         //3: v
end;
procedure expand(x:longint);
var i,j,t,y,a,b,c:longint;
begin
  t:=trunc(ln(x)/ln(10))+1;
  for i:=1 to t do
    for j:=i+1 to t do
    begin
      a:=get(x,j);
      b:=get(x,i);
      push(replace(replace(x,a,i),b,j),x,((a and b)+(a xor b))*2);
    end;
  for i:=1 to t+1 do
  begin
    a:=get(x,i mod t+1);
    b:=get(x,(i+t-1)mod t+1);
    c:=get(x,(i+t-2)mod t+1);
    if (i<=t)and(t>1)and(a<=b)and(b<=c) then
      push(x mod s[i]+(x div s[i+1])*s[i],x,(a and c)+(a xor c)+b);
    if t<l then
      for j:=b to c do
        push(x mod s[i]+x div s[i]*s[i+1]+j*s[i],x,(b and c)+(b xor c)+j);
  end;
end;
procedure sort(l,r:longint);
var i,j,x:longint;
begin
  i:=l;
  j:=r;
  x:=e[(l+r)shr 1][1];
  repeat
    while e[i][1]<x do
      inc(i);
    while x<e[j][1] do
      dec(j);
    if i<=j then
    begin
      swap(e[i][1],e[j][1]);
      swap(e[i][2],e[j][2]);
      swap(e[i][3],e[j][3]);
      inc(i);
      dec(j);
    end;
  until i>=j;
  if i<r then sort(i,r);
  if l<j then sort(l,j);
end;
function parent(x:longint):longint;
var t,y:longint;
begin
  y:=x;
  while f[y]>0 do y:=f[y];
  while f[x]>0 do
  begin
    t:=x;
    x:=f[x];
    f[t]:=y;
  end;
  parent:=x;
end;
begin
assign(input,'problem.in');
reset(input);
assign(output,'problem.out');
rewrite(output);
  fillchar(a,sizeof(a),true);
  readln(n);
  r:=1;
  read(q[1]);
  m:=0;
  a[q[1]]:=false;
  l:=trunc(ln(q[1])/ln(10))+1;
  for i:=2 to n do
  begin
    read(x);
    if trunc(ln(x)/ln(10))+1>l then l:=trunc(ln(x)/ln(10))+1;
    push(x,q[i-1],0);
  end;
  s[0]:=1;
  s[1]:=1;
  for i:=2 to l+3 do
    s[i]:=s[i-1]*10;
  i:=0;
  repeat
    inc(i);
    expand(q[i]);
  until i>=r;
  sort(1,m);
  fillchar(f,sizeof(f),0);
    p:=1;
  ans:=0;
  for i:=1 to m do
  begin
    x:=parent(e[i][2]);
    y:=parent(e[i][3]);
    if x<>y then
    begin
      f[x]:=y;
      inc(p);
      ans:=ans+e[i][1];
      if p>=r then break;
    end;
  end;
  writeln(ans);
close(input);
close(output);
end.
