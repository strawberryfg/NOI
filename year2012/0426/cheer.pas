const maxn=30200; maxm=300020; inf=maxlongint;
type rec=record u,v,w:longint; end;
var n,m,i,x,y,z,tot,cnt,ans,t1,t2,min:longint;
    a,fa:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
procedure sort(l,r: longint);
var i,j,x: longint;
    y:rec;
begin
i:=l; j:=r; x:=g[(l+r) div 2].w;
repeat
while g[i].w<x do inc(i);
while x<g[j].w do dec(j);
if not(i>j) then begin y:=g[i]; g[i]:=g[j]; g[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
begin
assign(input,'cheer.in');
reset(input);
assign(output,'cheer.out');
rewrite(output);
readln(n,m);
min:=inf;
for i:=1 to n do begin readln(a[i]); if a[i]<min then min:=a[i]; end;
tot:=0;
for i:=1 to m do
    begin
    readln(x,y,z);
    inc(tot);
    g[tot].u:=x; g[tot].v:=y; g[tot].w:=2*z+a[x]+a[y];
    end;
for i:=1 to n do fa[i]:=i;
sort(1,tot);
i:=1; cnt:=0; ans:=0;
while (cnt<n-1)and(i<=tot) do
  begin
  t1:=getfa(g[i].u); t2:=getfa(g[i].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     ans:=ans+g[i].w;
     inc(cnt);
     end;
  inc(i);
  end;
writeln(ans+min);
close(input);
close(output);
end.
