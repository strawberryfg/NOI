//22:25;
const maxn=5001; maxm=400020; inf=maxlongint;
type rec=record v,nxt:longint; end;
var n,m,i,x,y,tot,tot2,tme,anc:longint;
    edge,edge2,low,dfn,dep,flag,hash,ans,a:array[0..2*maxn]of longint;
    f,fmin:array[0..maxn,0..13]of longint;
    g,tg:array[0..maxm]of rec;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedge2(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
addedge2(y,x);
end;
procedure init;
begin
tot:=0; tot2:=0; tme:=0;
fillchar(f,sizeof(f),0);
fillchar(dep,sizeof(dep),0);
fillchar(edge,sizeof(edge),0);
fillchar(edge2,sizeof(edge2),0);
fillchar(low,sizeof(low),0);
fillchar(dfn,sizeof(dfn),0);
fillchar(flag,sizeof(flag),0);
fillchar(hash,sizeof(hash),0);
fillchar(fmin,sizeof(fmin),0);
fillchar(ans,sizeof(ans),0);
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
for i:=13 downto 0 do
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
lca:=f[x][0];
end;
function getmin(x,opt:longint):longint;
begin
if fmin[x][opt]<>0 then exit(fmin[x][opt]);
if opt=0 then begin fmin[x][opt]:=low[x]; exit(fmin[x][opt]); end;
fmin[x][opt]:=min(getmin(x,opt-1),getmin(f[x][opt-1],opt-1));
getmin:=fmin[x][opt];
end;
function calc(x,step:longint):longint;
var now,ret:longint;
begin
now:=-1; ret:=inf;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then begin ret:=min(ret,getmin(x,now)); x:=f[x][now]; end;
  step:=step div 2;
  end;
calc:=ret;
end;
procedure dfs(x,fa,d:longint);
var p,i:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme; a[tme]:=x; dep[x]:=d;
f[x][0]:=fa;
for i:=1 to 13 do f[x][i]:=f[f[x][i-1]][i-1];
p:=edge[x];
while p<>0 do
  begin
  if dfn[g[p].v]=0 then dfs(g[p].v,x,d+1);
  p:=g[p].nxt;
  end;
end;
procedure solve;
var i,p:longint;
begin
dfs(1,0,0);
for i:=n downto 1 do
    begin
    p:=edge2[a[i]];
    while p<>0 do
      begin
      if tg[p].v<>f[a[i]][0] then
         begin
         if flag[tg[p].v]=0 then low[a[i]]:=min(low[a[i]],low[tg[p].v])
            else begin
                 anc:=lca(a[i],tg[p].v);
                 if anc=a[i] then
                    begin
                    low[a[i]]:=min(low[a[i]],calc(tg[p].v,dep[tg[p].v]-dep[a[i]]));
                    end
                 else
                    begin
                    low[a[i]]:=min(low[a[i]],low[anc]);
                    low[a[i]]:=min(low[a[i]],calc(tg[p].v,dep[tg[p].v]-dep[anc]));
                    end;
                 end;
         end;
      p:=tg[p].nxt;
      end;
    flag[a[i]]:=1;
    end;
for i:=1 to n do if (f[i][0]<>0)and(low[i]>=dfn[f[i][0]]) then hash[f[i][0]]:=1;
for i:=1 to n do if hash[i]=1 then begin inc(ans[0]); ans[ans[0]]:=i; end;
writeln(ans[0]);
for i:=1 to ans[0]-1 do write(ans[i],' '); write(ans[ans[0]]);
writeln;
end;
begin
{assign(input,'bia.in');
reset(input);
assign(output,'bia.out');
rewrite(output);}
while not eof do
  begin
  readln(n,m);
  if (n=0)and(m=0) then break;
  init;
  for i:=1 to m do begin readln(x,y); addedge(x,y); end;
  solve;
  end;
{close(input);
close(output);}
end.