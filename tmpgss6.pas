const max=10000;
var sum,n,q,i,t,p,qq:longint;
    b:array[0..2]of longint;
begin
assign(output,'gss6.in');
rewrite(output);
randomize;
readln(n,qq);
writeln(n);
b[0]:=1; b[1]:=-1;
for i:=1 to n do
    begin
    t:=random(2);
    if t=0 then write('-');
    p:=random(max)+1;
    write(p,' ');
    end;
writeln;
writeln(qq);
sum:=n;
for i:=1 to qq do
    begin
    t:=random(4);
    if t=0 then
       begin
       p:=random(sum+1)+1;
       writeln('I ',p,' ',random(max)*b[random(q)]);
       inc(sum);
       end
    else if t=1 then
           begin
           p:=random(sum)+1;
           writeln('R ',p,' ',random(max)*b[random(q)]);

           end
        else if t=2 then
                begin
                p:=random(sum)+1;
                t:=random(sum-p);
                writeln('Q ',p,' ',p+t);
                end
            else begin
                 p:=random(sum)+1;
                 writeln('D ',p);
                 dec(sum);
                 end;
    end;
close(output);
end.