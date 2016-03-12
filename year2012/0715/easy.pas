type arr=array[0..51,0..51]of longint;
var n,x,base,i,j,ans:longint;
    c,g,ori,h:arr;
function mul(a,b:arr):arr;
var i,j,k:longint;
begin
fillchar(h,sizeof(h),0);
for k:=0 to x+1 do
    for i:=0 to x+1 do
        begin
        if a[i][k]=0 then continue;
        for j:=0 to x+1 do
            h[i][j]:=(h[i][j]+qword(a[i][k])*b[k][j] mod base) mod base;
        end;
exit(h);
end;
function pow(std:arr; step:longint):arr;
begin
pow:=std;
dec(step);
while step>0 do
  begin
  if step mod 2=1 then pow:=mul(pow,std);
  step:=step div 2;
  std:=mul(std,std);
  end;
end;
begin
assign(input,'easy.in');
reset(input);
assign(output,'easy.out');
rewrite(output);
read(n,x,base);
for i:=1 to 51 do
    begin
    c[i][0]:=1; c[i][i]:=1; c[i][1]:=i; c[i][i-1]:=i;
    for j:=2 to i-2 do c[i][j]:=(qword(c[i-1][j])+qword(c[i-1][j-1])) mod base;
    end;
c[0][0]:=1;
for i:=0 to x do
    for j:=0 to i do
        g[j][i]:=qword(c[i][j])*qword(x) mod base;
g[x+1][x+1]:=1; g[x][x+1]:=1;
for i:=0 to x do ori[1][i]:=x; ori[1][x+1]:=0;
if n<>1 then ori:=mul(ori,pow(g,n-1));
ans:=(qword(ori[1][x])+ori[1][x+1]) mod base;
writeln(ans);
close(input);
close(output);
end.
