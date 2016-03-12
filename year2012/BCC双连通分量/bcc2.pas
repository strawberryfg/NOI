const maxn=1020; maxm=10000;
type rec=record u,v,nxt:longint; end;
     re=record v,w:longint; end;
var n,m,i,x,y,tme,top,tot:longint;
    edge,dfn,low:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    ed:array[0..maxm]of re;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure dfs(x,fa:longint);
var p:longint;
begin
inc(tme);
dfn[x]:=tme; low[x]:=tme;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa)and(dfn[g[p].v]<dfn[x]) then
     begin
     inc(top);
     ed[top].v:=x;
     ed[top].w:=g[p].v;
     if dfn[g[p].v]=0 then
        begin
        dfs(g[p].v,x);
        low[x]:=min(low[x],low[g[p].v]);
        if low[g[p].v]>=dfn[x] then
           begin
           writeln('New component:');
           writeln('g[p].v    ',g[p].v,'   x:   ',x,' low : ',low[g[p].v],'  dfn[x]:  ',dfn[x]);
           while (ed[top+1].v<>x)or(ed[top+1].w<>g[p].v) do
             begin
             writeln('<',ed[top].v,',',ed[top].w,'>');
             dec(top);
             end;
           end;
        end
     else
        low[x]:=min(low[x],dfn[g[p].v]);
     end;
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'bcc.in');
reset(input);
assign(output,'bcc.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y);
    addedge(y,x);
    end;
top:=0;
dfs(3,0);
close(input);
close(output);
end.
