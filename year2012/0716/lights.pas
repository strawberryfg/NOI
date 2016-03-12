const maxn=102; inf=maxlongint;
var test,n,d,i,ans:longint;
    a,b,sta:array[0..maxn]of longint;
function max(x,y:longint):longint; inline;
begin
if x>y then exit(x) else exit(y);
end;
function min(x,y:longint):longint; inline;
begin
if x<y then exit(x) else exit(y);
end;
procedure work;
var i,j,sum,up,now:longint;
begin
b[1]:=a[1];
for i:=2 to n do b[i]:=a[i] xor a[i-1];
sum:=0;
for i:=1 to d do
    begin
    if sta[i]=0 then continue;
    inc(sum);
{    for j:=1 to min(i+d,n) do
        b[j]:=b[j] xor 1;}
    b[1]:=b[1] xor 1;
    up:=min(i+d,n);
    if up+1<=n then b[up+1]:=b[up+1] xor 1;
    end;
now:=b[1];
for i:=1 to n-d do
    begin
    if i>1 then now:=now xor b[i];
{    if b[i]=1 then
       begin
       for j:=i to min(i+d+d,n) do
           b[j]:=b[j] xor 1;
       inc(sum);
       end;}
    if now=1 then
       begin
       inc(sum);
       now:=now xor 1;
       b[i]:=b[i] xor 1;
       up:=min(i+d+d,n);
       if up+1<=n then b[up+1]:=b[up+1] xor 1;
       end;
    end;
for i:=1 to n do if b[i]<>0 then exit;
if sum<ans then
   ans:=sum;
exit;
end;
procedure dfs(x:longint);
var i:longint;
begin
if x>d then
   begin
   work;
   exit;
   end;
for i:=0 to 1 do
    begin
    sta[x]:=i;
    dfs(x+1);
    end;
end;
begin
{assign(input,'lights.in');
reset(input);
assign(output,'d:\wqf\lights3.out');
rewrite(output);}
readln(test);
while test>0 do
  begin
  dec(test);
  readln(n,d);
  for i:=1 to n do read(a[i]);
  if (n=81)and(d=1) then
     d:=d;
  readln;
  d:=min(d,n);
  if d=0 then
     begin
     ans:=0;
     for i:=1 to n do ans:=ans+a[i];
     writeln(ans);
     continue;
     end;
  ans:=inf;
  dfs(1);
  if ans=inf then writeln('impossible') else writeln(ans);
  end;
{close(input);
close(output);}
end.