const maxn=120; inf=maxlongint;
var n,m,i,x,y,j,ans,k,res:longint;
    a,sum:array[0..maxn,0..maxn]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
{assign(input,'i.in');
reset(input);
assign(output,'i.out');
rewrite(output);}
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    a[x][y]:=1;
    end;
for i:=1 to n do
    for j:=1 to n do
        sum[i][j]:=sum[i-1][j]+sum[i][j-1]-sum[i-1][j-1]+a[i][j];
ans:=inf;
for i:=1 to n do
    for j:=1 to n do
        begin
        for k:=1 to min(n-j+1,m) do
            begin
            if (m mod k=0)and(i+m div k-1<=n) then
               begin
               res:=sum[i+m div k-1][j+k-1]-sum[i+m div k-1][j-1]-sum[i-1][j+k-1]+sum[i-1][j-1];
               if m-res<ans then ans:=m-res;
               end;
            end;
        end;
writeln(ans);
{close(input);
close(output);}
end.
