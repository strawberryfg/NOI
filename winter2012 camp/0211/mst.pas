const maxn=5000; maxm=1000000;
type rec=record u,v,w,nxt:longint; end;
var i,test,tot,n,m,a,b,x,y,z,total:longint;
    ch:char;
    edge,g:array[0..maxm]of rec;
    f:array[0..maxn,0..maxn]of longint;
    fa,edge2:array[0..maxn]of longint;
    hash:array[0..maxm]of longint;
    procedure sort(l,r: longint);
      var
         i,j,x: longint;
         tmp:rec;
      begin
         i:=l;
         j:=r;
         x:=edge[(l+r) div 2].w;
         repeat
           while edge[i].w<x do
            inc(i);
           while x<edge[j].w do
            dec(j);
           if not(i>j) then
             begin
                tmp:=edge[i];
                edge[i]:=edge[j];
                edge[j]:=tmp;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure addedge(x,y,z:longint);
begin
inc(total); g[total].u:=x; g[total].v:=y; g[total].w:=z; g[total].nxt:=edge2[x];
edge2[x]:=total;
end;
procedure kruskal;
var i,cnt,t1,t2:longint;
begin
for i:=1 to n do fa[i]:=i;
i:=1; cnt:=0;
while (i<=tot)and(cnt<n-1) do
  begin
  t1:=getfa(edge[i].u); t2:=getfa(edge[i].v);
  if t1<>t2 then
     begin
     hash[i]:=1; //this edge is used
     inc(cnt);
     fa[t1]:=t2;
     addedge(edge[i].u,edge[i].v,edge[i].w);
     addedge(edge[i].v,edge[i].u,edge[i].w);
     end;
  inc(i);
  end;
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure dfs1(x,fa,d,root:longint);
var t,p:longint;
begin
t:=edge2[x];
f[root][x]:=d;
while t<>0 do
  begin
  p:=g[t].v;
  if (p<>fa) then
     begin
     dfs1(p,x,max(d,g[t].w),root);
     end;
  t:=g[t].nxt;
  end;
end;
procedure work1;
var i,t,ans:longint;
begin
ans:=0;
for i:=1 to n do
    begin
    dfs1(i,0,0,i);
    end;
for i:=1 to m do
    begin
    if hash[i]=0 then
       begin
       t:=f[edge[i].u][edge[i].v];
       if edge[i].w=t then inc(ans,min(a,b));
       end;
    end;
writeln(ans);
end;
begin
assign(input,'mst.in');
reset(input);
assign(output,'mst.out');
rewrite(output);
  for i:=1 to 4 do read(ch);
  read(test);
  readln(n,m,a,b);
  tot:=0;
  for i:=1 to m do
      begin
      readln(x,y,z);
      inc(tot);
      edge[tot].u:=x; edge[tot].v:=y; edge[tot].w:=z;
      end;
  sort(1,tot);
  kruskal;
  {if ((a=1)and(b=1000000000))or((b=1)and(a=1000000000)) then} work1;

close(input);
close(output);
end.
