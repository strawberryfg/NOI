var ll,rr,ans:longint;
    comb:array[0..100,0..100]of longint;
    a:array[0..100]of longint;
function com(x,y:longint):longint;
begin
if comb[x][y]<>0 then exit(comb[x][y]);
if (x=1)and(y=1) then exit(1);
if (y=0) then exit(1);
if x<y then exit(0);
comb[x][y]:=com(x-1,y)+com(x-1,y-1);
com:=comb[x][y];
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function work(x:longint):longint;
var len,i,j,ret,one,zero:longint;
begin
if x=0 then exit(0);
len:=0;
while x>0 do begin inc(len); a[len]:=x mod 2; x:=x div 2; end;
for i:=1 to len div 2 do begin a[i]:=a[i]+a[len+1-i]; a[len+1-i]:=a[i]-a[len+1-i]; a[i]:=a[i]-a[len+1-i]; end;
ret:=0;
for i:=1 to len-1 do
    begin
    for j:=(i+1) div 2 to i-1 do
        ret:=ret+com(i-1,j);
    end;
one:=1; zero:=0;
for i:=2 to len do
    begin
    if a[i]=1 then
       begin
       if i<>len then for j:=max((len+1) div 2-zero-1,0) to len-i do ret:=ret+com(len-i,j)
          else if zero+1>=(len+1) div 2 then inc(ret);
       end;
    if a[i]=1 then inc(one) else inc(zero);
    end;
if zero>=(len+1) div 2 then inc(ret);
work:=ret;
end;
begin
{assign(input,'rndnum.in');
reset(input);
assign(output,'rndnum.out');
rewrite(output);}
readln(ll,rr);
ans:=work(rr)-work(ll-1);
writeln(ans);
{close(input);
close(output);}
end.