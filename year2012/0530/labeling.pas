const maxd=100; max=5000000; maxcnt=500000;
type arr=array[-1..10000]of longint;
var k,d,now,i,j,cnt,p:longint;
    f:array[0..maxd]of arr;
    num:array[0..maxd]of longint;
    check:array[0..max]of boolean;
    prime:array[0..max]of longint;
    xx,yy:array[0..maxcnt]of longint;
    c,res,tmp:arr;
function mul(x,y:arr):arr;
var max,i,j,k:longint;
begin
max:=x[-1]+y[-1];
fillchar(c,sizeof(c),0);
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+x[i]*y[j];
        k:=i+j;
        while c[k]>=10000 do
          begin
          if k>max then max:=k;
          c[k+1]:=c[k+1]+c[k] div 10000;
          c[k]:=c[k] mod 10000;
          inc(k);
          end;
        end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
mul:=c;
end;
procedure print(x:arr);
var i:longint;
begin
write(x[x[-1]]);
for i:=x[-1]-1 downto 0 do
    if x[i]>999 then write(x[i])
       else if x[i]>99 then write('0',x[i])
               else if x[i]>9 then write('00',x[i])
                       else write('000',x[i]);
writeln;
end;
procedure init;
var i,j:longint;
begin
fillchar(check,sizeof(check),false);
cnt:=0;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>max then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then break;
        end;
    end;
end;
function convert(x:longint):arr;
begin
c[-1]:=-1;
while x>=10000 do begin inc(c[-1]); c[c[-1]]:=x div 10000; x:=x mod 10000; end;
if x<>0 then begin inc(c[-1]); c[c[-1]]:=x; end;
convert:=c;
end;
begin
assign(input,'labeling.in');
reset(input);
assign(output,'labeling.out');
rewrite(output);
readln(k,d);
f[0][-1]:=0; f[0][0]:=1;
now:=1;
num[0]:=1;
for i:=1 to d do begin now:=now*k; num[i]:=num[i-1]+now; end;
init;
for i:=1 to d do
    begin
    f[i][-1]:=0; f[i][0]:=1;
    for j:=1 to k do f[i]:=mul(f[i],f[i-1]);
    fillchar(xx,sizeof(xx),0);
    fillchar(yy,sizeof(yy),0);
    for j:=1 to cnt do
        begin
        now:=num[i]-1;
        while now div prime[j]>=1 do
          begin
          xx[j]:=xx[j]+now div prime[j];
          now:=now div prime[j];
          end;
        end;
    for j:=1 to cnt do
        begin
        now:=num[i-1];
        while now div prime[j]>=1 do
          begin
          yy[j]:=yy[j]+now div prime[j];
          now:=now div prime[j];
          end;
        end;
    for j:=1 to cnt do
        begin
        yy[j]:=yy[j]*k;
        if xx[j]>yy[j] then
           begin
           tmp:=convert(prime[j]);
           res:=tmp;
           for p:=1 to xx[j]-yy[j]-1 do
               res:=mul(res,tmp);
           f[i]:=mul(f[i],res);
           end;
        end;
    end;
print(f[d]);
close(input);
close(output);
end.