const maxn=3020; maxm=4000020;
type nodetype=record ll,rr:longint; end;
     rec=record v,nxt:longint; end;
var n,m,now,cnt,tot,tot2,total,top:longint;
    edge,edge2,sta,opp,col,stack,flag,hash,ans,deg,a,q:array[0..maxn]of longint;
    vis:array[0..maxn]of boolean;
    node:array[0..maxn]of nodetype;
    g,tg,h:array[0..maxm]of rec;
procedure addedge2(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
addedge2(y,x);
end;
procedure addedgescc(x,y:longint);
begin
inc(deg[y]); inc(total); h[total].v:=y; h[total].nxt:=sta[x]; sta[x]:=total;
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
inc(now); a[now]:=x;
col[x]:=cnt; if node[cnt].ll=0 then node[cnt].ll:=now;
p:=edge2[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure init;
begin
tot:=0; tot2:=0; total:=0; now:=0;
fillchar(edge,sizeof(edge),0);
fillchar(edge2,sizeof(edge2),0);
fillchar(sta,sizeof(sta),0);
fillchar(deg,sizeof(deg),0);
fillchar(flag,sizeof(flag),0);
fillchar(hash,sizeof(hash),0);
fillchar(node,sizeof(node),0);
//fillchar(g,sizeof(g),0);
fillchar(vis,sizeof(vis),false);
fillchar(col,sizeof(col),0);
fillchar(stack,sizeof(stack),0);
end;
procedure scan(x:longint);
var p:longint;
begin
if flag[x]=1 then exit;
flag[x]:=1;
p:=sta[x];
while p<>0 do
  begin
  scan(h[p].v);
  p:=h[p].nxt;
  end;
end;
procedure work;
var i,j,t,x,y,p,head,tail,pd,sum:longint;
    code:integer;
    ch1,ch2:char;
    s1,s2,s:string;
begin
init;
for i:=1 to 2*n do begin opp[i]:=i+2*n; opp[i+2*n]:=i; end;
for i:=1 to m do
    begin
    readln(s);
    sum:=0; x:=0; y:=0;
    for j:=1 to length(s) do
        begin
        if s[j]=' ' then continue;
        if (ord(s[j])>=ord('0'))and(ord(s[j])<=ord('9')) then
           begin
           if sum=0 then x:=x*10+ord(s[j])-ord('0')
              else y:=y*10+ord(s[j])-ord('0');
           end
        else
           begin
           inc(sum);
           if sum=1 then ch1:=s[j] else ch2:=s[j];
           end;
        end;
    inc(x); inc(y);
    if ch1='w' then x:=x+n;
    if ch2='w' then y:=y+n;
    addedge(opp[x],y);
    addedge(opp[y],x);
    end;
addedge(opp[n+1],n+1); //n+1: wife 0
for i:=1 to n do
    begin
    addedge(i,opp[i+n]); addedge(opp[i+n],i);
    addedge(i+n,opp[i]); addedge(opp[i],i+n);
    end;
top:=0;
for i:=1 to 4*n do if not vis[i] then dfs(i);
cnt:=0; now:=0;
for i:=top downto 1 do if col[stack[i]]=0 then begin inc(cnt); dfs2(stack[i]); node[cnt].rr:=now; end;
pd:=1;
for i:=1 to 2*n do if col[i]=col[i+2*n] then begin pd:=0; break; end;
if pd=0 then begin writeln('bad luck'); exit; end;
for i:=1 to 4*n do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      if col[i]<>col[g[p].v] then addedgescc(col[g[p].v],col[i]);
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
    if flag[q[i]]=1 then continue;
    flag[q[i]]:=2;
    for j:=node[q[i]].ll to node[q[i]].rr do scan(col[opp[a[j]]]);
    end;
for i:=1 to cnt do
    if flag[i]=2 then
       for j:=node[i].ll to node[i].rr do
           hash[a[j]]:=1;
ans[0]:=0;
for i:=1 to 2*n do if (hash[i]=1)and(i<>n+1) then begin inc(ans[0]); ans[ans[0]]:=i; end;
for i:=1 to ans[0]-1 do if ans[i]>n then write(ans[i]-n-1,'w ') else write(ans[i]-1,'h ');
if ans[ans[0]]>n then write(ans[ans[0]]-n-1,'w') else write(ans[ans[0]]-1,'h');
writeln;
end;
begin
{assign(input,'wedding.in');
reset(input);
assign(output,'wedding.out');
rewrite(output);}
readln(n,m);
while (n<>0)and(m<>0) do
  begin
  work;
  readln(n,m);
  end;
{close(input);
close(output);}
end.