const maxn=20020;
var n,st,i,head,tail:longint;
    f,t,sumf,sumt,h,stack:array[0..maxn]of longint;
function calc(u,v,i:longint):boolean;
var res:longint;
begin
res:=h[u]-h[v]-sumf[i]*(sumt[u]-sumt[v]);
if res<=0 then exit(true) else exit(false);
end;
function check(k,j,i:longint):boolean;
var res:longint;
begin
res:=(h[i]-h[j])*(sumt[j]-sumt[k])-(h[j]-h[k])*(sumt[i]-sumt[j]);
if res<=0 then exit(true) else exit(false);
end;
begin
{assign(input,'batch.in');
reset(input);
assign(output,'batch.out');
rewrite(output); }
readln(n);
readln(st);
for i:=1 to n do readln(t[i],f[i]);
sumt[n+1]:=0; sumf[n+1]:=0;
for i:=n downto 1 do begin sumt[i]:=sumt[i+1]+t[i]; sumf[i]:=sumf[i+1]+f[i]; end;
h[n]:=(st+sumt[n])*sumf[n];
h[n+1]:=0; stack[1]:=n+1;
stack[2]:=n; head:=1; tail:=2;
for i:=n-1 downto 1 do
    begin
    while (head<tail)and(calc(stack[head+1],stack[head],i)) do inc(head);
    h[i]:=h[stack[head]]+(st+sumt[i]-sumt[stack[head]])*sumf[i];
    while (head<tail)and(check(stack[tail-1],stack[tail],i)) do dec(tail);
    inc(tail); stack[tail]:=i;
    end;
writeln(h[1]);
{close(input);
close(output);}
end.