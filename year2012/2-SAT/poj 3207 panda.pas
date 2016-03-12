const maxm=1020;
type linetype=record x,y:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,j,tot,tot2,cnt,pd,top:longint;
    a:array[0..maxm]of linetype;
    hash:array[0..maxm,0..maxm]of longint;
    vis:array[0..maxm]of boolean;
    col,edge,edge2,stack:array[0..maxm]of longint;
    g,h:array[0..maxm*maxm*5]of rec;
procedure addedge2(x,y:longint);
begin
inc(tot2); h[tot2].v:=y; h[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
addedge2(y,x);
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=true;
p:=edge[x];
while p<>0 do
  begin
  if not vis[g[p].v] then dfs(g[p].v);
  p:=g[p].nxt;
  end;
inc(top); stack[top]:=x;
end;
procedure dfs2(x:longint);
var p:longint;
begin
col[x]:=cnt;
p:=edge2[x];
while p<>0 do
  begin
  if col[h[p].v]=0 then dfs2(h[p].v);
  p:=h[p].nxt;
  end;
end;
begin
{assign(input,'panda.in');
reset(input);
assign(output,'panda.out');
rewrite(output);}
readln(n,m);
for i:=1 to m do begin readln(a[i].x,a[i].y); inc(a[i].x); inc(a[i].y); if a[i].x>a[i].y then begin a[i].x:=a[i].x+a[i].y; a[i].y:=a[i].x-a[i].y; a[i].x:=a[i].x-a[i].y; end; end;
for i:=1 to m do
    for j:=1 to m do
        begin
        if i=j then continue;
        if hash[i][j]=1 then continue;
        if (a[i].x<a[j].x)and(a[j].x<a[i].y)and(a[j].y>a[i].y) then
           begin
           addedge(i,j+m); addedge(j,i+m); addedge(j+m,i); addedge(i+m,j);
           hash[i][j]:=1;
           hash[j][i]:=1;
           end;
        end;
for i:=1 to 2*m do if not vis[i] then dfs(i);
cnt:=0;
for i:=top downto 1 do
    begin
    if col[stack[i]]=0 then
       begin
       inc(cnt);
       dfs2(stack[i]);
       end;
    end;
pd:=1;
for i:=1 to 2*m do if col[i]=col[i+m] then begin pd:=0; break; end;
if pd=1 then writeln('panda is telling the truth...')
   else writeln('the evil panda is lying again');
{close(input);
close(output);}
end.