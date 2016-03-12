//13:43; 14:45; 15:52;
const base=10000;
type arr=array[-1..100]of longint;
var k,block:longint;
    pow:array[0..111]of arr;
    f:array[0..111]of arr;
    one,two,ll,rr,mid,ans:arr;
operator +(a,b:arr) c:arr;
var i,fmax:longint;
begin
if a[-1]>b[-1] then fmax:=a[-1] else fmax:=b[-1];
fillchar(c,sizeof(c),0);
for i:=0 to fmax do
    begin
    c[i]:=c[i]+a[i]+b[i];
    c[i+1]:=c[i+1]+c[i] div base;
    c[i]:=c[i] mod base;
    end;
if c[fmax+1]<>0 then inc(fmax); c[-1]:=fmax;
end;
operator -(a,b:arr) c:arr;
var i,fmax:longint;
begin
if a[-1]>b[-1] then fmax:=a[-1] else fmax:=b[-1];
fillchar(c,sizeof(c),0);
for i:=0 to fmax do
    begin
    c[i]:=c[i]+a[i]-b[i];
    if c[i]<0 then begin c[i+1]:=c[i+1]-1; c[i]:=c[i]+base; end;
    end;
if (fmax<>0)and(c[fmax]=0) then dec(fmax);
c[-1]:=fmax;
end;
operator *(a,b:arr) c:arr;
var i,j,t,fmax:longint;
begin
fmax:=a[-1]+b[-1];
fillchar(c,sizeof(c),0);
for i:=0 to a[-1] do
    for j:=0 to b[-1] do
        begin
        c[i+j]:=c[i+j]+a[i]*b[j];
        t:=i+j;
        while c[t]>=base do begin if t>fmax then fmax:=t; c[t+1]:=c[t+1]+c[t] div base; c[t]:=c[t] mod base; inc(t); end;
        end;
if c[fmax+1]<>0 then inc(fmax);
c[-1]:=fmax;
end;
operator /(a,b:arr) c:arr;
var yu,i,t:longint;
begin
yu:=0;
fillchar(c,sizeof(c),0);
for i:=a[-1] downto 0 do
    begin
    t:=yu*base+a[i];
    if t>=b[0] then begin c[i]:=t div b[0]; yu:=t mod b[0]; end;
    end;
i:=a[-1];
while c[i]=0 do dec(i);
c[-1]:=i;
end;
operator <=(a,b:arr) ret:boolean;
var i:longint;
begin
if a[-1]<b[-1] then ret:=true
   else if a[-1]>b[-1] then ret:=false
           else begin
                ret:=true;
                for i:=a[-1] downto 0 do
                    if a[i]>b[i] then begin ret:=false; break; end
                       else if a[i]<b[i] then break;
                end;
end;
procedure init;
var i:longint;
begin
pow[0][0]:=1;
for i:=1 to k do pow[i]:=pow[i-1]+pow[i-1];
f[0][0]:=0;
for i:=1 to k do f[i]:=f[i-1]+f[i-1]+pow[i-1];
one[-1]:=0; one[0]:=1; two[-1]:=0; two[0]:=2;
end;
function count(x:arr):arr;
var res,cur:arr; i:longint;
begin
fillchar(res,sizeof(res),0);
fillchar(cur,sizeof(cur),0);
cur[0]:=0;
for i:=k downto 0 do
    begin
    if pow[i]<=x then
       begin
       res:=res+f[i]+pow[i]*cur;
       x:=x-pow[i];
       cur:=cur+one;
       end;
    end;
res:=res+cur;
exit(res);
end;
function calc(s:arr):arr;
var res,cur:arr; i:longint;
begin
fillchar(res,sizeof(res),0);
fillchar(cur,sizeof(cur),0);
for i:=k downto 0 do
    begin
    if f[i]+pow[i]*cur<=s then
       begin
       res:=res+pow[i];
       s:=s-(f[i]+pow[i]*cur);
       cur:=cur+one;
       end;
    end;
if cur<=s then res:=res+one;
res:=res-one;
exit(res);
end;
function check(s:arr):boolean;
var cnt:longint; st,en:arr;
begin
fillchar(st,sizeof(st),0);
st[0]:=1; cnt:=0;
while st<=pow[k]-one do
  begin
  en:=calc(count(st-one)+s);
  inc(cnt);
  if cnt>block then exit(false);
  st:=en+one;
  end;
exit(true);
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
begin
{assign(input,'sequence.in');
reset(input);
assign(output,'sequence.out');
rewrite(output);}
readln(k,block);
init;
ll[0]:=0; rr:=count(pow[k]-one);
while ll<=rr do
  begin
  mid:=(ll+rr)/two;
  if check(mid) then begin ans:=mid; rr:=mid-one; end else ll:=mid+one;
  end;
print(ans);
{close(input);
close(output);}
end.