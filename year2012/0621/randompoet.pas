const maxlen=30;
var n,l,p,i,j,len,test,kk:longint;
begin
assign(input,'randompoet.in');
reset(input);
assign(output,'poet.in');
rewrite(output);
randomize;
readln(test);
writeln(test);
for kk:=1 to test do
begin
readln(n,l,p);
writeln(n,' ',l,' ',p);
for i:=1 to n do
    begin
    len:=random(maxlen)+1;
    for j:=1 to len do write(char(random(26)+ord('a')));
    writeln;
    end;
end;
close(input);
close(output);
end.
