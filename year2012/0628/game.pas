{$inline on}
{$optimization on}
uses dos;
const maxn=51; eps=1e-18; lim=0.47;
type mat=array[0..3*maxn,0..3*maxn]of extended;
var n,posi,node,i:longint;
    id:array[1..3,0..maxn]of longint;
    p:array[0..maxn]of extended;
    c,g:mat;
    x,y,z,w:word;
    t1,t2:extended;
function mul(x,y:mat):mat;
var i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for k:=1 to node do
    for i:=1 to node do
        begin
        if abs(x[i][k])<eps then continue;
        for j:=1 to node do c[i][j]:=c[i][j]+x[i][k]*y[k][j];
        end;
mul:=c;
end;
begin
assign(input,'game.in');
reset(input);
assign(output,'game.out');
rewrite(output);
readln(n,posi);
gettime(x,y,z,w);
t1:=x*3600+y*60+z+w/100;
for i:=1 to n do read(p[i]);
for i:=2 to n-2 do id[1][i]:=i-1;
for i:=1 to n-2 do id[2][i]:=n-3+i;
for i:=2 to n-1 do id[3][i]:=n-3+n-2+i-1;
node:=n-3+n-2+n-2+1;
for i:=3 to n-2 do g[id[1][i]][id[1][i-1]]:=1-p[i];
for i:=2 to n-3 do g[id[1][i]][id[1][i+1]]:=p[i];
for i:=1 to n-3 do g[id[2][i]][id[2][i+1]]:=p[i];
for i:=2 to n-2 do g[id[2][i]][id[2][i-1]]:=1-p[i];
for i:=2 to n-2 do g[id[3][i]][id[3][i+1]]:=p[i];
for i:=3 to n-1 do g[id[3][i]][id[3][i-1]]:=1-p[i];
g[id[1][2]][id[2][1]]:=1-p[2];
g[id[1][n-2]][id[3][n-1]]:=p[n-2];
g[id[2][n-2]][node]:=p[n-2];
g[id[3][2]][node]:=1-p[2];
g[node][node]:=1;
t2:=x*3600+y*60+z+w/100;
while lim-t2+t1>eps do
  begin
  g:=mul(g,g);
  gettime(x,y,z,w);
  t2:=x*3600+y*60+z+w/100;
  end;
if (n=2)and(posi=2) then writeln('0.000000')
   else if (n=2)and(posi=1) then writeln('1.000000')
           else begin
                if posi=1 then writeln(round(g[id[2][1]][node]*1000000)/1000000:0:6)
                   else if posi=n-1 then writeln(round(g[id[3][n-1]][node]*1000000)/1000000:0:6)
                           else writeln(round(g[id[1][posi]][node]*1000000)/1000000:0:6);
                end;
close(input);
close(output);
end.