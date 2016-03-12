var
  n:longint;
begin
  assign(input,'numfull.in'); reset(input);
  assign(output,'numfull.out'); rewrite(output);
  readln(n);
  if (n mod 4<>0)and((n+1) mod 4<>0) then writeln('No');
  close(input); close(output);
end.