const maxn=120; inf=1844674407370955166;
type arr=array[0..maxn,0..maxn]of int64;
var test,u,i,n,t,j,now:longint;
    m,ans:int64;
    tmp,f:arr;
    g:array[0..100]of arr;
    a:array[0..maxn,0..maxn]of int64;
    two:array[0..100]of int64;
function solvelog(x:int64):longint;
var i:longint;
begin
for i:=1 to 62 do if (x>two[i])and(x<=two[i+1]) then exit(i+1);
end;
operator *(a,b:arr) c:arr;
var i,j,k:longint;
begin
for i:=1 to n do
    for j:=1 to n do
        begin
        c[i][j]:=-inf;
        for k:=1 to n do
            begin
            if a[i][k]=-inf then continue;
            if b[k][j]=-inf then continue;
            if a[i][k]+b[k][j]>c[i][j] then
               begin
               c[i][j]:=a[i][k]+b[k][j];
               if c[i][j]>=m then
                  begin
                  c[i][j]:=m;
                  break;
                  end;
               end;
            end;
        end;
end;
function check(x:arr):boolean;
var i:longint;
begin
for i:=1 to n do
    if x[1][i]>=m then exit(true);
exit(false);
end;
begin
assign(input,'building.in');
reset(input);
assign(output,'building.out');
rewrite(output);
readln(test);
two[0]:=1;
for i:=1 to 62 do two[i]:=two[i-1]*2;
for u:=1 to test do
    begin
    readln(n,m);
    for i:=1 to n do
        for j:=1 to n do
            begin
            read(a[i][j]);
            if a[i][j]=0 then
               a[i][j]:=-inf;
            end;
    g[0]:=a;
    t:=solvelog(m);
    for i:=1 to t do
        begin
        g[i]:=g[i-1]*g[i-1];
        if check(g[i]) then begin now:=i; break; end;
        end;
    ans:=0;
    for i:=1 to n do
        for j:=1 to n do
            f[i][j]:=-inf;
    f[1][1]:=0;
    for i:=now downto 0 do
        begin
        tmp:=f*g[i];
        if not check(tmp) then
           begin
           ans:=ans+two[i];
           f:=tmp;
           end;
        end;
    writeln(ans+1);
    end;
close(input);
close(output);
end.
