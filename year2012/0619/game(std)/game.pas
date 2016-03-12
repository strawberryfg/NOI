const spe:array[1..2]of char=('O','X');
      maxn=41; maxopt=20020;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type arr=array[0..maxn,0..maxn]of char;
     vertype=record u,v:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,j,x,y,sx,sy,cntx,cnty,nx,ny,tx,ty,cnt,tot,ans,fans,pd1,pd2:longint;
    a:arr;
    h:array[0..maxopt]of longint;
    map,bel:array[0..maxn,0..maxn]of longint;
    verx,very:array[0..maxn*maxn]of vertype;
    edge,vis,res:array[0..maxn*maxn]of longint;
    g:array[0..maxn*maxn*16]of rec;
    hash:array[1..2,0..maxn*maxn]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dfs(x,y,sta:longint);
var i,tx,ty:longint;
begin
if ((x<>sx)or(y<>sy))and(a[x][y]<>spe[sta]) then exit;
if sta=1 then begin inc(cntx); verx[cntx].u:=x; verx[cntx].v:=y; bel[x][y]:=cntx; end
   else begin inc(cnty); very[cnty].u:=x; very[cnty].v:=y; bel[x][y]:=cnty; end;
map[x][y]:=sta;
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(map[tx][ty]=0) then dfs(tx,ty,3-sta);
    end;
end;
function dfs2(x,opt,num:longint):boolean;
var p,pd:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  pd:=1;
  if ((opt=2)and(g[p].v=num))or(hash[2][g[p].v]=0) then pd:=0;
  if (vis[g[p].v]=0)and(pd=1) then
     begin
     vis[g[p].v]:=1;
     if (res[g[p].v]=0)or(dfs2(res[g[p].v],opt,num)) then
        begin
        res[g[p].v]:=x;
        exit(true);
        end;
     end;
  p:=g[p].nxt;
  end;
exit(false);
end;
procedure hungary(opt,num:longint);
var i:longint;
begin
fillchar(res,sizeof(res),0);
ans:=0;
for i:=1 to cntx do
    begin
    if (opt=1)and(i=num) then continue;
    if hash[1][i]=0 then continue;
    fillchar(vis,sizeof(vis),0);
    if dfs2(i,opt,num) then inc(ans);
    end;
end;
function check(fans,ans:longint):boolean;
begin
if fans<>ans then exit(true) else exit(false);
end;
begin
assign(input,'game.in');
reset(input);
assign(output,'game.out');
rewrite(output);
readln(n,m);
for i:=1 to n do begin for j:=1 to m do begin read(a[i][j]); if a[i][j]='.' then begin sx:=i; sy:=j; end; end; readln; end;
cntx:=0; cnty:=0;
dfs(sx,sy,2);
for i:=1 to cntx do
    begin
    for j:=1 to 4 do
        begin
        tx:=verx[i].u+dx[j]; ty:=verx[i].v+dy[j];
        if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(bel[tx][ty]<>0) then addedge(i,bel[tx][ty]);
        end;
    end;
readln(cnt);
pd1:=0;
for i:=1 to cntx do hash[1][i]:=1;
for i:=1 to cnty do hash[2][i]:=1;
hungary(0,0);
fans:=ans;
hungary(map[sx][sy],bel[sx][sy]);
if check(fans,ans) then pd1:=1;
h[0]:=0; nx:=sx; ny:=sy;
for i:=1 to cnt do
    begin
    readln(x,y);
    hash[map[nx][ny]][bel[nx][ny]]:=0;
    pd2:=0;
    hungary(0,0);
    fans:=ans;
    hungary(map[x][y],bel[x][y]);
    if check(fans,ans) then pd2:=1;
    if (pd1<>0)and(pd2<>0) then begin inc(h[0]); h[h[0]]:=i; end;
    nx:=x; ny:=y;  //important;
    readln(x,y);
    hash[map[nx][ny]][bel[nx][ny]]:=0;
    pd1:=0;
    hungary(0,0);
    fans:=ans;
    hungary(map[x][y],bel[x][y]);
    if check(fans,ans) then pd1:=1;
    nx:=x; ny:=y;  //important;
    end;
writeln(h[0]);
for i:=1 to h[0] do writeln(h[i]);
close(input);
close(output);
end.