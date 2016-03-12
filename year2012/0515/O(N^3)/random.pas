const maxn=100;
var opt,n,i,j,k,l:longint;
    p,g:array[0..maxn,-1..maxn]of extended;
    f:array[0..maxn]of extended;
    ans,res:extended;
begin
assign(input,'random.in');
reset(input);
assign(output,'random.out');
rewrite(output);
readln(opt,n);
p[1][1]:=1;
for i:=1 to n+2 do
    for j:=1 to n+2 do
        begin
        if (i=1)and(j=1) then continue;
        p[i][j]:=p[i-1][j]*(i-1)/(i-1+j)+p[i][j-1]*(j-1)/(j-1+i);
        end;
f[1]:=0;
for i:=2 to n do
    for j:=1 to i-1 do
        f[i]:=f[i]+(f[j]+f[i-j]+i)*p[j][i-j];
g[1][0]:=1;
for i:=1 to n do g[1][i]:=g[1][i-1];
for i:=2 to n do
    begin
    for j:=1 to i-1 do    //height
        begin
        res:=0;
        for l:=1 to i-1 do
            begin
            res:=res+(g[l][j-1]-g[l][j-2])*g[i-l][j-2];
            res:=res+(g[i-l][j-1]-g[i-l][j-2])*g[l][j-2];
            res:=res+(g[l][j-1]-g[l][j-2])*(g[i-l][j-1]-g[i-l][j-2]);
{            for k:=0 to j-2 do g[i][j]:=g[i][j]+g[l][j-1]*g[i-l][k];
            for k:=0 to j-2 do g[i][j]:=g[i][j]+g[l][k]*g[i-l][j-1];
            g[i][j]:=g[i][j]+g[l][j-1]*g[i-l][j-1];}
            end;
//        g[i][j]:=g[i][j]/(i-1);
        g[i][j]:=g[i][j-1]+res/(i-1);
        end;
    for j:=i to n do g[i][j]:=g[i][j-1];
    end;
if opt=1 then writeln(round(f[n]/n*1000000)/1000000:0:6)
   else begin
        for i:=1 to n-1 do ans:=ans+(g[n][i]-g[n][i-1])*i;
        writeln(round(ans*1000000)/1000000:0:6);
        end;
close(input);
close(output);
end.