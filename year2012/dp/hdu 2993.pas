const maxn=100020; eps=1e-12;
var n,len,i,head,tail:longint;
    ans:extended;
    sum,a:array[0..maxn]of extended;
    stack:array[0..maxn]of longint;
function max(x,y:extended):extended;
begin
if x-y>eps then max:=x else max:=y;
end;
function check(k,j,i:longint):boolean;
var res,ej,ei,ek:extended;
begin
ej:=j; ei:=i; ek:=k;
res:=(sum[i]-sum[j])*(ej-ek)-(sum[j]-sum[k])*(ei-ej);
if res<=0 then check:=true else check:=false;
end;
function calc(u,v,i:longint):boolean;
var res,eu,ev,ei:extended;
begin
ev:=v; eu:=u; ei:=i;
res:=(sum[i]-sum[v])*(ev-eu)-(sum[v]-sum[u])*(ei-ev);
if res>=0 then calc:=true else calc:=false;
end;
begin
{assign(input,'maxave.in');
reset(input);
assign(output,'maxave.out');
rewrite(output);}
while not seekeof do
  begin
  readln(n,len);
  if n=0 then break;
  for i:=1 to n do begin read(a[i]); sum[i]:=sum[i-1]+a[i]; end;
  head:=1; tail:=0; ans:=0.0;
  for i:=len to n do
      begin
      while (head<tail)and(check(stack[tail-1],stack[tail],i-len)) do dec(tail);
      inc(tail); stack[tail]:=i-len;
      while (head<tail)and(calc(stack[head],stack[head+1],i)) do inc(head);
      ans:=max(ans,(sum[i]-sum[stack[head]])/(i-stack[head]));
      end;
  writeln(round(ans*100)/100:0:2);
  end;
{close(input);
close(output);}
end.