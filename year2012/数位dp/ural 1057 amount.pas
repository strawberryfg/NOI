var l,r,need,hex:longint;
    f:array[0..35,0..35]of longint;
    num:array[0..111]of longint;
procedure init;
var i,j:longint;
begin
f[0][0]:=1;
for i:=1 to 31 do
    begin
    f[i][0]:=1;
    for j:=1 to i do f[i][j]:=f[i-1][j]+f[i-1][j-1];
    end;
end;
function calc(x:longint):longint;
var cnt,sum,ret,i,j:longint;
begin
if x=0 then exit(0);
cnt:=0;
while x>0 do begin inc(cnt); num[cnt]:=x mod hex; x:=x div hex; end;
for i:=cnt downto 1 do if num[i]>1 then begin for j:=i downto 1 do num[j]:=1; break; end;
sum:=0;
ret:=0;
for i:=cnt downto 1 do
    begin
    if num[i]=1 then
       begin
       ret:=ret+f[i-1][need-sum];
       inc(sum);
       if sum>need then break;
       end;
    end;
sum:=0;
for i:=1 to cnt do if num[i]=1 then inc(sum);
if sum=need then inc(ret);
exit(ret);
end;
begin
{assign(input,'amount.in');
reset(input);
assign(output,'amount.out');
rewrite(output);}
init;
readln(l,r);
readln(need);
readln(hex);
writeln(calc(r)-calc(l-1));
{close(input);
close(output);}
end.