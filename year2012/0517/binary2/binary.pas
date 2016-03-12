//uses dos;
const maxn=2120;
var h,i,j,kk,tmp,h1,n,maxdis:longint;
    f,g:array[0..maxn,-5..maxn]of qword;
    base,ans:qword;
{    aa,bb,cc,dd:word;
    tt1,tt2:real;}
begin
assign(input,'binary.in');
reset(input);
assign(output,'binary.out');
rewrite(output);
readln(n,kk);
{gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;}
tmp:=kk;
base:=1;
for i:=1 to tmp do base:=base*10;
f[0][0]:=1;
for i:=0 to n do g[0][i]:=(g[0][i-1]+f[0][i]) mod base;
f[1][1]:=2;
f[1][2]:=1;
for i:=0 to n do g[1][i]:=(g[1][i-1]+f[1][i]) mod base;
for h:=2 to n do
    begin
    for j:=0 to n do
        begin
        if f[h-1][j]=0 then continue;
        for h1:=0 to h-2 do
            begin
            maxdis:=j;
            if h1+h-1+2>maxdis then maxdis:=h1+h-1+2;
            if maxdis<=n then
               begin
               f[h][maxdis]:=(f[h][maxdis]+g[h1][n]*f[h-1][j] mod base*2 mod base) mod base;
               end
            else
               break;
            end;
        end;
{   for h1:=0 to h-2 do
        for i:=0 to n do    // [h1][i]
            begin
            if f[h1][i]=0 then continue;
            for j:=0 to n do
                begin       // [h-1][j]
                if f[h-1][j]=0 then continue;
                maxdis:=j;
                if h1+h-1+2>maxdis then maxdis:=h1+h-1+2;
                if maxdis<=n then
                   f[h][maxdis]:=(f[h][maxdis]+f[h1][i]*f[h-1][j] mod base*2 mod base) mod base;
                end;
            end;  }
    if h-1+h-1+2<=n then
       begin
       for i:=0 to n do
           begin
           if f[h-1][i]=0 then continue;
           for j:=0 to n do
               begin
               if f[h-1][j]=0 then continue;
               if i>j then maxdis:=i else maxdis:=j;
               if h-1+h-1+2>maxdis then maxdis:=h-1+h-1+2;
               if maxdis<=n then
                  f[h][maxdis]:=(f[h][maxdis]+f[h-1][i]*f[h-1][j] mod base) mod base;
               end;
           end;
       end;
    for i:=1 to n do
        begin
        if f[h-1][i]=0 then continue;
        maxdis:=i;
        if h-1+1>maxdis then maxdis:=h-1+1;
        if maxdis<=n then
           f[h][maxdis]:=(f[h][maxdis]+f[h-1][i]*2 mod base) mod base;
        end;
    for j:=0 to n do g[h][j]:=(g[h][j-1]+f[h][j])mod base;
    end;
ans:=0;
for i:=1 to n do
    begin
    if f[i][n]<>0 then
       ans:=(ans+f[i][n]) mod base;
    end;
writeln(ans mod base);
{gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:10);}
close(input);
close(output);
end.
