const maxn=3020; inf=4557430888798830399;
var n,m,i,j:longint;
    a,b,sa,sb:array[0..maxn]of int64;
    f,g,h:array[0..maxn,0..maxn]of int64;
function min(x,y:int64):int64;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'game.in');
reset(input);
assign(output,'game.out');
rewrite(output);
readln(n,m);
for i:=1 to n do begin read(a[i]); dec(a[i]); end;
for i:=1 to m do begin read(b[i]); dec(b[i]); end;
sa[0]:=0;
for i:=1 to n do sa[i]:=sa[i-1]+a[i];
sb[0]:=0;
for i:=1 to m do sb[i]:=sb[i-1]+b[i];
for i:=1 to n do
    for j:=1 to m do
        begin
        f[i][j]:=inf;
        g[i][j]:=inf;
        h[i][j]:=inf;
        g[i][0]:=inf;
        end;
f[0][0]:=0;
g[0][0]:=0;
h[0][0]:=0;
for i:=1 to m do h[0][i]:=inf;
for i:=1 to n do
    for j:=1 to m do
        begin
        f[i][j]:=min(g[i-1][j-1]+int64(a[i]*sb[j]),h[i-1][j-1]+int64(b[j]*sa[i]));
        g[i][j]:=min(g[i][j-1],f[i][j]-int64(a[i+1]*sb[j]));
        h[i][j]:=min(h[i-1][j],f[i][j]-int64(b[j+1]*sa[i]));
        end;
writeln(f[n][m]);
close(input);
close(output);
end.
