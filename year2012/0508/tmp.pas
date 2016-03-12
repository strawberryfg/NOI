var n,total,i:longint;
    res:array[0..10000000,1..2]of longint;
procedure makefarey(x1,y1,x2,y2:longint);
begin
if (x1+x2>n)or(y1+y2>n) then
   exit;
makefarey(x1,y1,x1+x2,y1+y2);
inc(total);
res[total][1]:=x1+x2;
res[total][2]:=y1+y2;
makefarey(x1+x2,y1+y2,x2,y2);
end;
begin
assign(input,'tmp.in');
reset(input);
assign(output,'tmp.out');
rewrite(output);
readln(n);
makefarey(1,0,0,1);
for i:=1 to total do writeln(res[i][1],' ',res[i][2]);
close(input);
close(output);
end.
