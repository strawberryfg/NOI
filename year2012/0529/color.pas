const maxn=40; maxkind=100; base=1000000007;
var n,m,kind,i:longint;
    a:array[0..maxkind]of longint;
    f,g,col:array[0..maxn,0..maxn,0..maxn*maxn]of int64;
    comb:array[0..maxn*maxn,0..maxn*maxn]of int64;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function com(x,y:longint):int64;
begin
if comb[x][y]<>0 then exit(comb[x][y]);
if (x=1)and(y=1) then exit(1);
if (y=0) then exit(1);
if (x<y) then exit(0);
comb[x][y]:=(com(x-1,y)+com(x-1,y-1)) mod base;
com:=comb[x][y];
end;
procedure workcolatleastone;
var i,j,k,x,p:longint;
begin
for i:=1 to n do
    for j:=1 to m do
        begin
        for k:=j to i*j do
            begin
            col[i][j][k]:=0; x:=-1;
            for p:=0 to j do
                begin
                x:=-x;
                if x=1 then col[i][j][k]:=(col[i][j][k]+com(i*(j-p),k)*com(j,p) mod base) mod base
                   else col[i][j][k]:=(col[i][j][k]+base-com(i*(j-p),k)*com(j,p) mod base) mod base;
                end;
            end;
        end;
end;
procedure workrowatleastone;
var i,j,k,p,x:longint;
begin
for i:=1 to n do
    for j:=1 to m do
        begin
        for k:=max(i,j) to i*j do
            begin
            g[i][j][k]:=col[i][j][k]; x:=1;
            for p:=1 to i do
                begin
                x:=-x;
                if x=1 then g[i][j][k]:=(g[i][j][k]+com(i,p)*col[i-p][j][k] mod base) mod base
                   else g[i][j][k]:=(g[i][j][k]+base-com(i,p)*col[i-p][j][k] mod base) mod base;
                end;
            end;
        end;
end;
procedure work;
var i,j,k,p,q:longint;
    tag:int64;
begin
for i:=1 to kind do
    for j:=1 to n do
        for k:=1 to m do
            begin
            for p:=1 to j do
                begin
                for q:=1 to k do
                    begin
                    if i=1 then tag:=g[p][q][a[i]] else tag:=f[i-1][j-p][k-q]*g[p][q][a[i]] mod base;
                    f[i][j][k]:=(f[i][j][k]+com(j,p)*com(k,q) mod base*tag mod base) mod base;
                    end;
                end;
            end;
end;
begin
assign(input,'color.in');
reset(input);
assign(output,'color.out');
rewrite(output);
readln(n,m,kind);
for i:=1 to kind do read(a[i]);
workcolatleastone;
workrowatleastone;
work;
writeln(f[kind][n][m]);
close(input);
close(output);
end.