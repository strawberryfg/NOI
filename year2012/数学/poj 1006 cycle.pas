var n,m1,m2,m3,n1,n2,n3,x,y,om1,om2,om3,c1,c2,c3,test,a1,a2,a3,day,ans:longint;
procedure euclid(p,q:longint);
var tmp:longint;
begin
if q=0 then begin x:=1; y:=0; exit; end;
euclid(q,p mod q);
tmp:=x;
x:=y;
y:=tmp-p div q*y;
end;
begin
{assign(input,'cycle.in');
reset(input);
assign(output,'cycle.out');
rewrite(output);}
n:=21252; m1:=924; m2:=759; m3:=644; n1:=23; n2:=28; n3:=33;
x:=0; y:=0;
euclid(m1,n1);
om1:=x;
x:=0; y:=0;
euclid(m2,n2);
om2:=x;
x:=0; y:=0;
euclid(m3,n3);
om3:=x;
c1:=m1*(om1 mod n1);
c2:=m2*(om2 mod n2);
c3:=m3*(om3 mod n3);
read(a1,a2,a3,day);
test:=0;
while (a1<>-1)and(a2<>-1)and(a3<>-1)and(day<>-1) do
  begin
  inc(test);
  ans:=(a1*c1+a2*c2+a3*c3-day) mod n;
  ans:=(ans+n) mod n;
  if ans=0 then ans:=n;
  writeln('Case ',test,': the next triple peak occurs in ',ans,' days.');
  read(a1,a2,a3,day);
  end;
{close(input);
close(output);}
end.