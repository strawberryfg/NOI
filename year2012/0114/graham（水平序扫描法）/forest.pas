//19:14;
var ans,value,n,i,num,len,sum,total:longint;
    tmp:extended;
    stack,a,ta,x,y,v,l,state,b,final:array[0..200]of longint;
procedure sort(l,r: longint);
var i,j,tx,ty,tt: longint;
begin
i:=l; j:=r; tx:=x[a[(l+r) div 2]]; ty:=y[a[(l+r)div 2]];
repeat
  while (x[a[i]]<tx)or((x[a[i]]=tx)and(y[a[i]]<ty)) do inc(i);
  while (tx<x[a[j]])or((tx=x[a[j]])and(ty<y[a[j]])) do dec(j);
  if not(i>j) then begin tt:=a[i]; a[i]:=a[j]; a[j]:=tt; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function cross(u,v,w:longint):longint;
begin
exit((x[v]-x[u])*(y[w]-y[u])-(x[w]-x[u])*(y[v]-y[u]));
end;
function calc(u,v:longint):extended;
begin
exit(sqrt((x[u]-x[v])*(x[u]-x[v])+(y[u]-y[v])*(y[u]-y[v])));
end;
procedure check;
var k,top,i:longint;
    res:extended;
begin
if sum=0 then exit;
sort(1,sum);
top:=0;
for i:=1 to sum do
    begin
    while (top>1)and(cross(stack[top-1],stack[top],a[i])<=0) do dec(top);
    inc(top); stack[top]:=a[i];
    end;
k:=top;
for i:=sum-1 downto 1 do
    begin
    while (top>k)and(cross(stack[top-1],stack[top],a[i])<=0) do dec(top);
    inc(top); stack[top]:=a[i];
    end;
if sum>1 then dec(top);
res:=calc(stack[1],stack[top]);
for i:=1 to top-1 do res:=res+calc(stack[i],stack[i+1]);
if (abs(len-res)<1e-10)or(len-res>1e-10) then
   begin
   if (value<ans)or((value=ans)and(total<num)) then
      begin
      ans:=value;
      num:=total;
      final:=b;
      tmp:=len-res;
      end;
   end;
end;
procedure dfs(dep:longint);
var i:longint;
begin
if dep>n then
   begin
   a:=ta;
   check;
   exit;
   end;
for i:=0 to 1 do
    begin
    state[dep]:=i;
    if i=0 then //cut
       begin
       len:=len+l[dep];
       value:=value+v[dep];
       inc(total);
       b[total]:=dep;
       dfs(dep+1);
       b[total]:=0;
       dec(total);
       len:=len-l[dep];
       value:=value-v[dep];
       end
    else       //remain
        begin
        inc(sum);
        ta[sum]:=dep;
        dfs(dep+1);
        ta[sum]:=0;
        dec(sum);
        end;
    end;
end;
begin
assign(input,'forest.in');
reset(input);
assign(output,'forest.out');
rewrite(output);
readln(n);
for i:=1 to n do read(x[i],y[i],v[i],l[i]);
ans:=maxlongint;
len:=0; total:=0; sum:=0;
dfs(1);
writeln(tmp:0:2);
for i:=1 to num-1 do write(final[i],' ');
write(final[num]);
writeln;
close(input);
close(output);
end.