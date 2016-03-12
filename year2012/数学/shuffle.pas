var n,m,posi,base,d:qword;
    t,x,y,x0:int64;
function pow(std:qword; y:qword):qword;
var ret:qword;
begin
ret:=1;
while y>0 do
  begin
  if y mod 2=1 then ret:=ret*std mod base;
  y:=y div 2; if y=0 then break;
  std:=std*std mod base;
  end;
exit(ret);
end;
procedure euclid(a,b:qword);
var tmp:int64;
begin
if b=0 then begin x:=1; y:=0; d:=a; exit; end;
euclid(b,a mod b);
tmp:=x;
x:=y;
y:=tmp-a div b*y;
end;
begin
assign(input,'shuffle.in');
reset(input);
assign(output,'shuffle.out');
rewrite(output);
readln(n,m,posi);
base:=n+1;
t:=pow(2,m);
euclid(t,n+1);
x0:=x*(posi div d);
while x0<0 do x0:=x0+(n+1) div d;
while x0>(n+1) div d do x0:=x0-(n+1) div d;
writeln(x0);
close(input);
close(output);
end.