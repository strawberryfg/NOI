const maxn=10;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
var n,m,i,j,k,x,y,tmp,min,cnt,tot,v:longint;
    a,hash,belong:array[0..maxn,0..maxn]of longint;
    sum,vis,f,map,sta:array[0..maxn*maxn*2]of longint;
    edge:array[0..maxn*maxn*2,0..maxn*maxn*2]of longint;
procedure dfs(x,y:longint);
var i,tx,ty:longint;
begin
belong[x][y]:=cnt;
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(a[tx][ty]<0)and(hash[tx][ty]=0) then
       begin
       hash[tx][ty]:=1;
       sum[cnt]:=sum[cnt]+a[tx][ty];
       dfs(tx,ty);
       end;
    end;
end;
procedure dfs2(x:longint);
var i:longint;
begin
map[x]:=1;
v:=v+sum[x];
for i:=1 to edge[x][0] do
    begin
    if (sta[edge[x][i]]=1)and(map[edge[x][i]]=0) then
        dfs2(edge[x][i]);
    end;
end;
procedure check;
var i,cc:longint;
begin
fillchar(map,sizeof(map),0);
v:=0;
cc:=0;

for i:=1 to tot do
    begin
    if (sta[f[i]]=1)and(map[f[i]]=0) then
       begin
       inc(cc);
       if cc>1 then exit;
       dfs2(f[i]);
       end;
    end;
if v<min then min:=v;
end;
procedure work(x:longint);
var i:longint;
begin
if x>tot then
   begin
   check;
   exit;
   end;
for i:=0 to 1 do
    begin
    sta[f[x]]:=i;
    work(x+1);
    end;
end;
begin
assign(input,'mincost.in');
reset(input);
assign(output,'mincost.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(a[i][j]);
        belong[i][j]:=(i-1)*m+j;
        sum[(i-1)*m+j]:=a[i][j];
        end;
    readln;
    end;
min:=0;
cnt:=n*m;
for i:=1 to n do
    for j:=1 to m do
        begin
        if (a[i][j]<0)and(hash[i][j]=0) then
           begin
           hash[i][j]:=1;
           inc(cnt); sum[cnt]:=a[i][j];
           dfs(i,j);
           end;
        end;
for i:=1 to n do
    for j:=1 to m do
        begin
        for k:=1 to 4 do
            begin
            x:=i+dx[k]; y:=j+dy[k];
            if (x>=1)and(x<=n)and(y>=1)and(y<=m) then
               begin
               inc(edge[belong[i][j]][0]);
               tmp:=edge[belong[i][j]][0];
               edge[belong[i][j]][tmp]:=belong[x][y];
               end;
            end;
        end;
for i:=1 to n do
    for j:=1 to m do
        begin
        if vis[belong[i][j]]=0 then
           begin
           vis[belong[i][j]]:=1;
           inc(tot);
           f[tot]:=belong[i][j];
           end;
        end;
work(1);
writeln(min);
close(input);
close(output);
end.
