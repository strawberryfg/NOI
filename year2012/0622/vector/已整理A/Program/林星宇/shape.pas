const maxn=101111;
var t,a,b,id,ls,lb,rs,rb:array[1..maxn] of int64;
    ans1,ans2,ans3,ans4,ans5,ans6,sum1,sum2,sum3,sum4,sum:int64;
    n,i,tot:longint;
    flag:boolean;

procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
  i:=l; j:=r;
  x:=a[(l+r) div 2];
  repeat
    while a[i]<x do inc(i);
    while x<a[j] do dec(j);
    if not(i>j) then
      begin
        y:=a[i]; a[i]:=a[j]; a[j]:=y;
        y:=id[i]; id[i]:=id[j]; id[j]:=y;
        inc(i); dec(j);
      end;
  until i>j;
  if l<j then sort(l,j);
  if i<r then sort(i,r);
end;
procedure prepare;
begin
 flag:=true;
 for i:=1 to n do id[i]:=i;
 sort(1,n);tot:=0;
 for i:=1 to n do
   begin
     if (i=1) or (a[i]<>a[i-1]) then inc(tot);
     if (i<>1) and (a[i]=a[i-1]) then flag:=false;
     b[id[i]]:=tot;
   end;
 sum1:=0;sum2:=0;sum3:=0;sum4:=0;
 ans1:=0;ans2:=0;ans3:=0;ans4:=0;ans5:=0;ans6:=0;
end;
procedure modify(x,delta:longint);
begin
 while x<=tot do
   begin
     inc(t[x],delta);
     x:=x+(x and -x);
   end;
end;
function query(x:longint):longint;
 var tsum:int64;
begin
 tsum:=0;
 while x>0 do
   begin
     inc(tsum,t[x]);
     dec(x,x and -x);
   end;
 exit(tsum);
end;
procedure workforall;
 var i:longint;
begin
  fillchar(t,sizeof(t),0);
  for i:=n downto 1 do
    begin
      modify(b[i],1);
      rs[i]:=query(b[i]-1);
      rb[i]:=query(tot)-query(b[i]);
    end;
  fillchar(t,sizeof(t),0);
  for i:=1 to n do
    begin
      modify(b[i],1);
      ls[i]:=query(b[i]-1);
      lb[i]:=query(tot)-query(b[i]);
    end;
  for i:=1 to n do
    begin
      sum1:=sum1+rb[i]*(rb[i]-1) div 2;
      sum2:=sum2+rs[i]*(rs[i]-1) div 2;
      sum3:=sum3+lb[i]*rb[i];
      sum4:=sum4+ls[i]*rs[i];
      ans1:=ans1+ls[i]*rb[i];
      ans6:=ans6+lb[i]*rs[i];
    end;
end;
procedure divide(x,y:int64);
 var cnt,j:longint;
begin
 cnt:=0;
 write('0.');
 x:=x*10;
 while cnt<20 do
   begin
     j:=0;
     while y*(j+1)<x do inc(j);
     write(j);
     x:=(x-y*j)*10;
     inc(cnt);
   end;
 writeln;
end;

procedure forcebrute;
 var i,j:longint;
     tt,tmp:int64;
begin
  ans2:=0;ans3:=0;ans4:=0;ans5:=0;
  for i:=1 to n do
    begin
      tt:=0; tmp:=0;
      for j:=i-1 downto 1 do
        if b[i]<>b[j] then
          begin
            if b[j]>b[i] then inc(tt)
                         else inc(tmp,tt);
          end;
      inc(ans2,tmp); inc(ans5,ls[i]*lb[i]-tmp);
    end;
  for i:=n downto 1 do
    begin
      tt:=0; tmp:=0;
      for j:=i+1 to n do
        if b[j]<>b[i] then
           begin
             if b[j]>b[i] then inc(tt)
                          else inc(tmp,tt);
           end;
      inc(ans4,tmp); inc(ans3,rs[i]*rb[i]-tmp);
    end;
end;

begin
assign(input,'shape.in');reset(input);
assign(output,'shape.out');rewrite(output);
 readln(n);
 for i:=1 to n do read(a[i]); readln;
 prepare;
 workforall;
 ans2:=sum1-ans1;
 ans5:=sum2-ans6;
 ans3:=sum3-ans5;
 ans4:=sum4-ans2;
 if not flag then forcebrute;
 sum:=ans1+ans2+ans3+ans4+ans5+ans6;
 divide(ans1,sum);
 divide(ans2,sum);
 divide(ans3,sum);
 divide(ans4,sum);
 divide(ans5,sum);
 divide(ans6,sum);
close(input);close(output);
end.
