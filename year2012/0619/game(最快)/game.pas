const spe:array[1..2]of char=('O','X');
      maxn=41; maxopt=20020;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type arr=array[0..maxn,0..maxn]of char;
     vertype=record u,v:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,j,x,y,sx,sy,cntx,cnty,nx,ny,tx,ty,cnt,tot,fans,pd1,pd2:longint;
    a:arr;
    ans:array[0..maxopt]of longint;
    map,bel:array[0..maxn*2,0..maxn*2]of longint;
    verx,very:array[0..maxn*maxn*2]of vertype;
    edge,vis,res:array[0..maxn*maxn]of longint;
    g:array[0..maxn*maxn*32]of rec;
    hash:array[0..maxn*maxn*2]of longint;
    now:longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dfs(x,y,sta:longint);
var i,tx,ty,pd:longint;
begin
pd:=1;
if ((x<>sx)or(y<>sy))and(a[x][y]<>spe[sta]) then pd:=0;
if pd=1 then
   begin
   if sta=1 then begin inc(cntx); verx[cntx].u:=x; verx[cntx].v:=y; bel[x][y]:=cntx; end
      else begin inc(cnty); very[cnty].u:=x; very[cnty].v:=y; bel[x][y]:=cnty; end;
   map[x][y]:=sta;
   for i:=1 to 4 do
       begin
       tx:=x+dx[i]; ty:=y+dy[i];
       if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(map[tx][ty]=0) then dfs(tx,ty,3-sta);
       end;
   end;
end;
function dfs2(x,fa:longint):boolean;
var p:longint;
begin
p:=edge[x]; dfs2:=false;
while p<>0 do
  begin
  if (g[p].v<>fa)and(vis[g[p].v]<>now)and(hash[g[p].v]=1) then
     begin
     vis[g[p].v]:=now;
     if (res[g[p].v]=0)or(dfs2(res[g[p].v],g[p].v)) then
        begin
        res[g[p].v]:=x; res[x]:=g[p].v;
        dfs2:=true; break;
        end;
     end;
  p:=g[p].nxt;
  end;
end;
function work(num:longint):longint;
var tmp:longint;
begin
hash[num]:=0;
if res[num]=0 then work:=0
   else begin
        tmp:=res[num]; res[num]:=0; res[tmp]:=0;
        if dfs2(tmp,0) then work:=0 else work:=1;
        end;
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
for i:=1 to cnty do bel[very[i].u][very[i].v]:=cntx+i;
for i:=1 to cntx do
    begin
    for j:=1 to 4 do
        begin
        tx:=verx[i].u+dx[j]; ty:=verx[i].v+dy[j];
        if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(bel[tx][ty]<>0) then begin addedge(i,bel[tx][ty]); addedge(bel[tx][ty],i); end;
        end;
    end;
readln(cnt);
for i:=1 to cntx+cnty do hash[i]:=1;
ans[0]:=0; nx:=sx; ny:=sy;
fillchar(res,sizeof(res),0);
fans:=0;
now:=0;
for i:=1 to cntx do
    begin
    inc(now);
    if dfs2(i,0) then inc(fans);
    end;
for i:=1 to cnt do
    begin
    inc(now);
    pd1:=work(bel[nx][ny]);
    readln(x,y);
    inc(now);
    pd2:=work(bel[x][y]);
    if (pd1=1)and(pd2=1) then begin inc(ans[0]); ans[ans[0]]:=i; end;
    readln(nx,ny);
    end;
writeln(ans[0]);
for i:=1 to ans[0] do writeln(ans[i]);
close(input);
close(output);
end.