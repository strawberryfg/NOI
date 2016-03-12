const maxn=1001; eps=1e-16;
type mattype=array[0..maxn]of real;
var n,m,i,j,k,opt:longint;
    c,ans,res,std:mattype;
    a:array[0..maxn]of longint;
function conv(row,col:longint):longint;
begin
if col>=row then exit(col-row+1)
   else exit(n-row+1+col);
end;
begin
assign(input,'weak.in');
reset(input);
assign(output,'weak.out');
rewrite(output);
readln(n,m,opt);
for i:=1 to n do read(a[i]);
res[1]:=1-1/m; res[2]:=1/m; std:=res; dec(opt);
while opt>0 do
  begin
  if opt mod 2=1 then
     begin
     fillchar(c,sizeof(c),0);
     for j:=1 to n do
         for k:=1 to n do
             c[k]:=c[k]+res[j]*std[conv(j,k)];
     res:=c;
     end;
  opt:=opt div 2; if opt=0 then break;
  fillchar(c,sizeof(c),0);
  for j:=1 to n do
      for k:=1 to n do
          c[k]:=c[k]+std[j]*std[conv(j,k)];
  std:=c;
  end;
fillchar(ans,sizeof(ans),0);
for j:=1 to n do
    for k:=1 to n do
        ans[k]:=ans[k]+a[j]*res[conv(j,k)];
for i:=1 to n do writeln(ans[i]:0:3);
close(input);
close(output);
end.