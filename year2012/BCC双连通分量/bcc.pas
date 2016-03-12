const maxn=100; maxm=100;
type rec=record u,v,nxt:longint; end;
var n,m,i,tot,tme,top,cnt,x,y:longint;
    dfn,edge,stack,low:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure tarjan(x,fa:longint);
var p:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme;
inc(top); stack[top]:=x;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa)and(dfn[g[p].v]<dfn[x]) then
     begin
     if dfn[g[p].v]=0 then
        begin
        tarjan(g[p].v,x);
        if low[g[p].v]<low[x] then low[x]:=low[g[p].v];
        if low[g[p].v]>=dfn[x] then
           begin
           inc(cnt);
           while (top>0)and(stack[top]<>x) do
             begin
             write(stack[top],'    :    ');
             dec(top);
             end;
           write(x);
           writeln;
           end;
        end
     else
        if dfn[g[p].v]<low[x] then
           low[x]:=dfn[g[p].v];
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
for i:=1 to m do begin readln(x,y); addedge(x,y); addedge(y,x); end;
for i:=1 to n do
    if dfn[i]=0 then
       tarjan(i,0);
close(input);
close(output);
end.
