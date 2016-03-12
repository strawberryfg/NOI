var n,m,t:longint;
    f:array[0..20,0..1020]of longint;
procedure work;
var i,j,p:longint;
begin
for i:=1 to n do f[i][0]:=0;
for i:=1 to m do f[1][i]:=i;
for i:=2 to n do
    begin
    f[i][1]:=1; p:=0;
    for j:=2 to m do
        begin
        if f[i][p]>=f[i-1][j-p-1] then f[i][j]:=f[i][j-1]
           else begin f[i][j]:=f[i][j-1]+1; p:=j-1; end;
        end;
    end;
writeln(f[n][m]);
end;
begin
{assign(input,'egga1.in');
reset(input);
assign(output,'egga1.out');
rewrite(output);}
readln(n,m);
while (n<>0)and(m<>0) do
  begin
  t:=trunc(ln(m)/ln(2))+1;
  if n>=t then writeln(t)
     else begin
          if f[n][m]<>0 then writeln(f[n][m])
             else work;
          end;
  readln(n,m);
  end;
{close(input);
close(output);}
end.