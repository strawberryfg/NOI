var n,k,x,res,t,all,tmp:qword;
    i,j,p,sum,len,now,pd,down,up:longint;
    f:array[0..19,0..171]of qword;
    num,sta,ans:array[0..19]of longint;
    pow:array[0..19]of qword;
function calc(med,remain:longint):qword; //0-10^med-1
var i:longint;
begin
if remain<0 then exit(0);
if med=0 then begin if remain<>0 then exit(0) else exit(1); end;
if remain=0 then exit(1);
if med=1 then begin if remain<=9 then exit(1) else exit(0); end;
exit(f[med][remain]);
end;
function dp(n:qword; acc,opt:longint):qword;
//<=n all digits equal to acc
var x,ret:qword; now,i,j,cnt,st:longint;
begin
x:=n; cnt:=0; while x>0 do begin inc(cnt); num[cnt]:=x mod 10; x:=x div 10; end;
for i:=1 to cnt div 2 do begin num[i]:=num[i]+num[cnt+1-i]; num[cnt+1-i]:=num[i]-num[cnt+1-i]; num[i]:=num[i]-num[cnt+1-i]; end;
now:=0; ret:=0;
for i:=1 to cnt do
    begin
    if i=1 then st:=opt else st:=0;
    for j:=st to num[i]-1 do ret:=ret+calc(cnt-i,acc-now-j);
    now:=now+num[i];
    end;
if now=acc then inc(ret);
exit(ret);
end;
begin
{assign(input,'order.in');
reset(input);
assign(output,'order.out');
rewrite(output);}
pow[0]:=1;
for i:=1 to 19 do pow[i]:=pow[i-1]*10;
f[0][0]:=1;
for i:=1 to 19 do
    for j:=0 to 171 do
        for p:=0 to 9 do
            if j>=p then
               f[i][j]:=f[i][j]+f[i-1][j-p];
readln(n,k);
while (n<>0)or(k<>0) do
  begin
  x:=k; sum:=0; t:=1;
  while x>0 do begin sum:=sum+x mod 10; t:=t*10; x:=x div 10; end;
  if t<>1 then t:=t div 10;
  len:=0;
  x:=n; while x>0 do begin inc(len); sta[len]:=x mod 10; x:=x div 10; end;
  for i:=1 to len div 2 do begin sta[i]:=sta[i]+sta[len+1-i]; sta[len+1-i]:=sta[i]-sta[len+1-i]; sta[i]:=sta[i]-sta[len+1-i]; end;
  res:=0;
  for i:=1 to sum-1 do res:=res+dp(n,i,0);
  x:=k;
  while x>0 do
    begin
    if x<>k then res:=res+dp(x,sum,1)
       else if k<>t then res:=res+dp(x-1,sum,1); //x=k;
    x:=x div 10;
    end;
  x:=k*10; t:=t*10;
  while x<=n do
    begin
    if x<>t then res:=res+dp(x-1,sum,1);
    x:=x*10; t:=t*10;
    end;
  if x<pow[len] then res:=res+dp(n,sum,1);
  write(res+1,' ');
  all:=0;
  for i:=1 to 171 do
      begin
      res:=dp(n,i,0);
      if res<k-all then all:=all+res else begin sum:=i; break; end;
      end;
  // sum of digits is i;
  pd:=0; now:=0;
  for i:=1 to len do ans[i]:=-1;
  for i:=1 to len do
      begin
      if i=1 then down:=1 else down:=0;
      if i=len then begin if pd=-1 then up:=9 else up:=sta[i]; end else up:=9;
      for j:=down to up do
          begin
          tmp:=all;
          if now+j=sum then inc(tmp);
          if tmp>=k then begin ans[i]:=j; inc(all); break; end;
          for p:=i+1 to len-1 do
              begin
              res:=dp(pow[p-i]-1,sum-now-j,0);
              if res<k-tmp then tmp:=tmp+res else begin ans[i]:=j; break; end;
              end;
          if ans[i]<>-1 then begin if now+j=sum then inc(all); break; end;
          if (i<>len)and(pd<>1) then
             begin
             if (pd=-1)or(j<sta[i]) then
                begin
                res:=dp(pow[len-i]-1,sum-now-j,0);
                if res<k-tmp then tmp:=tmp+res else ans[i]:=j;
                end
             else if (pd=0)and(j=sta[i]) then
                     begin
                     res:=dp(n mod pow[len-i],sum-now-j,0);
                     if res<k-tmp then tmp:=tmp+res else ans[i]:=j;
                     end;
             end;
          if ans[i]<>-1 then begin if now+j=sum then inc(all); break; end;
          all:=tmp;
          end;
      if pd=0 then begin if ans[i]<sta[i] then pd:=-1 else if ans[i]>sta[i] then pd:=1; end;
      now:=now+ans[i];
      if all=k then break;
      end;
  i:=len; while ans[i]=-1 do dec(i);
  for j:=1 to i do write(ans[j]);
  writeln;
  readln(n,k);
  end;
{close(input);
close(output);}
end.