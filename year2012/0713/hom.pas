const maxn=56; base=1000000003;
var n,need,i,j,k,p:longint;
    a:array[0..maxn]of longint;
    num,sum:array[0..maxn,0..35]of longint;
    pow:array[0..35]of qword;
    f:array[0..maxn,0..35,0..1]of qword;
    ans:longint;
procedure init;
begin
fillchar(f,sizeof(f),0);
fillchar(sum,sizeof(sum),0);
end;
begin
assign(input,'hom.in');
reset(input);
assign(output,'hom.out');
rewrite(output);
read(n,need);
while (n<>0)or(need<>0) do
  begin
  init;
  for i:=1 to n do begin read(a[i]); inc(a[i]); end;
  for i:=1 to n do
      for j:=0 to 30 do
          begin
          num[i][j]:=(a[i] shr j) and 1;
          sum[i][j]:=sum[i-1][j] xor num[i][j];
          end;
  pow[0]:=1;
  for i:=1 to 31 do pow[i]:=pow[i-1]*2 mod base;
  for i:=1 to 31 do
      if num[1][31-i]=1 then f[1][i][0]:=1;
  for i:=1 to n-1 do
      for j:=1 to 31 do
          for p:=0 to 1 do
              begin
              for k:=j+1 to 31 do
                  if num[i+1][31-k]=1 then
                     f[i+1][j][p xor num[i+1][31-j]]:=(f[i+1][j][p xor num[i+1][31-j]]+f[i][j][p]*pow[31-k] mod base) mod base;
              if num[i+1][31-j]=1 then f[i+1][j][p]:=(f[i+1][j][p]+f[i][j][p]*pow[31-j] mod base) mod base;
              for k:=1 to j-1 do
                  if num[i+1][31-k]=1 then f[i+1][k][sum[i][31-k]]:=(f[i+1][k][sum[i][31-k]]+f[i][j][p]*pow[31-j] mod base) mod base;
              end;
  ans:=f[n][1][(need shr 30) and 1];
  for i:=2 to 31 do
      if sum[n][31-(i-1)]=(need shr (31-(i-1))) and 1 then
         ans:=(ans+f[n][i][(need shr (31-i)) and 1]) mod base
      else
         break;
  writeln(ans);
  read(n,need);
  end;
close(input);
close(output);
end.
