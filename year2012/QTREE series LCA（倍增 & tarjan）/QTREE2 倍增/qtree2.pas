const maxn=20020;
type rec=record u,v,c,nxt:longint; end;
     arr=array[1..5]of longint;
var test,u,n,tot,ans,anc,tmp,i,x,y,z,s:longint;
    ch,ch1,ch2:char;
    dep,dis,edge,cnt,vis:array[0..maxn]of longint;
    f:array[0..maxn,0..16]of longint;
    g:array[0..maxn]of rec;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=z; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
procedure init;
var i:longint;
begin
tot:=0;
fillchar(f,sizeof(f),0);
fillchar(dep,sizeof(dep),0);
fillchar(dis,sizeof(dis),0);
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(cnt,sizeof(cnt),0);
fillchar(vis,sizeof(vis),0);
end;
procedure dfs(x,d,now,from:longint);
var p,t1,i:longint;
begin
vis[x]:=1;
p:=edge[x];
dep[x]:=d;
dis[x]:=now;
f[x][0]:=from;
for i:=1 to 15 do
    begin
    f[x][i]:=f[f[x][i-1]][i-1];
    end;
while p<>0 do
  begin
  if (vis[g[p].v]=0) then
     begin
     dfs(g[p].v,d+1,now+g[p].c,x);
     end;
  p:=g[p].nxt;
  end;
end;
function work(x,cnt:longint):longint;
var now:longint;
begin
now:=0;
while cnt>0 do
  begin
  if cnt mod 2=1 then x:=f[x][now];
  inc(now);
  cnt:=cnt div 2;
  end;
exit(x);
end;
function lca(x,y:longint):longint;
var i:longint;
begin
if dep[x]<dep[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
x:=work(x,dep[x]-dep[y]);
if x=y then exit(x);
for i:=15 downto 0 do
    begin
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
    end;
exit(f[x][0]);
end;
begin
{assign(input,'qtree2.in');
reset(input);
assign(output,'e:\work\qtree2.out');
rewrite(output);}
readln(test);
for u:=1 to test do
    begin
    readln(n);
    init;
    for i:=1 to n-1 do
        begin
        readln(x,y,z);
        inc(cnt[y]);
        addedge(x,y,z);
        end;
    for i:=1 to n do if cnt[i]=0 then s:=i;
    dfs(s,0,0,0);
    read(ch1); read(ch2);
    while (ch1<>'D')or(ch2<>'O') do
      begin
      if ch1='D' then
         begin
         for i:=1 to 3 do read(ch);
         read(x,y);
         ans:=dis[x]+dis[y]-2*dis[lca(x,y)];
         writeln(ans);
         end
      else
         begin
         for i:=1 to 2 do read(ch);
         read(x,y,z);
         anc:=lca(x,y);
         if z<=dep[x]-dep[anc]+1 then
            begin
            ans:=work(x,z-1);
            writeln(ans);
            end
         else
            begin
            tmp:=dep[x]+dep[y]-2*dep[anc]+1-z;
            ans:=work(y,tmp);
            writeln(ans);
            end;
         end;
      readln;
      read(ch1); read(ch2);
      end;
    read(ch); read(ch);
    readln;
    writeln;
    end;
{close(input);
close(output);}
end.