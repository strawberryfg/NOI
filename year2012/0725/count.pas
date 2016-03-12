var n,i,j,maxx:longint;
    fa,a,b:array[0..55]of longint;
    pow:array[0..55]of qword;
    f:array[0..25,0..55]of longint;
    ans:real;
    t:qword;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure dfs(x,opt:longint);
var i,last,cnt:longint;
begin
if x>maxx then
   begin
   cnt:=0;
   for i:=1 to n do if fa[i]=i then inc(cnt);
   ans:=ans+real(opt)*(pow[cnt]-2);
   exit;
   end;
f[x]:=fa;
dfs(x+1,opt);
fa:=f[x];
if (b[x]=0)or(b[x]=n) then exit; // all 0 all 1;
last:=-1;
for i:=1 to n do
    if a[i] and pow[x]=0 then
       begin
       if last=-1 then last:=getfa(i)
          else fa[getfa(i)]:=last;
       end;
dfs(x+1,-opt);
end;
begin
assign(input,'count.in');
reset(input);
assign(output,'count.out');
rewrite(output);
pow[0]:=1; for i:=1 to 55 do pow[i]:=pow[i-1]*2;
read(n);
for i:=1 to n do
    begin
    read(a[i]);
    for j:=20 downto 0 do
        if a[i] and (1 shl j)>0 then
           begin
           inc(b[j]);
           if j>maxx then maxx:=j;
           end;
    end;
for i:=1 to n do fa[i]:=i;
ans:=0;
dfs(0,1);
t:=qword(trunc(ans));
writeln(t);
close(input);
close(output);
end.
