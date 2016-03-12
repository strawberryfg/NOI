var s,s1,ts:ansistring;
    cnt,t:longint;
begin
assign(input,'e:\color\tmpcolor\color.out');
reset(input);
assign(output,'e:\color\stdcolor\color.pas');
rewrite(output);
readln(s);
t:=pos('(',s);
s1:=copy(s,1,t);
delete(s,1,t);
t:=pos(',',s);
write(s1);
while t<>0 do
  begin
  ts:=copy(s,1,t);
  write(ts);
  inc(cnt);
  if cnt mod 10=0 then writeln;
  delete(s,1,t);
  t:=pos(',',s);
  end;
write(s);
writeln;
close(input);
close(output);
end.