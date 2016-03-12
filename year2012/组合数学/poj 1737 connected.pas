type arr=array[-1..1000]of longint;
var i,j,k,maxx,cnt:longint;
    std,c,res:arr;
    g:array[0..1300]of arr;
    flag:array[0..1300]of longint;
    que:array[0..30000]of longint;
    f:array[0..100]of arr;
    com:array[0..52,0..52]of arr;
function mul(x,y:arr):arr;
var max,i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
max:=x[-1]+y[-1];
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+x[i]*y[j];
        k:=i+j;
        while c[k]>=10000 do begin if k>max then max:=k; c[k+1]:=c[k+1]+c[k] div 10000; c[k]:=c[k] mod 10000; inc(k); end;
        end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
mul:=c;
end;
function add(x,y:arr):arr;
var i,max:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]+y[i];
    c[i+1]:=c[i+1]+c[i] div 10000;
    c[i]:=c[i] mod 10000;
    end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
add:=c;
end;
function decline(x,y:arr):arr;
var i,k,max:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]-y[i];
    if c[i]<0 then begin c[i+1]:=c[i+1]-1; c[i]:=c[i]+10000; end;
    end;
k:=max; while c[k]=0 do dec(k);
max:=k;
c[-1]:=max;
decline:=c;
end;
function pow(x:longint):arr;
var xx:longint;
begin
xx:=x;
if flag[x]<>0 then exit(g[x]);
pow[-1]:=0; pow[0]:=2; dec(x);
fillchar(std,sizeof(std),0); std[0]:=2;
while x>0 do
  begin
  if x mod 2=1 then pow:=mul(pow,std);
  std:=mul(std,std);
  x:=x div 2;
  end;
g[xx]:=pow; flag[xx]:=1;
end;
procedure print(x:arr);
var i:longint;
begin
write(x[x[-1]]);
for i:=x[-1]-1 downto 0 do
    begin
    if x[i]>999 then write(x[i])
       else if x[i]>99 then write('0',x[i])
               else if x[i]>9 then write('00',x[i])
                       else write('000',x[i]);
    end;
writeln;
end;
begin
{assign(input,'connected.in');
reset(input);
assign(output,'connected.out');
rewrite(output);}
i:=1;
readln(que[1]);
maxx:=0;
while que[i]<>0 do
  begin
  if que[i]>maxx then maxx:=que[i];
  inc(i);
  readln(que[i]);
  end;
cnt:=i-1;
f[1][0]:=1; f[2][0]:=1;
flag[0]:=1; g[0][0]:=1;
for i:=1 to maxx do
    begin
    com[i][0][0]:=1; com[i][i][0]:=1; com[i][1][0]:=i; com[i][i-1][0]:=i;
    for j:=2 to i-2 do com[i][j]:=add(com[i-1][j],com[i-1][j-1]);
    end;
for i:=3 to maxx do
    begin
    f[i]:=pow(i*(i-1) div 2);
    fillchar(res,sizeof(res),0);
    for k:=1 to i-1 do
        res:=add(res,mul(mul(f[k],com[i-1][k-1]),pow((i-k)*(i-k-1) div 2)));
    f[i]:=decline(f[i],res);
    end;
for i:=1 to cnt do print(f[que[i]]);
{close(input);
close(output);}
end.