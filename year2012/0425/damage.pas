const maxn=30200; maxm=300000; maxq=1000020;
type rec=record u,v,nxt:longint; end;
var n,m,i,x,y,kind,p,v,cnt,tot,head,tail:longint;
    edge,hash,a:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    q:array[0..maxq]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
begin
assign(input,'damage.in');
reset(input);
assign(output,'damage.out');
rewrite(output);
readln(n,m,kind);
for i:=1 to m do
    begin
    readln(x,y);
    if x<>y then
       begin
       addedge(x,y);
       addedge(y,x);
       end;
    end;
for i:=1 to n do a[i]:=1;
for i:=1 to kind do
    begin
    readln(v);
    p:=edge[v];
    while p<>0 do
      begin
      a[g[p].v]:=0;
      p:=g[p].nxt;
      end;
    end;
head:=1; tail:=1;
hash[1]:=1;
q[1]:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (hash[g[p].v]=0)and(a[g[p].v]=1) then
       begin
       hash[g[p].v]:=1;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
cnt:=0;
for i:=1 to n do if hash[i]=1 then inc(cnt);
writeln(n-cnt);
close(input);
close(output);
end.
