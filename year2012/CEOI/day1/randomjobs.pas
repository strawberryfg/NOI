var n,d,m,i,t:longint;
begin
assign(input,'randomjobs.in');
reset(input);
assign(output,'jobs.in');
rewrite(output);
randomize;
readln(n,d,m);
writeln(n,' ',d,' ',m);
for i:=1 to m do
    begin
    t:=random(n)+1;
    while t>n-d do t:=random(n)+1;
    write(t,' ');
    end;
writeln;
close(input);
close(output);
end.
