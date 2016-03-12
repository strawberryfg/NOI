const maxn=1020;
var i,j,k,l,len,n:longint;
    pow:array[-1..maxn]of qword;
    p,ans:qword;
    f:array[0..maxn,0..maxn]of qword;
begin
assign(input,'brick.in');
reset(input);
assign(output,'brick.out');
rewrite(output);
readln(n,p);
pow[0]:=1;
for i:=1 to n+1 do pow[i]:=pow[i-1]*qword(2) mod p;
pow[-1]:=1;
for i:=1 to n do
    for j:=1 to i do
        f[i][j]:=pow[i-j-1];
for i:=1 to n do
    for j:=1 to i do
        begin
        for k:=1 to n-i do
            for l:=1 to k do
                begin
                len:=j+k-1;
                f[i+k][l]:=(f[i+k][l]+f[i][j]*pow[k-l-1] mod p*len mod p) mod p;
                end;
        end;
ans:=0;
for i:=1 to n do ans:=(ans+f[n][i]) mod p;
writeln(ans);
close(input);
close(output);
end.
