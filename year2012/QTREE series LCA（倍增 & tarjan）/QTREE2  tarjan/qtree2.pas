const maxn=20020; maxquery=2000020;
type rec=record u,v,c,nxt:longint; end;
     arr=array[1..5]of longint;
var test,u,n,opt,tot,tot2,ans,tmp,i,x,y,z,s,ff:longint;
    ch,ch1,ch2:char;
    dep,dis,edge,edge2,cnt,vis,checked,fa:array[0..maxn]of longint;
    f:array[0..maxn,0..16]of longint;
    que:array[0..maxquery]of arr;
    g:array[0..maxn]of rec;
    tg:array[0..maxquery]of rec;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=z; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
procedure addedge2(x,y,z:longint);
begin
inc(tot2); tg[tot2].u:=x; tg[tot2].v:=y; tg[tot2].c:=z; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
inc(tot2); tg[tot2].u:=y; tg[tot2].v:=x; tg[tot2].c:=z; tg[tot2].nxt:=edge2[y]; edge2[y]:=tot2;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure init;
var i:longint;
begin
tot:=0; tot2:=0; opt:=0;
fillchar(f,sizeof(f),0);
fillchar(dep,sizeof(dep),0);
fillchar(dis,sizeof(dis),0);
fillchar(edge,sizeof(edge),0);
fillchar(edge2,sizeof(edge2),0);
//fillchar(g,sizeof(g),0);
//fillchar(tg,sizeof(tg),0);
fillchar(cnt,sizeof(cnt),0);
fillchar(vis,sizeof(vis),0);
fillchar(checked,sizeof(checked),0);
//fillchar(que,sizeof(que),0);
for i:=1 to n do fa[i]:=i;
end;
procedure tarjan(x,d,now,from:longint);
var p,t1,i:longint;
begin
vis[x]:=1;
p:=edge[x];
fa[x]:=x;
dep[x]:=d;
dis[x]:=now;
f[x][0]:=from;
for i:=1 to 16 do
    begin
    f[x][i]:=f[f[x][i-1]][i-1];
    end;
while p<>0 do
  begin
  if (vis[g[p].v]=0) then
     begin
     tarjan(g[p].v,d+1,now+g[p].c,x);
     t1:=getfa(g[p].v);
     fa[t1]:=x;
     end;
  p:=g[p].nxt;
  end;
checked[x]:=1;
p:=edge2[x];
while p<>0 do
  begin
  if (checked[tg[p].v]=1) then
     begin
     que[tg[p].c][5]:=getfa(tg[p].v);
     end;
  p:=tg[p].nxt;
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
begin
{assign(input,'qtree2.in');
reset(input);
assign(output,'qtree2.out');
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
    read(ch1); read(ch2);
    while (ch1<>'D')or(ch2<>'O') do
      begin
      if ch1='D' then
         begin
         for i:=1 to 3 do read(ch);
         read(x,y);
         inc(opt);
         que[opt][1]:=1; que[opt][2]:=x; que[opt][3]:=y; que[opt][4]:=0;
         addedge2(x,y,opt);
         end
      else
         begin
         for i:=1 to 2 do read(ch);
         read(x,y,z);
         inc(opt);
         que[opt][1]:=2; que[opt][2]:=x; que[opt][3]:=y; que[opt][4]:=z;
         addedge2(x,y,opt);
         end;
      readln;
      read(ch1); read(ch2);
      end;
    read(ch); read(ch);
    readln;
    for i:=1 to n do if cnt[i]=0 then s:=i;
    tarjan(s,0,0,0);
    for i:=1 to opt do
        begin
        if que[i][1]=1 then
           begin
           ans:=dis[que[i][2]]+dis[que[i][3]]-2*dis[que[i][5]];
           writeln(ans);
           end
        else
           begin
           if que[i][4]<=dep[que[i][2]]-dep[que[i][5]]+1 then
              begin
              ans:=work(que[i][2],que[i][4]-1);
              writeln(ans);
              end
           else
              begin
              tmp:=dep[que[i][2]]+dep[que[i][3]]-2*dep[que[i][5]]+1-que[i][4];
              ans:=work(que[i][3],tmp);
              writeln(ans);
              end;
           end;
        end;
    writeln;
    end;
{close(input);
close(output);}
end.