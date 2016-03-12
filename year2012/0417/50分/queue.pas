const maxn=320;
var n,i,j:longint;
    h:array[0..maxn]of longint;
    ans:extended;
    f:array[0..maxn]of extended;
function c(x,y:longint):extended;
var i:longint;
    res:extended;
begin
res:=1;
for i:=1 to y do
    begin
    res:=res*(x+1-i)/i;
    end;
exit(res);
end;
function p(x:longint):extended;
var i:longint;
    res:extended;
begin
res:=1;
for i:=1 to x do res:=res*i;
exit(res);
end;
function q(x:longint):extended;
var res:extended;
begin
res:=(1+x)*x/2;
exit(res);
end;
begin
assign(input,'queue.in');
reset(input);
assign(output,'queue.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    read(h[i]);
    end;
readln;
f[1]:=1;
f[2]:=5;
for i:=3 to n do
    begin
    for j:=1 to i-2 do
        begin
        f[i]:=f[i]+p(i-1-j)*c(i-1,j)*f[j]+p(j)*c(i-1,j)*f[i-1-j];
        end;
    f[i]:=f[i]+f[i-1]*2;
    f[i]:=f[i]+p(i-1)*q(i);
    end;
ans:=f[n]/p(n);
writeln(round(ans*100)/100:0:2);
close(input);
close(output);
end.