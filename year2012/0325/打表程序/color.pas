const p=1000000007;
      maxn=100000;
var now,ans:int64;
    l,r,i,x:longint;
    sum:array[0..maxn]of int64;
function pow(a,b:longint):int64;
var t:longint;
    d,res:int64;
begin
t:=b;
d:=a;
res:=1;
while t>0 do
  begin
  if t mod 2=1 then res:=res*d mod p;
  t:=t div 2;
  d:=d*d mod p;
  end;
exit(res);
end;
function work2(x:longint):int64;
var tmp:int64;
begin
if (x div 2)mod 2=1 then
   begin
   tmp:=pow(3,(x div 2-1)div 2)*4 mod p;
   exit(tmp);
   end
else
   begin
   tmp:=pow(3,(x div 2-2)div 2)*7 mod p;
   exit(tmp);
   end;
end;
function work(x:longint):int64;
var tmp,fu:int64;
begin
if x mod 2=0 then
   begin
   tmp:=pow(3,(x-2)div 2)*4 mod p;
   exit(tmp);
   end
else
   begin
   tmp:=pow(3,(x-3)div 2)*7 mod p;
   fu:=work2(x);
   tmp:=(tmp+fu)mod p;
   exit(tmp);
   end;
end;
begin
assign(input,'color.in');
reset(input);
assign(output,'color.out');
rewrite(output);
readln(l,r);
for i:=l to r do
    begin
    if i=1 then now:=4 else now:=work(i);
//    writeln(i,':',now);
    x:=i div 10000;
    if i mod 10000<>0 then inc(x);
    sum[x]:=(sum[x]+now)mod p;
    ans:=(ans+now)mod p;
    end;
x:=r div 10000;
if r mod 10000<>0 then inc(x);
write('..',x,']');
write('=(');
for i:=1 to x-1 do write(sum[i],',');
write(sum[x],')');
writeln;
//writeln(ans);
close(input);
close(output);
end.
