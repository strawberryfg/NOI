const maxn=20020;
type node=record first,last:longint; end;
     edgenode=record u,v,nxt:longint; end;
var tot,u,i,a,b,n:longint;
    tmp,ans:int64;
    edge:array[0..maxn]of node;
    g:array[0..2*maxn]of edgenode;
    son,hash,fa:array[0..maxn]of longint;
procedure init;
var i:longint;
begin
tot:=0;
for i:=0 to maxn do begin edge[i].first:=0; edge[i].last:=0; end;
for i:=0 to 2*maxn do begin g[i].u:=0; g[i].v:=0; g[i].nxt:=0; end;
fillchar(hash,sizeof(hash),0);
fillchar(fa,sizeof(fa),0);
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;
edge[x].last:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x;
if edge[y].first=0 then edge[y].first:=tot
   else g[edge[y].last].nxt:=tot;
edge[y].last:=tot;
end;
procedure dfs(x:longint);
var t,q:longint;
begin
hash[x]:=1;
t:=edge[x].first;
son[x]:=1;
while t<>0 do
  begin
  q:=g[t].v;
  if hash[q]=0 then
     begin
     fa[q]:=x;
     dfs(q);
     son[x]:=son[x]+son[q];
     end;
  t:=g[t].nxt;
  end;
end;
begin
assign(input,'bonus.in');
reset(input);
assign(output,'bonus.out');
rewrite(output);
while not eof do
  begin
  readln(n);
  init;
  for i:=1 to n-1 do
      begin
      readln(a,b);
      addedge(a,b);
      end;
  dfs(1);
  ans:=0;
  for i:=1 to tot do
      begin
      if i mod 2=0 then continue;
      if fa[g[i].u]=g[i].v then
         tmp:=son[g[i].u]*(n-son[g[i].u])
      else
         tmp:=son[g[i].v]*(n-son[g[i].v]);
      tmp:=tmp*tmp;
      ans:=ans+tmp;
      end;
  tmp:=n*(n-1)div 2; tmp:=tmp*tmp;
  writeln(round(ans/tmp*1000000)/1000000:0:6);
  end;
close(input);
close(output);
end.