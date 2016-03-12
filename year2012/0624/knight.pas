const maxn=200020; maxm=600020;
type qtype=record fr,tw:longint; end;
     rec=record v,nxt:longint; end;
var i,n,m,x,y,tot,top,tme,cnt,tot2,pd,sum:longint;
    edge,edge2,a,ans,vis,col,low,dfn,bel,from:array[0..maxn]of longint;
    g,tg:array[0..maxm*2]of rec;
    q:array[0..maxm*2]of qtype;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure addedge2(x,y:longint);
begin
if from[x]<>cnt then begin from[x]:=cnt; edge2[x]:=0; end;
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure update(x:longint);
begin
if bel[x]<>cnt then begin bel[x]:=cnt; inc(a[0]); a[a[0]]:=x; end;
end;
procedure dfs(x,sta:longint);
var p:longint;
begin
col[x]:=sta; vis[x]:=cnt;
p:=edge2[x];
while p<>0 do
  begin
  if vis[tg[p].v]<>cnt then dfs(tg[p].v,3-sta)
     else if col[tg[p].v]<>3-sta then begin pd:=1; exit; end;
  if pd=1 then exit;
  p:=tg[p].nxt;
  end;
end;
procedure solve;
var i:longint;
begin
pd:=0;
for i:=1 to a[0] do if vis[a[i]]<>cnt then dfs(a[i],1);
if pd=1 then for i:=1 to a[0] do ans[a[i]]:=1;
//not a bipartite graph;
end;
procedure tarjan(x,fa:longint);
var p:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa)and(dfn[g[p].v]<dfn[x]) then
     begin
     inc(top);
     q[top].fr:=x; q[top].tw:=g[p].v;
     if dfn[g[p].v]=0 then
        begin
        tarjan(g[p].v,x);
        low[x]:=min(low[x],low[g[p].v]);
        if low[g[p].v]>=dfn[x] then
           begin
           inc(cnt); //
           a[0]:=0; tot2:=0;
           while (q[top+1].fr<>x)or(q[top+1].tw<>g[p].v) do
             begin
             update(q[top].fr); update(q[top].tw);
             addedge2(q[top].fr,q[top].tw); addedge2(q[top].tw,q[top].fr);
             dec(top);
             end;
           solve;
           end;
        end
     else low[x]:=min(low[x],dfn[g[p].v]);
     end;
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'knight.in');
reset(input);
assign(output,'knight.out');
rewrite(output);
readln(n,m);
tot:=0;
for i:=1 to m do begin readln(x,y); addedge(x,y); addedge(y,x); end;
tme:=0; top:=0; cnt:=0;
fillchar(ans,sizeof(ans),0);
for i:=1 to n do if dfn[i]=0 then tarjan(i,0);
sum:=0;
for i:=1 to n do if ans[i]=0 then inc(sum);
writeln(sum);
close(input);
close(output);
end.