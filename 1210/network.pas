const maxn=2020; maxm=800020;
type node=record first,last:longint; end;
     edgenode=record v,nxt,cnt:longint; end;
var n,m,i,x,y,dep,dep2,tot,now,ans:longint;
    edge:array[0..maxn]of node;
    g:array[0..maxm]of edgenode;
    dfn,low,dfn2,low2,son,sum,fu2:array[0..maxn]of longint;
    cut,vis:array[0..maxn]of boolean;
    pd:boolean;
procedure addedge(x,y:longint);
var t:longint;
begin
t:=edge[x].first;
inc(sum[y]);
while t<>0 do
   begin
   if g[t].v=y then begin inc(g[t].cnt); exit; end;
   t:=g[t].nxt;
   end;
inc(son[y]);
inc(tot); g[tot].v:=y;
g[tot].cnt:=1;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;
edge[x].last:=tot;

end;
procedure tarjan(x:longint);
var t,p:longint;
    flag:boolean;
begin
t:=edge[x].first;
inc(dep); dfn[x]:=dep; low[x]:=dep;
flag:=false;
while t<>0 do
  begin
  p:=g[t].v;
  if dfn[p]=0 then
     begin
     tarjan(p);
     if low[p]<low[x] then low[x]:=low[p];
     if (low[p]>dfn[x]) then flag:=true;
     if (low[p]=dfn[x]) then flag:=true;
     end
  else
     if dfn[p]<low[x] then low[x]:=dfn[p];
  t:=g[t].nxt;
  end;
if flag then
   begin
   if x=1 then pd:=flag;
   if {((x=1)and(son[x]>=2))or}(x<>1) then cut[x]:=true;
   end;
end;
procedure tarjan2(x:longint);
var t,p:longint;
begin
t:=edge[x].first;
inc(dep2); dfn2[x]:=dep2; low2[x]:=dep2;
while t<>0 do
  begin
  p:=g[t].v;
  if p=now then begin t:=g[t].nxt; continue; end;
  if dfn2[p]=0 then
     begin
     tarjan2(p);
     if low2[p]<low2[x] then
        begin
        low2[x]:=low2[p];
        fu2[x]:=g[t].cnt;
        end
     else if low2[p]=low2[x] then inc(fu2[x],g[t].cnt);
     if low2[p]>dfn2[x] then
        begin
        inc(tot);
        end;
     if (low2[p]=dfn2[x])and(fu2[p]=1) then
        inc(tot);
     end
  else
     if dfn2[p]<low2[x] then
        begin
        fu2[x]:=g[t].cnt;
        low2[x]:=dfn2[p];
        end
     else if dfn2[p]=low2[x] then inc(fu2[x],g[t].cnt);
  t:=g[t].nxt;
  end;
end;
procedure dfs(x:longint);
var t,p:longint;
begin
vis[x]:=true;
t:=edge[x].first;
while t<>0 do
  begin
  p:=g[t].v;
  if(p<>1)and(not vis[p]) then dfs(p);
  t:=g[t].nxt;
  end;
end;
begin
assign(input,'network.in');
reset(input);
assign(output,'network.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y);
    addedge(y,x);
    end;
dep:=0;
tarjan(1);
pd:=false;
dfs(2);
if pd then
   begin
   for i:=1 to n do if not vis[i] then pd:=false;
   if not pd then cut[1]:=true;
   end;
ans:=0;
for i:=1 to n do
    begin
    now:=i;
    if (cut[i]) then
       begin
       ans:=ans+m-sum[i];
       end
    else
       begin
       fillchar(dfn2,sizeof(dfn2),0);
       dep2:=0;
       tot:=0;
       if i+1<=n then tarjan2(i+1) else tarjan2(1);
       ans:=ans+tot;
       end;
    end;
writeln(ans);
close(input);
close(output);
end.
