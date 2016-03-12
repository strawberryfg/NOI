//18:06;
const maxn=30020; maxm=500020; maxque=500020;
type quetype=record opt,u,v:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,t,tot,cnt,x,t1,t2,anc,ans:longint;
    dep,edge,from,top,a,maxnum,bel,b,posi,hash,vis,size:array[0..maxn]of longint;
    tree:array[0..maxn*4]of longint;
    f:array[0..maxn,0..16]of longint;
    g:array[0..maxm]of rec;
    que:array[0..maxque]of quetype;
    s,ts:string;
    code:integer;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getfa(x:longint):longint;
begin
if from[x]<>x then from[x]:=getfa(from[x]);
exit(from[x]);
end;
function work(x,step:longint):longint;
var now:longint;
begin
now:=-1;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then x:=f[x][now];
  step:=step div 2;
  end;
work:=x;
end;
function lca(x,y:longint):longint;
var i:longint;
begin
if dep[x]<dep[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
x:=work(x,dep[x]-dep[y]);
if x=y then exit(x);
for i:=16 downto 0 do
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
exit(f[x][0]);
end;
procedure dfs(x,fa,d:longint);
var p,i:longint;
begin
dep[x]:=d; hash[x]:=1;
f[x][0]:=fa; size[x]:=1; maxnum[x]:=-1;
for i:=1 to 16 do f[x][i]:=f[f[x][i-1]][i-1];
p:=edge[x];
while p<>0 do
  begin
  if g[p].v<>fa then begin dfs(g[p].v,x,d+1); size[x]:=size[x]+size[g[p].v]; if (maxnum[x]=-1)or(size[g[p].v]>size[maxnum[x]]) then maxnum[x]:=g[p].v; end;
  p:=g[p].nxt;
  end;
end;
procedure cuttree(x,last,fa:longint);
var p:longint;
begin
top[x]:=last; inc(cnt); b[cnt]:=x; bel[x]:=cnt; vis[x]:=1;
if maxnum[x]<>-1 then cuttree(maxnum[x],last,x);
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa)and(g[p].v<>maxnum[x]) then cuttree(g[p].v,g[p].v,x);
  p:=g[p].nxt;
  end;
end;
procedure init(f,t,x:longint);
begin
if f=t then begin posi[f]:=x; exit; end;
init(f,(f+t) div 2,x*2); init((f+t) div 2+1,t,x*2+1);
end;
procedure modify(num:longint);
var x:longint;
begin
x:=posi[bel[num]]; tree[x]:=a[num];
while x div 2>0 do
  begin
  tree[x div 2]:=tree[x div 2*2]+tree[x div 2*2+1];
  x:=x div 2;
  end;
end;
function query(f,t,l,r,x:longint):longint;
var mid:longint;
begin
if (f<=l)and(r<=t) then exit(tree[x]);
mid:=(l+r) div 2;
query:=0;
if f<=mid then query:=query(f,t,l,mid,x*2);
if t>mid then query:=query+query(f,t,mid+1,r,x*2+1);
end;
procedure subprob(x,anc:longint);
begin
while x<>anc do
  begin
  if bel[top[x]]>bel[anc] then
     begin
     ans:=ans+query(bel[top[x]],bel[x],1,n,1);
     x:=f[top[x]][0];
     end
  else
     begin
     ans:=ans+query(bel[anc]+1,bel[x],1,n,1);
     break;
     end;
  end;
end;
procedure solve(u,v:longint);
begin
anc:=lca(u,v);
ans:=0;
subprob(u,anc); subprob(v,anc); ans:=ans+a[anc];
writeln(ans);
end;
begin
{assign(input,'trip.in');
reset(input);
assign(output,'trip.out');
rewrite(output);}
readln(n);
for i:=1 to n do read(a[i]);
readln(m);
for i:=1 to n do from[i]:=i;
for i:=1 to m do
    begin
    readln(s);
    t:=pos(' ',s); ts:=copy(s,1,t-1);
    if ts[1]='b' then que[i].opt:=1 else if ts[1]='p' then que[i].opt:=2 else que[i].opt:=3;
    delete(s,1,t); t:=pos(' ',s); ts:=copy(s,1,t-1); val(ts,que[i].u,code);
    delete(s,1,t); val(s,que[i].v,code);
    if que[i].opt=1 then
       begin
       t1:=getfa(que[i].u); t2:=getfa(que[i].v);
       if t1<>t2 then begin from[t2]:=t1; addedge(que[i].u,que[i].v); addedge(que[i].v,que[i].u); end;
       end;
    end;
for i:=1 to n do if hash[i]=0 then dfs(i,0,0);
cnt:=0;
for i:=1 to n do if vis[i]=0 then cuttree(i,i,0);
init(1,n,1);
for i:=1 to n do modify(i);
for i:=1 to n do from[i]:=i;
for i:=1 to m do
    begin
    if que[i].opt=1 then
       begin
       t1:=getfa(que[i].u); t2:=getfa(que[i].v);
       if t1<>t2 then begin writeln('yes'); from[t2]:=t1; end
          else writeln('no');
       end
    else if que[i].opt=2 then begin a[que[i].u]:=que[i].v; modify(que[i].u); end
            else begin
                 t1:=getfa(que[i].u); t2:=getfa(que[i].v);
                 if t1=t2 then solve(que[i].u,que[i].v) else writeln('impossible');
                 end;
    end;
{close(input);
close(output);}

end.