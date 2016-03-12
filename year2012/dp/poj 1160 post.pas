const maxn=400; inf=maxlongint;
var n,m,i,j,len,res:longint;
    sum,dis:array[0..maxn]of longint;
    f,s:array[0..maxn,0..maxn]of longint;
function calc(a,b:longint):longint;
var mid:longint;
begin
mid:=(a+b) div 2;
calc:=dis[mid]*(mid-a)-(sum[mid-1]-sum[a-1])+(sum[b]-sum[mid])-dis[mid]*(b-mid);
end;
begin
{assign(input,'post.in');
reset(input);
assign(output,'post.out');
rewrite(output);}
readln(n,m);
for i:=1 to n do begin read(dis[i]); sum[i]:=sum[i-1]+dis[i]; end;
for i:=m+1 to n do s[m+1][i]:=i-1;
for i:=1 to m do s[i][i]:=i-1;
for i:=1 to m do
    for j:=i+1 to n do
        f[i][j]:=inf;
for len:=1 to n-m do
    begin
    f[1][1+len]:=calc(1,1+len);
    for i:=2 to m do
        begin
        for j:=s[i][i+len-1] to s[i+1][i+len] do
            begin
            res:=f[i-1][j]+calc(j+1,i+len);
            if res<=f[i][i+len] then
               begin
               f[i][i+len]:=res;
               s[i][i+len]:=j;
               end;
            end;
        end;
    end;
writeln(f[m][n]);
{close(input);
close(output);}
end.