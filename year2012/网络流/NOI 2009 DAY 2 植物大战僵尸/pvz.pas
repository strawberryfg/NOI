//21:12; 22:12;
const maxr=33; maxc=33; maxn=2555; maxm=1666666; inf=maxlongint;
type rec=record v,nxt,c,op:longint; end;
var r,c,i,j,num,k,x,y,s,t,top,posi,p,ans,tot,tot2,totopp,total,cnt:longint;
    id:array[0..maxr,0..maxc]of longint;
    edge,edge2,edgeopp,sta,a,stack,map,h,q,hash,col,sum:array[0..maxn]of longint;
    vis:array[0..maxn]of boolean;
    add:array[0..maxn,0..maxn]of integer;
    g,tg,net,th:array[0..maxm]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure addedgeopp(x,y:longint);
begin
inc(totopp); tg[totopp].v:=y; tg[totopp].nxt:=edgeopp[x]; edgeopp[x]:=totopp;
end;
procedure addedgenet(x,y,z:longint);
begin
inc(total); net[total].v:=y; net[total].c:=z; net[total].nxt:=sta[x]; sta[x]:=total; net[total].op:=total+1;
inc(total); net[total].v:=x; net[total].c:=0; net[total].nxt:=sta[y]; sta[y]:=total; net[total].op:=total-1;
end;
procedure addedgecomponent(x,y:longint);
begin
inc(tot2); th[tot2].v:=y; th[tot2].nxt:=edge2[x]; edge2[x]:=tot2; add[x][y]:=1;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var p,res,tmp,mmin:longint;
begin
if x=t then exit(now);
p:=sta[x]; tmp:=0;
while p<>0 do
  begin
  if (net[p].c>0)and(h[net[p].v]+1=h[x]) then
     begin
     res:=flow(net[p].v,min(net[p].c,now));
     net[p].c:=net[p].c-res; net[net[p].op].c:=net[net[p].op].c+res;
     now:=now-res; tmp:=tmp+res;
     if h[s]=t+1 then exit(tmp);
     if now=0 then break;
     end;
  p:=net[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=t+1
      else begin
           p:=sta[x]; mmin:=t;
           while p<>0 do
             begin
             if (net[p].c>0)and(h[net[p].v]<mmin) then mmin:=h[net[p].v];
             p:=net[p].nxt;
             end;
           h[x]:=mmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure sap;
var head,tail,i,p,ret:longint;
begin
for i:=s to t do h[i]:=t+1; h[t]:=0;
fillchar(hash,sizeof(hash),0);
head:=1; tail:=1; q[1]:=t;
while head<=tail do
  begin
  p:=sta[q[head]];
  while p<>0 do
    begin
    if (net[p].c=0)and(h[net[p].v]=t+1) then
       begin
       h[net[p].v]:=h[q[head]]+1;
       inc(tail); q[tail]:=net[p].v;
       end;
    p:=net[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ret:=0;
while h[s]<t+1 do ret:=ret+flow(s,inf);
if posi-ret>ans then ans:=posi-ret;
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
col[x]:=cnt; inc(sum[cnt]);
p:=edgeopp[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure bfs(x:longint);
var head,tail,p:longint;
begin
head:=1; tail:=1; q[1]:=x; map[x]:=1;
while head<=tail do
  begin
  p:=edge2[q[head]];
  while p<>0 do
    begin
    if (map[th[p].v]=0) then
       begin
       inc(tail); q[tail]:=th[p].v; map[th[p].v]:=1;
       end;
    p:=th[p].nxt;
    end;
  inc(head);
  end;
end;
begin
assign(input,'pvz.in');
reset(input);
assign(output,'pvz.out');
rewrite(output);
read(r,c);
s:=0; t:=r*c+1;
for i:=1 to r do
    for j:=1 to c do
        id[i][j]:=(i-1)*c+j;
for i:=1 to r do
    for j:=1 to c do
        begin
        read(a[id[i][j]]);
        read(num);
        for k:=1 to num do
            begin
            read(x,y);
            inc(x); inc(y);
            addedge(id[i][j],id[x][y]);
            addedgeopp(id[x][y],id[i][j]);
            end;
        end;
for i:=1 to r do
    for j:=1 to c-1 do
        begin
        addedge(id[i][j+1],id[i][j]);
        addedgeopp(id[i][j],id[i][j+1]);
        end;
top:=0;
for i:=1 to r*c do if not vis[i] then dfs(i);
cnt:=0;
for i:=top downto 1 do
    if col[stack[i]]=0 then
       begin
       inc(cnt);
       dfs2(stack[i]);
       end;
for i:=1 to r*c do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      if (col[i]<>col[g[p].v])and(add[col[i]][col[g[p].v]]=0) then addedgecomponent(col[i],col[g[p].v]);
      p:=g[p].nxt;
      end;
    end;
//1: not in network;
for i:=1 to cnt do if (sum[i]>1)and(map[i]=0) then bfs(i);
posi:=0;
for i:=1 to r*c do
    begin
    if (a[i]=0)or(map[col[i]]=1) then continue;
    p:=edgeopp[i];
    while p<>0 do
      begin
      if map[col[tg[p].v]]=0 then addedgenet(i,tg[p].v,inf);
      p:=tg[p].nxt;
      end;
    if a[i]>0 then begin posi:=posi+a[i]; addedgenet(s,i,a[i]); end else addedgenet(i,t,-a[i]);
    end;
ans:=0;
sap;
writeln(ans);
close(input);
close(output);
end.