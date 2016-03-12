var a,b,d,x,y:longint;
function gcd(a,b:longint):longint;
var tmp:longint;
begin
if b=0 then begin x:=1; y:=0; exit(a); end;
gcd:=gcd(b,a mod b);
tmp:=x;
x:=y;
y:=tmp-a div b*y;
end;
begin
assign(input,'pour.in');
reset(input);
assign(output,'pour.out');
rewrite(output);
readln(a,b);
x:=0; y:=0; d:=gcd(a,b);
writeln(d);
while (x>0)or(y<0) do
  begin
  x:=x-b div d;
  y:=y+a div d;
  end;
writeln(-x,' ',y);
close(input);
close(output);
end.