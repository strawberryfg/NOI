var test,n,k,t:longint;
begin
{assign(input,'g.in');
reset(input);
assign(output,'d:\wqf\g.out');
rewrite(output);}
readln(test);
while test>0 do
  begin
  dec(test);
  readln(k,n);
  if n mod 2=1 then
     begin
     if k mod 2=1 then writeln(1) else writeln(0);
     continue;
     end;
  if n=2 then
     begin
     if k mod 3=1 then writeln(1) else if k mod 3=2 then writeln(2) else writeln(0);
     continue;
     end;
  t:=k mod (n+1); if t=0 then t:=n+1;
  if t<=(n div 2-1)*2 then
     begin
     if t mod 2=1 then writeln(1) else writeln(0);
     continue;
     end;
  if t=n+1 then writeln(0) else if t=n then writeln(n) else writeln(1);
  end;
{close(input);
close(output);}
end.