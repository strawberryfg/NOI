const maxn=1000;
var a:array[0..maxn,0..10]of longint;
    sta,b,staa:array[0..maxn]of longint;
    n,i,j,ans:longint;
procedure dfs(x:longint);
var i,j,sum:longint;
begin
if x>n then
   begin
   for i:=1 to 4 do b[i]:=0;
   for i:=1 to n do
       begin
       for j:=1 to 4 do
           b[j]:=b[j]+sta[i]*a[i][j];
       end;
   sum:=0;
   for i:=1 to 4 do
       sum:=sum+b[i]*b[i];
   if sum>ans then begin staa:=sta; ans:=sum; end;
   exit;
   end;
for i:=0 to 1 do begin if i=0 then sta[x]:=-1 else sta[x]:=1; dfs(x+1); end;
end;
begin
assign(input,'d:\vector2.in');
reset(input);
assign(output,'d:\vector2.out');
rewrite(output);
readln(n);
for i:=1 to n do for j:=1 to 4 do read(a[i][j]);
ans:=0;
dfs(1);
for i:=1 to n do writeln(staa[i]);
writeln(ans);
close(input);
close(output);
end.
