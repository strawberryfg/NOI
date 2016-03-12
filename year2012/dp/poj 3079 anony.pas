const maxn=600020;
var test,now,i,n,kk,head,tail:longint;
    sum,a,f:array[0..maxn]of int64;
    stack:array[0..maxn]of longint;
function check(u,v,i:longint):boolean;
var res:int64;
begin
res:=(f[u]-sum[u]+a[u+1]*u)-(f[v]-sum[v]+a[v+1]*v)-i*(a[u+1]-a[v+1]);
if res<=0 then exit(true) else exit(false);
end;
function calc(k,j,i:longint):boolean;
var res:int64;
begin
res:=((f[i]-sum[i]+a[i+1]*i)-(f[j]-sum[j]+a[j+1]*j))*(a[j+1]-a[k+1])-((f[j]-sum[j]+a[j+1]*j)-(f[k]-sum[k]+a[k+1]*k))*(a[i+1]-a[j+1]);
if res<=0 then exit(true) else exit(false);
end;
begin
{assign(input,'anony.in');
reset(input);
assign(output,'anony.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    readln(n,kk);
    for i:=1 to n do begin read(a[i]); sum[i]:=sum[i-1]+a[i]; end;
    head:=1; tail:=1; stack[1]:=0;
    f[0]:=0;
    for i:=1 to n do
        begin
        while (head<tail)and(check(stack[head+1],stack[head],i)) do inc(head);
        f[i]:=f[stack[head]]+sum[i]-sum[stack[head]]-a[stack[head]+1]*(i-stack[head]);
        if i-kk+1>=kk then
           begin
           while (head<tail)and(calc(stack[tail-1],stack[tail],i-kk+1)) do dec(tail);
           inc(tail);
           stack[tail]:=i-kk+1;
           end;
        end;
    writeln(f[n]);
    end;
{close(input);
close(output);}
end.