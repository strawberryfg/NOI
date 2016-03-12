const maxn=100020; eps=1e-12;
var n,i,head,tail:longint;
    a,sum,f:array[0..maxn]of int64;
    stack:array[0..maxn]of longint;
    res,l,res1,res2,res3,res4:int64;
    ret1,ret2:extended;
function check(u,v,i:longint):boolean;
begin
res:=(f[u]+(int64(u)+sum[u])*(int64(u)+sum[u]))-(f[v]+(int64(v)+sum[v])*(int64(v)+sum[v]));
res:=res-2*(l+1-sum[i]-int64(i))*((int64(v)+sum[v])-(int64(u)+sum[u]));
if res>=0 then exit(true) else exit(false);
end;
function calc(k,j,i:longint):boolean;
begin
res1:=((f[k]+(int64(k)+sum[k])*(int64(k)+sum[k]))-(f[j]+(int64(j)+sum[j])*(int64(j)+sum[j])));
res2:=((int64(k)+sum[k])-(int64(j)+sum[j]));
ret1:=extended(res1)/extended(res2);
res3:=((f[j]+(int64(j)+sum[j])*(int64(j)+sum[j]))-(f[i]+(int64(i)+sum[i])*(int64(i)+sum[i])));
res4:=((int64(j)+sum[j])-(int64(i)+sum[i]));
ret2:=extended(res3)/extended(res4);
if ret1-ret2>eps then exit(true) else exit(false);
end;
begin
readln(n,l);
for i:=1 to n do begin read(a[i]); sum[i]:=sum[i-1]+a[i]; end;
head:=1; tail:=1; stack[1]:=0;
f[0]:=0;
for i:=1 to n do
    begin
    while (head<tail)and(check(stack[head],stack[head+1],i)) do inc(head);
    f[i]:=f[stack[head]]+((int64(i-stack[head]-1)+sum[i]-sum[stack[head]]-l)*(int64(i-stack[head]-1)+sum[i]-sum[stack[head]]-l));
    while (head<tail)and(calc(stack[tail-1],stack[tail],i)) do dec(tail);
    inc(tail); stack[tail]:=i;
    end;
writeln(f[n]);
end.