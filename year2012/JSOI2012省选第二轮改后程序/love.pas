const base=3214567;
type rec=record x:array[1..2,1..2]of int64; r,c:longint; end;
var m,p:longint;
    n,sum,tmp:int64;
    f,a,b,mat,ans,ret,now:rec;
function pow(x:int64;y:longint):int64;
var now,ret:int64;
begin
ret:=1; now:=x;
while y>0 do
  begin
  if y mod 2=1 then ret:=ret*now mod base;
  now:=now*now mod base;
  y:=y div 2;
  end;
pow:=ret;
end;
function phi(x:longint):int64;
var tx,i,cnt:longint;
    ret:int64;
begin
tx:=x;
ret:=x;
for i:=2 to trunc(sqrt(x)) do
    begin
    cnt:=0;
    while tx mod i=0 do begin inc(cnt); tx:=tx div i; end;
    if cnt<>0 then ret:=ret*(i-1) div i;
    if tx=1 then break;
    end;
if tx<>1 then ret:=ret*(tx-1)div tx;
ret:=ret mod base;
phi:=ret;
end;
procedure work;
var i:longint;
begin
sum:=0;
for i:=1 to trunc(sqrt(m)) do
    begin
    if m mod i=0 then
       begin
       sum:=(sum+phi(m div i)*pow(p,i) mod base)mod base;
       if i*i<>m then
          sum:=(sum+phi(i)*pow(p,m div i) mod base)mod base;
       end;
    end;
sum:=sum*pow(m,base-2) mod base;
end;
function mul(a,b:rec):rec;
var i,j,k:longint;
begin
fillchar(f,sizeof(f),0);
f.r:=a.r; f.c:=b.c;
for i:=1 to f.r do
    for j:=1 to f.c do
        for k:=1 to a.c do
            begin
            f.x[i][j]:=(f.x[i][j]+a.x[i][k]*b.x[k][j] mod base)mod base;
            end;
mul:=f;
end;
function calc(a:rec;y:int64):rec;
begin
if y=1 then exit(a);
dec(y);
fillchar(ret,sizeof(ret),0);
ret:=a;
now:=a;
while y>0 do
  begin
  if y mod 2=1 then ret:=mul(ret,now);
  now:=mul(now,now);
  y:=y div 2;
  end;
calc:=ret;
end;
begin
assign(input,'love.in');
reset(input);
assign(output,'love.out');
rewrite(output);
readln(n,m,p);
work;
a.x[1][1]:=sum*(sum-1)mod base; a.x[1][2]:=sum*(sum-1) mod base;
if a.x[1][2]<0 then a.x[1][2]:=a.x[1][2]+base;
a.x[1][2]:=a.x[1][2]*(sum-2)mod base;
if a.x[1][2]<0 then a.x[1][2]:=a.x[1][2]+base;
a.r:=1; a.c:=2;
b.x[1][1]:=0; b.x[1][2]:=sum-1;
b.x[2][1]:=1; b.x[2][2]:=sum-2;
b.r:=2; b.c:=2;
if n=1 then writeln(sum mod base)
   else if n=2 then begin tmp:=sum*(sum-1)mod base; if tmp<0 then tmp:=tmp+base; writeln(tmp); end
           else if n=3 then
                   begin
                   tmp:=sum*(sum-1)mod base;
                   if tmp<0 then tmp:=tmp+base;
                   tmp:=tmp*(sum-2)mod base;
                   if tmp<0 then tmp:=tmp+base;
                   writeln(tmp);
                   end
                else begin
                     mat:=calc(b,n-3);
                     ans:=mul(a,mat);
                     writeln(ans.x[1][2] mod base);
                     end;
close(input);
close(output);
end.