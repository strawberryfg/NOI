var i,j,k:longint;
    ans,p,n:int64;
    f:array[0..2001,0..2001]of int64;
    xie,sum,sum2:array[0..10001]of int64;
begin
assign(input,'brick.in');reset(input);
assign(output,'brick.out');rewrite(output);
readln(n,p);
f[0,0]:=1;
for i:=1 to n do
  begin
  sum[i]:=0;
    for j:=1 to n do
    if i>=j then
    begin
    f[i,j]:=0;
    for k:=1 to j-1 do
        f[i,j]:=(f[i-k,j-k]+f[i,j])mod p;
    //f[i,j]:=xie[i-j];
    for k:=1 to i-j do
        f[i,j]:=(f[i,j]+(f[i-j,k]*(int64(j+k-1))mod p))mod p;
    //f[i,j]:=f[i,j]+sum[i-j]*int64(j-1)+sum2[i-j];
    if i=j then f[i,j]:=(f[i,j]+1)mod p;
    {xie[i-j]:=xie[i-j]+f[i,j];
    sum[i]:=sum[i]+f[i,j];sum2[i]:=sum2[i]+f[i,j]*int64(j);}
    end;
  end;
//for i:=1 to 3 do writeln(f[n,i]);
ans:=0;
for i:=1 to n do
    ans:=(ans+f[n,i])mod p;
writeln(ans);
//while true do i:=i;
close(input);close(output);
end.
