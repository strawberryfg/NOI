const maxn=200020;
type rec=record u,v,nxt:longint; end;
var n,q,i,ch,x,y,tot,tme,d:longint;
    edge,st,en,bit,tree:array[0..maxn]of longint;
    g:array[0..2*maxn]of rec;
    f:array[0..maxn,0..18]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
procedure dfs(x,from:longint);
var i,p:longint;
begin
inc(tme); st[x]:=tme;               // in time flag
f[x][0]:=from;
for i:=1 to 18 do
    begin
    f[x][i]:=f[f[x][i-1]][i-1];
    end;
p:=edge[x];
while p<>0 do
  begin
  if g[p].v<>from then              // out time flag
     dfs(g[p].v,x);
  p:=g[p].nxt;
  end;
en[x]:=tme;
end;
procedure add(x,d:longint);
begin
while x<=n do
  begin
  bit[x]:=bit[x]+d;
  x:=x+x and -x;
  end;
end;
function ask(x:longint):longint;
var res:longint;
begin
res:=0;
while x>0 do
  begin
  res:=res+bit[x];
  x:=x-x and -x;
  end;
exit(res);
end;
function query(x:longint):longint;
var i,tmp:longint;
begin
if ask(st[x])=0 then exit(-1);
for i:=18 downto 0 do
    begin
    tmp:=f[x][i];
    if (tmp<>0)and(ask(st[tmp])>0) then x:=tmp;
    end;
exit(x);
end;
begin
{assign(input,'qtree3.in');
reset(input);
assign(output,'qtree3.out');
rewrite(output);}
readln(n,q);
for i:=1 to n-1 do
    begin
    readln(x,y);
    addedge(x,y);
    end;
dfs(1,0);
for i:=1 to q do
    begin
    readln(ch,x);
    if ch=1 then writeln(query(x))
       else begin
            if tree[x]=0 then begin tree[x]:=1; d:=1; end
               else begin tree[x]:=0; d:=-1; end;
            add(st[x],d); add(en[x]+1,-d);
            end;
    end;
{close(input);
close(output);}
end.
