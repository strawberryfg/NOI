const maxn=400020;
var n,kk,tmp,i:longint;
    base,ans:qword;
    f,g:array[0..maxn]of qword;
function calc(n:longint):qword;
var h,up:longint;
begin
fillchar(f,sizeof(f),0);
fillchar(g,sizeof(g),0);
f[0]:=1;
f[1]:=3;
g[0]:=1;
g[1]:=4;
for h:=2 to n do
    begin
    up:=n-h-1;
    if h-2<up then up:=h-2;
    if up>=0 then f[h]:=(f[h]+g[up]*f[h-1] mod base*2 mod base) mod base;
    if 2*h<=n then f[h]:=(f[h]+f[h-1]*f[h-1] mod base) mod base;
    f[h]:=(f[h]+f[h-1]*2 mod base) mod base;
    g[h]:=(g[h-1]+f[h])mod base;
    end;
calc:=g[n];
end;
begin
assign(input,'binary.in');
reset(input);
assign(output,'binary.out');
rewrite(output);
readln(n,kk);
tmp:=kk;
base:=1;
for i:=1 to tmp do base:=base*10;
close(input);
ans:=calc(n)+base-calc(n-1);
ans:=ans mod base;
writeln(ans);
close(output);
end.
