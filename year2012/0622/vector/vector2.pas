const maxn=1000;  maxx=500000000;
var n,i,j,k:longint;
    a:array[0..maxn,0..4]of longint;
    c:array[0..maxn]of longint;
    sta,b:array[0..maxn]of longint;
    sum,ans:int64;
begin
assign(input,'d:\vector\vector4.in');
reset(input);
assign(output,'d:\aa\vector4.out');
rewrite(output);
randomize;
readln(n);
for i:=1 to n do for j:=1 to 4 do read(a[i][j]);
for i:=1 to maxx div n do
    begin
    for j:=1 to n do b[j]:=random(2);
    for j:=1 to n do c[j]:=0;
    for j:=1 to n do
        for k:=1 to 4 do
            if b[j]=0 then c[k]:=c[k]+a[j][k]
               else c[k]:=c[k]-a[j][k];
    sum:=0;
    for j:=1 to 4 do
        sum:=sum+int64(c[j])*c[j];
    if sum>ans then begin ans:=sum; for j:=1 to n do sta[j]:=b[j]; end;
    end;
for i:=1 to n do if sta[i]=0 then writeln(1) else writeln(-1);
writeln(ans);
close(input);
close(output);
end.
