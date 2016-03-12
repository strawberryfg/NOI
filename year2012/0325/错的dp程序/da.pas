const p=1000000007;
var n,i,j,k,tot,tmp:longint;
    b:array[1..4,1..4,1..4]of longint;
    f,tf:array[1..4,1..4,1..4]of int64;
    c:array[0..20,1..3]of longint;
    sum:array[0..100000]of int64;
    ans,res:int64;
begin
assign(output,'e:\work\da.out');
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
f[1][3][1]:=1;
f[1][4][1]:=1;
f[1][4][2]:=1;
f[2][3][2]:=1;
f[2][4][2]:=1;
f[3][1][3]:=1;
f[3][1][4]:=1;
f[3][2][3]:=1;
f[3][2][4]:=1;
f[4][1][4]:=1;
f[4][2][4]:=1;
f[2][4][1]:=1;
f[4][1][3]:=1;
f[4][2][3]:=1;
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
    res:=0;
    for j:=1 to tot do
        begin
        for k:=1 to 4 do
            begin
            if b[c[j][2]][c[j][3]][k]=1 then
               begin
               f[c[j][2]][c[j][3]][k]:=(f[c[j][2]][c[j][3]][k]+tf[c[j][1]][c[j][2]][c[j][3]])mod p;
               res:=(res+tf[c[j][1]][c[j][2]][c[j][3]])mod p;
               end;
            end;
        end;
    tmp:=i div 10000; if i mod 10000<>0 then inc(tmp);
    sum[tmp]:=(sum[tmp]+res)mod p;
    tf:=f;
    end;
for i:=1 to tot do
    ans:=(ans+f[c[i][1]][c[i][2]][c[i][3]])mod p;
tmp:=n div 10000;
if n mod 10000<>0 then inc(tmp);
for i:=1 to tmp do
    write(sum[i],',');
writeln;
close(output);
end.