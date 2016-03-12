const maxnum=50020; base=10000; maxn=8000;
type arr=array[-1..2300]of longint;
var a:array[0..maxnum]of boolean;
    prime:array[0..maxn]of longint;
    big,small,n,x,y,t,i,j,cnt:longint;
    ans:arr;
    g:array[0..maxn]of arr;
    num:array[0..maxn]of longint;
procedure eratos;
var i,j : longint;
begin
a[1]:=false;
for i:=2 to maxnum do a[i]:=true;
for i:=2 to maxnum div 2 do if a[i] then for j:=2 to maxnum div i do a[i*j]:=false;
cnt:=0;
for i:=1 to maxnum do if a[i] then begin inc(cnt);prime[cnt]:=i; end;
end;
procedure work(x,d:longint);
var i:longint;
begin
i:=1;
while i<=cnt do
  begin
  while x mod prime[i]=0 do begin num[i]:=num[i]+d; x:=x div prime[i]; end;
  if x=1 then break;
  inc(i);
  end;
end;
operator *(x,y:arr) ret:arr;
var max,i,j,k:longint;
begin
max:=x[-1]+y[-1];
fillchar(ret,sizeof(ret),0);
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        ret[i+j]:=ret[i+j]+x[i]*y[j];
        k:=i+j;
        while ret[k]>=base do
          begin
          if k>max then max:=k;
          ret[k+1]:=ret[k+1]+ret[k] div base;
          ret[k]:=ret[k] mod base;
          inc(k);
          end;
        end;
if ret[max+1]<>0 then inc(max);
ret[-1]:=max;
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
assign(input,'start.in');
reset(input);
assign(output,'start.out');
rewrite(output);
readln(n);
readln(x,y);
if x mod 2=1 then t:=1 else t:=0;
if t mod 2<>n mod 2 then writeln(0)
   else begin
        big:=(n-x)div 2+x+y-1;
        small:=x+y-1;
        if small>big div 2 then small:=big-small;
        eratos;
        for i:=1 to small do
            work(big+1-i,1);
        for i:=1 to small do
            work(i,-1);
        ans[-1]:=0; ans[0]:=1;
        for i:=1 to cnt do
            begin
            if prime[i]>base then
               begin
               g[i][-1]:=1; g[i][0]:=prime[i] mod base; g[i][1]:=prime[i] div base;
               end
            else
               begin
               g[i][-1]:=0; g[i][0]:=prime[i];
               end;
            end;
        for i:=1 to cnt do
            begin
            if num[i]<>0 then
               for j:=1 to num[i] do
                   ans:=ans*g[i];
            end;
        print(ans);
        end;
close(input);
close(output);
end.
