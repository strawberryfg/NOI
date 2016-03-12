const maxn=211111; base=1000000007;
var n,m,i,l,r,d,ans1,ans2:longint;
    bit:array[1..3,0..maxn]of longint;
    ch,c:char;
procedure modify(opt,x,d:longint);
begin
while x<=n do begin bit[opt][x]:=(bit[opt][x]+d) mod base; x:=x+x and -x; end;
end;
function query(opt,x:longint):longint;
var ret:longint;
begin
ret:=0;
while x>0 do begin ret:=(ret+bit[opt][x]) mod base; x:=x-x and -x; end;
exit(ret);
end;
procedure work(num,d:longint);
var tmp:qword;
begin
if num=0 then exit;
modify(1,num,d);
modify(2,num,qword(d)*qword(num) mod base);
tmp:=qword(num)*qword(num+1) div 2; tmp:=tmp mod base;
tmp:=tmp*qword(d) mod base; tmp:=(tmp+base-qword(num)*qword(num) mod base*qword(d) mod base) mod base;
modify(3,num,tmp);
end;
function calc1(num:longint):longint;
var ret:qword;
begin
if num=0 then exit(0);
ret:=0;
ret:=(ret+(query(1,n)+base-query(1,num))*qword(num)) mod base;
ret:=(ret+query(2,num)) mod base;
exit(ret);
end;
function calc2(num:longint):longint;
var ret,tmp:qword;
begin
if num=0 then exit(0);
ret:=0;
tmp:=qword(num)*qword(num+1) div 2; tmp:=tmp mod base;
ret:=(ret+(query(1,n)+base-query(1,num))*tmp) mod base;
ret:=(ret+query(2,num)*qword(num)) mod base;
ret:=(ret+query(3,num)) mod base;
exit(ret);
end;
begin
assign(input,'sum.in');
reset(input);
assign(output,'sum.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    read(ch); read(c);
    if ch='C' then
       begin
       read(l,r,d);
       work(r,d);
       work(l-1,(base-d) mod base);
       end
    else
       begin
       read(l,r);
       ans1:=(calc1(r)+base-calc1(l-1)) mod base;
       ans2:=(calc2(r)+base-calc2(l-1)) mod base;
       writeln(ans1,' ',ans2);
       end;
    readln;
    end;
close(input);
close(output);
end.