const maxm=300;
type matrix=array[0..maxm,0..maxm]of qword;
var n,m,j,k,i:longint;
    mat,ret,std,c:matrix;
    last,sum,base:qword;
    ans,g:array[1..1,0..maxm]of qword;
    f:array[0..maxm,0..maxm]of qword;
function pow(x:qword;y:longint):qword;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x mod base;
  x:=x*x mod base;
  y:=y div 2;
  end;
end;
function com(x,y:longint):qword;
var i:longint;
begin
if f[x][y]<>0 then exit(f[x][y]);
if (x=1)and(y=1) then exit(1);
if (y=0) then exit(1);
if x<y then exit(0);
com:=(com(x-1,y-1)+com(x-1,y)) mod base;
f[x][y]:=com;
end;
procedure mul(x:longint);
var i,j,k:longint;
begin
ret:=mat;
std:=mat;
dec(x);
while x>0 do
  begin
  if x mod 2=1 then
     begin
     fillchar(c,sizeof(c),0);
     for k:=0 to m+1 do
         for i:=0 to m+1 do
             if ret[i][k]<>0 then
                for j:=0 to m+1 do
                    if std[k][j]<>0 then
                       c[i][j]:=(c[i][j]+ret[i][k]*std[k][j] mod base) mod base;
     ret:=c;
     end;
  fillchar(c,sizeof(c),0);
  for k:=0 to m+1 do
      for i:=0 to m+1 do
          if std[i][k]<>0 then
             for j:=0 to m+1 do
                 if std[k][j]<>0 then
                    c[i][j]:=(c[i][j]+std[i][k]*std[k][j] mod base) mod base;
  std:=c;
  x:=x div 2;
  end;
end;
procedure work;
var j,k:longint;
begin
for k:=0 to m+1 do
    if g[1][k]<>0 then
       for j:=0 to m+1 do
           if ret[k][j]<>0 then
              ans[1][j]:=(ans[1][j]+g[1][k]*ret[k][j] mod base) mod base;
end;
begin
assign(input,'bridge.in');
reset(input);
assign(output,'bridge.out');
rewrite(output);
readln(n,m,base);
for j:=0 to m do
    for k:=j to m do
        mat[j][k]:=(m*m-3*m+3)*com(k,j) mod base*pow(2,k-j) mod base;
mat[m][m+1]:=1;
mat[m+1][m+1]:=1;
if n=1 then writeln(m*(m-1) mod base)
   else begin
        g[1][0]:=m*(m-1) mod base;
        last:=1;
        for i:=1 to m do
            begin
            last:=last*2 mod base;
            g[1][i]:=m*(m-1) mod base*last mod base;
            end;
        mul(n-1);
        work;
        sum:=(ans[1][m+1]+ans[1][m])mod base;
        writeln(sum);
        end;
close(input);
close(output);
end.