const maxn=19; maxsum=172;
var l,r:int64;
    f:array[0..maxn,0..maxsum,0..maxsum,0..1]of qword;
    a,sa:array[0..maxn]of longint;
    cn:longint;
    ans:qword;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function work(x:qword):qword;
var num,ret:qword;
    n,i,j,k,l,up,t:longint;
begin
if x=0 then exit(0);
num:=x;
n:=0;
while num>0 do begin inc(n); a[n]:=num mod 10; num:=num div 10; end;
for i:=1 to n div 2 do begin a[i]:=a[i] xor a[n+1-i]; a[n+1-i]:=a[i] xor a[n+1-i]; a[i]:=a[i] xor a[n+1-i]; end;
fillchar(sa,sizeof(sa),0);
for i:=1 to n do sa[i]:=sa[i-1]+a[i];
ret:=0;
for k:=1 to (n-1)*9+a[1]-1 do
    begin
    fillchar(f,sizeof(f),0);
    for j:=0 to a[1]-1 do
        begin
        f[1][j][j mod k][0]:=1;              //0:< 1:=
        end;
    f[1][a[1]][a[1] mod k][1]:=1;
    for i:=2 to n do
        begin
        if i=1 then up:=a[1] else up:=9*i;
        for j:=0 to up do                   //sum
            begin
            for l:=0 to k-1 do
                begin
                if f[i-1][j][l][1]>0 then
                   for t:=0 to a[i]-1 do
                       inc(f[i][j+t][(l*10+t)mod k][0],f[i-1][j][l][1]);
                inc(f[i][j+a[i]][(l*10+a[i])mod k][1],f[i-1][j][l][1]);
                if f[i-1][j][l][0]>0 then
                   for t:=0 to 9 do
                       inc(f[i][j+t][(l*10+t)mod k][0],f[i-1][j][l][0]);
                end;
            end;
       end;
    ret:=ret+f[n][k][0][0]+f[n][k][0][1];
    end;
work:=ret;
end;
begin
assign(input,'self.in');
reset(input);
assign(output,'self.out');
rewrite(output);
readln(l,r);
ans:=work(r)-work(l-1);
writeln(ans);
close(input);
close(output);
end.