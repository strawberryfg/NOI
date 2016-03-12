const maxn=320;
type arr=array[0..maxn]of longint;
var n,i,j,tot:longint;
    cnt,d,ans:array[0..maxn]of longint;
    a:array[0..maxn,0..maxn]of longint;
procedure dfs(d:arr);
var f:arr;
    deg,i,j:longint;
begin
deg:=1;
for i:=1 to n do if d[i]=1 then inc(deg);
for i:=1 to n do
    if d[i]>1 then
       begin
       inc(deg);
       for j:=1 to n do f[j]:=-1;
       for j:=i+1 to n do
           begin
           if (d[j]>1)and(a[i][j]<d[i]+d[j]) then
              begin
              f[j]:=d[j]-1; d[j]:=-1;
              end;
           end;
       f[i]:=d[i]-1; d[i]:=-1;
       dfs(f);
       end;
inc(cnt[deg]);
end;
begin
assign(input,'network.in');
reset(input);
assign(output,'network.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    for j:=1 to n do
        read(a[i][j]);
    end;
for i:=1 to n do d[i]:=a[1][i]-1;
dfs(d);
tot:=0;
for i:=1 to n do
    begin
    while cnt[i]>0 do
      begin
      inc(tot);
      ans[tot]:=i;
      dec(cnt[i]);
      end;
    end;
for i:=1 to tot-1 do write(ans[i],' ');
write(ans[tot]);
writeln;
close(input);
close(output);
end.
