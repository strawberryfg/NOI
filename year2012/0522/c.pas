const maxn=100200; base=1000000;
var t,a,s,b,i,v,j,ll:longint;
    f,tf,hash:array[-1..maxn]of longint;
begin
{assign(input,'c.in');
reset(input);
assign(output,'c.out');
rewrite(output);}
readln(t,a,s,b);
for i:=1 to a do
    begin
    readln(v);
    inc(hash[v]);
    end;
f[0]:=1;
for i:=1 to b do f[i]:=1;
for i:=1 to t do
    begin
    tf:=f;
    for j:=0 to b do
        begin
        if j-hash[i]-1>=0 then ll:=tf[j-hash[i]-1] else ll:=0;
        f[j]:=((tf[j]-ll+base) mod base+f[j-1]) mod base;
        end;
    end;
writeln((f[b]-f[s-1]+base)mod base);
{close(input);
close(output);}
end.
