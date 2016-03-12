const maxn=111;
var n,i,j,k:longint;
    per:array[0..maxn,0..maxn]of extended;
    f:array[0..maxn,0..maxn,0..maxn]of extended;
    g:array[0..maxn,0..maxn]of extended;
    h:array[0..maxn]of extended;
    ans:extended;
function p(x,y:longint):extended;
var i:longint;
begin
if per[x][y]<>0 then p:=per[x][y]
   else begin
        per[x][y]:=1;
        for i:=1 to y do per[x][y]:=per[x][y]*(x+1-i);
        p:=per[x][y];
        end;
end;
begin
{assign(input,'highlander.in');
reset(input);
assign(output,'highlander.out');
rewrite(output);}
readln(n);
for i:=2 to n do
    begin
    f[i][i][1]:=p(n,i)/i;
    for j:=2 to i-2 do
        begin
        for k:=2 to i div j do
            f[i][j][k]:=f[i-j][j][k-1]*p(n-i+j,j)/j/k;
        f[i][j][1]:=g[i-j][j-1]*p(n-i+j,j)/j;
        end;
    for j:=2 to n do
        begin
        g[i][j]:=g[i][j-1];
        if j<=i-2 then
           for k:=2 to i div j do
               g[i][j]:=g[i][j]+f[i][j][k];
        g[i][j]:=g[i][j]+f[i][j][1];
        end;
    end;
ans:=0;
for j:=2 to n-2 do
    for k:=1 to n div j do
        ans:=ans+j*k*f[n][j][k];
ans:=ans+n*f[n][n][1];
h[1]:=0; h[2]:=1;
for i:=3 to n do h[i]:=(i-1)*(h[i-1]+h[i-2]);
ans:=ans/h[n];
writeln(ans:0:12);
{close(input);
close(output);}
end.