var n,i,j,k,s123,s213,s321,s312,s132,s231,ss:longint;
    a:array[1..10000] of longint;
procedure print(u:longint);
var i:longint;
  begin
    write(u div ss,'.'); u:=u mod ss;
    for i:=1 to 20 do
      begin
        u:=u*10;
        write(u div ss);
        u:=u mod ss;
      end;
    writeln;
  end;
begin
  assign(input,'shape.in');
  assign(output,'shape.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do read(a[i]);
  for i:=1 to n do
    for j:=i+1 to n do
      for k:=j+1 to n do
        begin
          if (a[i]<a[j]) and (a[j]<a[k]) then inc(s123);
          if (a[i]<a[k]) and (a[k]<a[j]) then inc(s132);
          if (a[j]<a[i]) and (a[i]<a[k]) then inc(s213);
          if (a[k]<a[i]) and (a[i]<a[j]) then inc(s231);
          if (a[j]<a[k]) and (a[k]<a[i]) then inc(s312);
          if (a[k]<a[j]) and (a[j]<a[i]) then inc(s321);
        end;
  ss:=s123+s132+s213+s231+s312+s321;

  print(s123);
  print(s132);
  print(s213);
  print(s231);
  print(s312);
  print(s321);
  close(input);
  close(output);

end.