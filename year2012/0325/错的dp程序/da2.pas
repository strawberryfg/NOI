const p=1000000007;
var n,i,j,k,tot:longint;
    b:array[1..4,1..4,1..4]of longint;
    f:array[0..100000,1..4,1..4,1..4]of int64;
    c:array[0..20,1..3]of longint;
    ans,res:int64;
begin
assign(output,'e:\work\da2.out');
rewrite(output);
readln(n);
b[1][3][1]:=1;
b[1][4][1]:=1;
b[1][4][2]:=1;
b[2][3][2]:=1;
b[2][4][2]:=1;
b[3][1][3]:=1;
b[3][1][4]:=1;
b[3][2][3]:=1;
b[3][2][4]:=1;
b[4][1][4]:=1;
b[4][2][4]:=1;
b[2][4][1]:=1;
b[4][1][3]:=1;
b[4][2][3]:=1;
f[3][1][3][1]:=1;
f[3][1][4][1]:=1;
f[3][1][4][2]:=1;
f[3][2][3][2]:=1;
f[3][2][4][2]:=1;
f[3][3][1][3]:=1;
f[3][3][1][4]:=1;
f[3][3][2][3]:=1;
f[3][3][2][4]:=1;
f[3][4][1][4]:=1;
f[3][4][2][4]:=1;
f[3][2][4][1]:=1;
f[3][4][1][3]:=1;
f[3][4][2][3]:=1;
for i:=1 to 4 do
    for j:=1 to 4 do
        for k:=1 to 4 do
            if b[i][j][k]=1 then
               begin
               inc(tot);
               c[tot][1]:=i;
               c[tot][2]:=j;
               c[tot][3]:=k;
               end;
for i:=4 to n do
    begin
    for j:=1 to tot do
        begin
        for k:=1 to 4 do
            begin
            if b[c[j][2]][c[j][3]][k]=1 then
               begin
               f[i][c[j][2]][c[j][3]][k]:=(f[i][c[j][2]][c[j][3]][k]+f[i-1][c[j][1]][c[j][2]][c[j][3]])mod p;
               end;
            end;
        end;
    end;
for i:=1 to tot do
    ans:=(ans+f[n][c[i][1]][c[i][2]][c[i][3]])mod p;
for i:=1 to n do
    begin
    res:=0;
    for j:=1 to tot do
        begin
        res:=(res+f[i][c[j][1]][c[j][2]][c[j][3]])mod p;
        end;
    writeln(i,': ',res);
    end;
writeln(ans);
close(output);
end.