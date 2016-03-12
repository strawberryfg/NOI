const maxdepth=10000000;
      inf=1000000000;
var cmq,n,m,kill,depth,i:longint;
    a:array[0..55]of longint;
    b:array[0..1111]of longint;
    level,g:array[0..1555]of longint;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=b[(l+r) div 2];
repeat
while b[i]<x do inc(i);
while x<b[j] do dec(j);
if not(i>j) then begin y:=b[i]; b[i]:=b[j]; b[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure submit(ans:longint);
begin
writeln(ans);
close(input);
close(output);
halt;
end;
function min(lim:longint):longint;
var mm,id,i:longint;
begin
mm:=inf; id:=-1;
for i:=0 to n-1 do
    if (a[i]>=lim)and(a[i]<mm) then
       begin
       mm:=a[i];
       id:=i;
       end;
exit(id);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function next(id:longint):longint;
var mm,p,i:longint;
begin
mm:=inf; p:=-1;
for i:=0 to n-1 do
    if (a[i]>a[id])and(mm>a[i]) then
       begin
       mm:=a[i];
       p:=i;
       end;
exit(p);
end;
function impossible(dep:longint):boolean;
var ans,i:longint;
begin
ans:=dep;
for i:=0 to n-1 do
    ans:=ans+a[i] div b[dep];
exit(ans<=cmq);
end;
procedure dfs(dep:longint);
var p:longint;
begin
if dep=m then
   begin
   submit(m);
   exit;
   end;
inc(kill);
if kill>=depth then submit(cmq);
if impossible(dep) then
   exit;
cmq:=max(cmq,dep);
p:=min(b[dep]);
while p<>-1 do
  begin
  a[p]:=a[p]-b[dep];
  dfs(dep+1);
  a[p]:=a[p]+b[dep];
  {if a[p]<b[dep]+b[dep+1] then
     p:=min(b[dep]+b[dep+1])
  else
    } p:=next(p);
  end;
end;
begin
assign(input,'fence.in');
reset(input);
assign(output,'fence.out');
rewrite(output);
readln(n);
depth:=6000000;
for i:=0 to n-1 do readln(a[i]);
readln(m);
for i:=0 to m-1 do readln(b[i]);
b[m]:=inf;
sort(0,m-1);
dfs(0);
writeln(cmq);
close(input);
close(output);
end.
