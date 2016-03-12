const maxn=120; inf=1844674407370955166;
var i,j,k,p,n,test,u,t,now:longint;
    m,res,fmin,ans:int64;
    two:array[0..80]of int64;
    a:array[0..maxn,0..maxn]of int64;
    g,f:array[0..maxn,0..maxn,0..80]of int64;
    d,c:array[1..1,0..maxn]of int64;
function check(x:longint):boolean;
var i:longint;
begin
for i:=1 to n do
    if g[1][i][x]>=m then exit(true) else exit(false);
end;
function doit(x:int64):longint;
var i:longint;
begin
for i:=1 to 62 do if (x>two[i])and(x<=two[i+1]) then exit(i+1);
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
    ans:=0;
    for i:=1 to n do
        begin
        for j:=1 to n do
            begin
            read(a[i][j]);
            if a[i][j]=0 then
               a[i][j]:=-inf;
            end;
        readln;
        end;
    t:=doit(m);
    for i:=1 to n do
        for j:=1 to n do
            for k:=1 to t do
                g[i][j][k]:=-inf;
    for i:=1 to n do
        for j:=1 to n do
            begin
            g[i][j][0]:=a[i][j];
            end;
    if check(0) then
       begin
       writeln(1);
       continue;
       end;
    for k:=1 to t do
        begin
        for i:=1 to n do
            for j:=1 to n do
                begin
                for p:=1 to n do
                    begin
                    if g[p][j][k-1]=-inf then continue;
                    if g[i][p][k-1]=-inf then continue;
                    if g[i][p][k-1]+g[p][j][k-1]>g[i][j][k] then
                       begin
                       g[i][j][k]:=g[i][p][k-1]+g[p][j][k-1];
                       if g[i][j][k]>m then
                          begin
                          g[i][j][k]:=m;
                          break;
                          end;
                       end;
                    end;
                end;
        p:=0;
        for i:=1 to n do
            if g[1][i][k]>=m then
               begin
               now:=k;
               p:=1;
               break;
               end;
        if p=1 then break;
        end;
    for i:=1 to n do d[1][i]:=-inf;
    d[1][1]:=0;
    for k:=now downto 0 do
        begin
        for i:=1 to n do c[1][i]:=-inf;
        for i:=1 to n do
            for j:=1 to n do
                begin
                if g[i][j][k]=-inf then continue;
                if d[1][i]=-inf then continue;
                if d[1][i]+g[i][j][k]>c[1][j] then
                   begin
                   c[1][j]:=d[1][i]+g[i][j][k];
                   if c[1][j]>m then c[1][j]:=m;
                   end;
                end;
        p:=0;
        for i:=1 to n do
            if c[1][i]>=m then begin p:=1; break; end;
        if p=0 then
           begin
           d:=c;
           ans:=ans+two[k];
           end;
        end;
    writeln(ans+1);
    end;
close(input);
close(output);
end.
