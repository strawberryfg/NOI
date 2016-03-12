const maxn=18000; maxm=100020;
type rec=record v,nxt:longint; end;
     nodetype=record ll,rr:longint; end;
var n,m,i,j,x,y,tot,tot2,cnt,top,total,now,pd,p,head,tail:longint;
    edge,edge2,sta,stack,col,opp,deg,a,q,ans,flag,hash:array[0..maxn]of longint;
    node:array[0..maxn]of nodetype;
    vis:array[0..maxn]of boolean;
    g,tg,h:array[0..maxm]of rec;
    b,d:array[0..maxm]of longint;
procedure addedgeopp(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
addedgeopp(y,x);
end;
procedure addedge2(x,y:longint);
begin
inc(deg[y]);
inc(total); h[total].v:=y; h[total].nxt:=sta[x]; sta[x]:=total;
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
inc(now); if node[cnt].ll=0 then node[cnt].ll:=now; a[now]:=x;
col[x]:=cnt;
p:=edge2[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure work(x:longint);
var p:longint;
begin
if flag[x]=1 then exit;
flag[x]:=1;
p:=sta[x];
while p<>0 do begin work(h[p].v); p:=h[p].nxt; end;
end;
begin
assign(input,'spo.in');
reset(input);
assign(output,'spo.out');
rewrite(output);
readln(n,m);
for i:=1 to n do begin opp[2*i-1]:=2*i; opp[2*i]:=2*i-1; end;
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,opp[y]);
    addedge(y,opp[x]);
    b[i]:=x; d[i]:=y;
    end;
for i:=1 to 2*n do if not vis[i] then dfs(i);
now:=0; cnt:=0;
for i:=top downto 1 do if col[stack[i]]=0 then begin inc(cnt); dfs2(stack[i]); node[cnt].rr:=now; end;
pd:=1;
for i:=1 to n do if col[2*i-1]=col[2*i] then begin pd:=0; break; end;
if pd=0 then writeln('NIE')
   else begin
        for i:=1 to 2*n do
            begin
            p:=edge[i];
            while p<>0 do
              begin
              if col[i]<>col[g[p].v] then addedge2(col[g[p].v],col[i]);
              p:=g[p].nxt;
              end;
            end;
        head:=1; tail:=0;
        for i:=1 to cnt do if deg[i]=0 then begin inc(tail); q[tail]:=i; end;
        while head<=tail do
          begin
          p:=sta[q[head]];
          while p<>0 do
            begin
            dec(deg[h[p].v]);
            if deg[h[p].v]=0 then begin inc(tail); q[tail]:=h[p].v; end;
            p:=h[p].nxt;
            end;
          inc(head);
          end;
        for i:=1 to tail do
            begin
            if flag[q[i]]=1 then continue; // X wrong
            flag[q[i]]:=2;
            for j:=node[q[i]].ll to node[q[i]].rr do work(col[opp[a[j]]]);
            end;
        for i:=1 to cnt do
            if flag[i]=2 then
               begin
               for j:=node[i].ll to node[i].rr do begin inc(ans[0]); ans[ans[0]]:=a[j]; hash[a[j]]:=1; end;
               end;
        for i:=1 to ans[0] do writeln(ans[i]);
        end;
close(input);
close(output);
end.