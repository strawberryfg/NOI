const maxn=300; maxq=3000000;
type rec=record first,last:longint; end;
     node=record u,v,c,op,nxt:longint; key:extended; end;
var ttt,n,m,i,j,cur,s,t,tot:longint;
    p,f:array[0..maxn,0..maxn]of longint;
    edge:array[0..maxn]of rec;
    g:array[0..2*maxn*maxn]of node;
    fa,hash,a,b:array[0..maxn]of longint;
    d:array[0..maxn]of extended;
    q:array[0..maxq]of longint;
    ans:extended;
procedure addedge(x,y:longint; cost:extended; flow:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].key:=cost; g[tot].c:=flow;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;
edge[x].last:=tot;
g[tot].op:=tot+1;
inc(tot); g[tot].v:=x; g[tot].u:=y; g[tot].key:=-cost; g[tot].c:=0;
if edge[y].first=0 then edge[y].first:=tot
   else g[edge[y].last].nxt:=tot;
edge[y].last:=tot;
g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,x,cur,j:longint;
    flag:boolean;
begin
for i:=0 to n+m+1 do d[i]:=-1e30;
fillchar(hash,sizeof(hash),0);
q[1]:=s; head:=1; tail:=1;
flag:=false;
d[s]:=0;
fillchar(fa,sizeof(fa),0);
while head<=tail do
  begin
  x:=q[head];
  cur:=edge[x].first;
  while cur<>0 do
    begin
    j:=g[cur].v;
    if (g[cur].c>0)and(d[x]+g[cur].key>d[j]) then
       begin
       d[j]:=d[x]+g[cur].key;
       fa[j]:=cur;
       if j=t then flag:=true;
       if hash[j]=0 then
          begin
          hash[j]:=1;
          inc(tail);
          q[tail]:=j;
          end;
       end;
    cur:=g[cur].nxt;
    end;
  inc(head);
  hash[x]:=0;
  end;
if not flag then exit(false);
cur:=fa[t];
while cur<>0 do
  begin
  ans:=ans+g[cur].key;
  dec(g[cur].c);
  inc(g[g[cur].op].c);
  cur:=fa[g[cur].u];
  end;
exit(true);
end;
begin
assign(input,'image.in');
reset(input);
assign(output,'image.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        read(p[i][j]);
    readln;
    end;
for i:=1 to n do read(a[i]);
for i:=1 to m do read(b[i]);
s:=0; t:=n+m+1;
for i:=1 to n do
    addedge(s,i,0,a[i]);
for i:=1 to m do addedge(i+n,t,0,b[i]);
for i:=1 to n do
    for j:=1 to m do
        begin
        if p[i][j]=0 then
           addedge(i,j+n,-1e30,1)
        else
           addedge(i,j+n,ln(p[i][j])/100,1);
        end;
while spfa do ttt:=1;
for i:=1 to n do
    begin
    cur:=edge[i].first;
    while cur<>0 do
      begin
      j:=g[cur].v;
      if (j>n)and(j<=n+m)and(g[cur].c=0) then
          f[i][j-n]:=1;
      cur:=g[cur].nxt;
      end;
    end;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        write(f[i][j]);
        end;
    writeln;
    end;
//writeln(exp(ans):0:10);
close(input);
close(output);
end.
