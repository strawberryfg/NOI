const maxn=55; base=1000000007;
var n,cnta,cntb,sum,now,ans,i,j,k,t,tmp:longint;
    a,b:array[0..maxn]of longint;
    f,g:array[0..maxn,0..maxn,0..10]of longint;
    ch:char;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'elevenmultiples.in');
reset(input);
assign(output,'elevenmultiples.out');
rewrite(output);
readln(n); cnta:=0; cntb:=0;
for i:=1 to n do
    begin
    now:=0; sum:=0;
    while not eoln do
      begin
      read(ch);
      now:=now xor 1;
      if now=1 then sum:=(sum+ord(ch)-ord('0')) mod 11 else sum:=(sum+11-(ord(ch)-ord('0'))) mod 11;
      end;
    if now=1 then begin inc(cnta); a[cnta]:=sum; end else begin inc(cntb); b[cntb]:=sum; end;
    readln;
    end;
f[0][0][0]:=1;
for i:=0 to cnta-1 do
    for j:=0 to min(i,cnta div 2) do
        for k:=0 to 10 do
            if f[i][j][k]<>0 then
               begin
               t:=(k+a[i+1]) mod 11;
               f[i+1][j][t]:=(f[i+1][j][t]+f[i][j][k]) mod base;
               t:=(k+11-a[i+1]) mod 11;
               f[i+1][j+1][t]:=(f[i+1][j+1][t]+f[i][j][k]) mod base;
               end;
tmp:=1;
for i:=1 to cnta div 2 do tmp:=qword(tmp)*qword(i) mod base;
for i:=1 to cnta-cnta div 2 do tmp:=qword(tmp)*qword(i) mod base;
for i:=0 to 10 do f[cnta][cnta div 2][i]:=qword(f[cnta][cnta div 2][i])*qword(tmp) mod base;
// even +1
g[0][0][0]:=1;
for i:=0 to cntb-1 do
    for j:=0 to i do
        for k:=0 to 10 do
            if g[i][j][k]<>0 then
               begin
               t:=(k+b[i+1]) mod 11; //odd;
               g[i+1][j][t]:=(g[i+1][j][t]+qword(cnta div 2+1+i-j)*qword(g[i][j][k]) mod base) mod base;
               t:=(k+11-b[i+1]) mod 11;  //even;
               g[i+1][j+1][t]:=(g[i+1][j+1][t]+qword((cnta+1) div 2+j)*qword(g[i][j][k])) mod base;
               end;
ans:=0;
for i:=0 to cntb do
    for j:=0 to 10 do
        begin
        t:=f[cnta][cnta div 2][j];
        ans:=(ans+qword(f[cnta][cnta div 2][j])*qword(g[cntb][i][(11-j) mod 11]) mod base) mod base;
        end;
writeln(ans);
close(input);
close(output);
end.