const maxn=100; inf=maxlongint;
var n,i,j,ans:longint;
    sta,hash:array[0..maxn]of longint;
    a:array[0..maxn,0..maxn]of longint;
procedure dfs(x,now:longint);
var i,sum:longint;
begin
if x>n then
   begin
   sta[n+1]:=sta[1];
   if now+a[sta[n]][sta[n+1]]<ans then ans:=now+a[sta[n]][sta[n+1]];
   exit;
   end;
for i:=1 to n do
    if hash[i]=0 then
       begin
       hash[i]:=1;
       sta[x]:=i;
       dfs(x+1,now+a[sta[x-1]][sta[x]]);
       hash[i]:=0;
       sta[x]:=0;
       end;
end;
begin
{assign(input,'g.in');
reset(input);
assign(output,'g.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    for j:=1 to n do
        read(a[i][j]);
ans:=inf;
dfs(1,0);
writeln(ans);
{close(input);
close(output);}
end.
