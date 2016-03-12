const maxn=100; inf=maxlongint;
var a,b,c,i,j,k:longint;
    f:array[0..maxn,0..maxn,0..maxn]of longint;
function calc(a,b,c:longint):longint;
var i,res:longint;
begin
if f[a][b][c]<>-inf then exit(f[a][b][c]);
for i:=a+1 to b-1 do
    begin
    res:=calc(a,i,b);
    if res+1>f[a][b][c] then f[a][b][c]:=res+1;
    end;
for i:=b+1 to c-1 do
    begin
    res:=calc(b,i,c);
    if res+1>f[a][b][c] then f[a][b][c]:=res+1;
    end;
if f[a][b][c]=-inf then f[a][b][c]:=0;
calc:=f[a][b][c];
end;
begin
{assign(input,'c.in');
reset(input);
assign(output,'c.out');
rewrite(output);}
readln(a,b,c);
for i:=1 to 100 do
    for j:=1 to 100 do
        for k:=1 to 100 do
            f[i][j][k]:=-inf;
writeln(calc(a,b,c));
{close(input);
close(output);}
end.
