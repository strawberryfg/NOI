const maxn=2020; maxm=8000020;
type rec=record v,nxt:longint; end;
var n,m,i,t,x,y,z,tot,tot2,cnt,top,pd:longint;
    edge,edge2,col,stack:array[0..maxn]of longint;
    vis:array[0..maxn]of boolean;
    g,h:array[0..maxm]of rec;
    s,ts:string;
    code:integer;
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
{assign(input,'puzzle.in');
reset(input);
assign(output,'puzzle.out');
rewrite(output);}
readln(n,m);
for i:=1 to m do
    begin
    readln(s);
    t:=pos(' ',s);
    ts:=copy(s,1,t-1);
    val(ts,x,code);
    inc(x);
    delete(s,1,t);
    t:=pos(' ',s);
    ts:=copy(s,1,t-1);
    val(ts,y,code);
    inc(y);
    delete(s,1,t);
    t:=pos(' ',s);
    ts:=copy(s,1,t-1);
    val(ts,z,code);
    delete(s,1,t);
    if s='XOR' then
       begin
       if z=1 then begin addedge(x,y+n); addedge(y+n,x); addedge(y,x+n); addedge(x+n,y); end
          else begin addedge(x,y); addedge(y,x); addedge(x+n,y+n); addedge(y+n,x+n); end;
       end
    else if s='OR' then
            begin
            if z=1 then begin addedge(x,y+n); addedge(y,x+n); end
               else begin addedge(x,y); addedge(y,x); addedge(x+n,x); addedge(y+n,y); end;
            end
         else begin
              if z=1 then begin addedge(x+n,y+n); addedge(y+n,x+n); addedge(x,x+n); addedge(y,y+n); end
                 else begin addedge(x+n,y); addedge(y+n,x); end;
              end;
    end;
for i:=1 to 2*n do if not vis[i] then dfs(i);
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
for i:=1 to n do if col[i]=col[i+n] then begin pd:=0; break; end;
if pd=1 then writeln('YES') else writeln('NO');
{close(input);
close(output);}
end.