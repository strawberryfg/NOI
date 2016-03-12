const dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
      maxn=120;
type rec=record x,y,z:longint; end;
var n,m,i,j,x,y,k,ll,rr,p,q,ans,ans2,res,t:longint;
    f,g,win:array[0..maxn*maxn]of rec;
    belong,hash:array[0..maxn,0..maxn]of longint;
    a:array[0..maxn,0..maxn]of char;
    final,final2,tfinal:array[0..maxn*maxn]of longint;
    edge,edge2:array[0..maxn*maxn,0..5]of longint;
    vis,vis2:array[0..maxn*maxn]of boolean;
function dfs(x,avoid:longint):boolean;
var i:longint;
begin
for i:=1 to edge[x][0] do
    begin
    if (edge[x][i]<>avoid)and(not vis[edge[x][i]]) then
       begin
       vis[edge[x][i]]:=true;
       if (final[edge[x][i]]=0)or(dfs(final[edge[x][i]],avoid)) then
          begin
          final[edge[x][i]]:=x;
          exit(true);
          end;
       end;
    end;
exit(false);
end;
procedure hungary(opt,avoid:longint);
var i:longint;
begin
ans:=0;
if opt=-1 then
begin
for i:=1 to ll do
    begin
    fillchar(vis,sizeof(vis),false);
    if dfs(i,avoid) then inc(ans);
    end;
end
else
begin
fillchar(vis,sizeof(vis),false);
if dfs(opt,avoid) then inc(ans);
end;
end;
function dfs2(x,avoid:longint):boolean;
var i:longint;
begin
for i:=1 to edge2[x][0] do
    begin
    if (edge2[x][i]<>-1)and(not vis2[edge2[x][i]]) then
       begin
       vis2[edge2[x][i]]:=true;
       if (final2[edge2[x][i]]=0)or(dfs2(final2[edge2[x][i]],avoid)) then
          begin
          final2[edge2[x][i]]:=x;
          exit(true);
          end;
       end;
    end;
exit(false);
end;
procedure hungary2(opt,avoid:longint);
var i:longint;
begin
ans2:=0;
fillchar(vis2,sizeof(vis2),false);
if dfs2(opt,avoid) then inc(ans2);
end;
begin
assign(input,'game.in');
reset(input);
assign(output,'game.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        hash[i][j]:=1;
        read(a[i][j]);
        if a[i][j]='#' then hash[i][j]:=0;
        end;
    readln;
    end;
for i:=1 to n do
    for j:=1 to m do
        begin
        if a[i][j]='#' then continue;
        if (i+j) mod 2=0 then
           begin
           inc(ll); f[ll].x:=i; f[ll].y:=j;
           belong[i][j]:=ll;
           end
        else
           begin
           inc(rr); g[rr].x:=i; g[rr].y:=j;
           belong[i][j]:=rr;
           end;
        end;
for i:=1 to n do
    for j:=1 to m do
        begin
        if (a[i][j]='.')and((i+j) mod 2=0) then
           begin
           for k:=1 to 4 do
               begin
               x:=i+dx[k]; y:=j+dy[k];
               if (x>=1)and(x<=n)and(y>=1)and(y<=m)and(a[x][y]='.') then
                  begin
                  p:=belong[i][j]; q:=belong[x][y];
                  inc(edge[p][0]);
                  edge[p][edge[p][0]]:=q;
                  inc(edge2[q][0]);
                  edge2[q][edge2[q][0]]:=p; //the opposite graph;
                  end;
               end;
           end;
        end;
hungary(-1,-1);
for i:=1 to ll do
    begin
    fillchar(final2,sizeof(final2),0);
    for j:=1 to rr do final2[final[j]]:=j;
    if final2[i]=0 then continue;
    hungary2(final2[i],i);
    if ans2=0 then
       hash[f[i].x][f[i].y]:=0;
    end;
tfinal:=final;
for i:=1 to rr do
    begin
    if final[i]=0 then continue;
    hungary(final[i],i);
    final:=tfinal;
    if ans=0 then
       hash[g[i].x][g[i].y]:=0;
    end;
for i:=1 to n do
    for j:=1 to m do
        if hash[i][j]=1 then
           begin
           inc(res); win[res].x:=i; win[res].y:=j;
           end;
if res=0 then writeln('LOSE')
   else begin
        writeln('WIN');
        for i:=1 to res do writeln(win[i].x,' ',win[i].y);
        end;
close(input);
close(output);
end.
