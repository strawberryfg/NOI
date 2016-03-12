const maxn=8020; maxm=300020; maxq=1000020; inf=maxlongint;
type rec=record u,v,c,nxt,op:longint; end;
var n,m,s,t,i,x,y,z,sum,tot,top,cnt:longint;
    h,hash,edge,vis,col,stack:array[0..maxn]of longint;
    g,tg:array[0..maxm]of rec;
    ans:array[0..maxm,1..2]of longint;
    q:array[0..maxq]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var tmp,p,res,fmin:longint;
begin
if x=t then exit(now);
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     now:=now-res; tmp:=tmp+res;
     if h[s]=n then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=n
      else begin
           fmin:=n-1;
           p:=edge[x];
           while p<>0 do
             begin
             if (g[p].c>0)and(h[g[p].v]<fmin) then
                fmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=fmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure sap;
var i,head,tail,p:longint;
begin
for i:=1 to n do h[i]:=n;
head:=1; tail:=1; q[1]:=t; h[t]:=0;
fillchar(hash,sizeof(hash),0);
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=n) then
       begin
       h[g[p].v]:=h[q[head]]+1;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=1 to n do inc(hash[h[i]]);
sum:=0;
while h[s]<n do sum:=sum+flow(s,inf);
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(vis[g[p].v]=0) then
     dfs(g[p].v);
  p:=g[p].nxt;
  end;
inc(top);
stack[top]:=x;
end;
procedure dfs2(x:longint);
var p:longint;
begin
col[x]:=cnt;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>=0)and(g[p].c<tg[p].c)and(col[g[p].v]=0) then
     dfs2(g[p].v);
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'mincut.in');
reset(input);
assign(output,'mincut.out');
rewrite(output);
readln(n,m,s,t);
for i:=1 to m do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    end;
for i:=1 to m do
    begin
    tg[2*i-1].c:=g[2*i-1].c;
    tg[2*i].c:=g[2*i-1].c;
    end;
sap;
for i:=1 to n do
    if vis[i]=0 then dfs(i);
cnt:=0;
for i:=top downto 1 do
    begin
    if col[stack[i]]=0 then
       begin
       inc(cnt);
       dfs2(stack[i]);
       end;
    end;
for i:=1 to 2*m do
    begin
    if i mod 2=0 then continue;
    if (g[i].c=0)and(col[g[i].u]<>col[g[i].v]) then
       begin
       ans[(i+1)div 2][1]:=1;
       if (col[g[i].u]=col[s])and(col[g[i].v]=col[t]) then
          ans[(i+1)div 2][2]:=1;
       end;
    end;
for i:=1 to m do writeln(ans[i][1],' ',ans[i][2]);
close(input);
close(output);
end.
