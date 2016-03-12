//22:02;
const maxn=16; maxequal=maxn*maxn*3; eps=1e-14;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type mattype=array[0..maxequal]of extended;
     spetype=record xx,yy:longint; end;
var n,m,i,j,k,equal,sx,sy,num,p,pd,flag:longint;
    g:array[0..maxn,0..maxn]of char;
    a,vis:array[0..maxn,0..maxn]of longint;
    id:array[0..maxn,0..maxn,0..3]of longint;
    hash,res:array[0..maxequal]of longint;
    mat:array[0..maxequal]of mattype;
    ans:array[0..maxequal]of extended;
    spe:array[0..27]of spetype;
    swap:mattype;
    sum,rate:extended;
function solve(var x,y,l:longint):longint;
var savex,savey:longint;
begin
if g[x][y]='#' then exit(-1);
if g[x][y]='!' then dec(l);
if l<=0 then exit(-1);
if (ord(g[x][y])>=ord('a'))and(ord(g[x][y])<=ord('z')) then
   begin
   savex:=x; savey:=y;
   x:=spe[ord(g[savex][savey])-ord('a')+1].xx;
   y:=spe[ord(g[savex][savey])-ord('a')+1].yy;
   end;
solve:=l;
end;
function check(x,y,l:longint):boolean;
var tx,ty,i,t,tmp:longint;
begin
if vis[x][y]=1 then exit(false);
vis[x][y]:=1;
if (a[x][y]>=1)and(a[x][y]<=9) then exit(true);
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(vis[tx][ty]=0) then
       begin
       tmp:=l;
       t:=solve(tx,ty,tmp);
       if t=-1 then continue;
       if check(tx,ty,tmp) then exit(true);
       end;
    end;
exit(false);
end;
procedure dfs(x,y,l:longint);
var cnt,i,tx,ty,tmp,t:longint;
begin
id[x][y][l]:=-1;
fillchar(vis,sizeof(vis),0);                     //not meaningful;
if not check(x,y,l) then exit;
inc(equal);
id[x][y][l]:=equal;
cnt:=0;
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>'#') then inc(cnt);
    end;
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>'#') then
       begin
       tmp:=l;
       t:=solve(tx,ty,tmp);
       if t=-1 then continue;
       if id[tx][ty][tmp]=0 then dfs(tx,ty,tmp); //not visited;
       if id[tx][ty][tmp]<>-1 then mat[id[x][y][l]][id[tx][ty][tmp]]:=mat[id[x][y][l]][id[tx][ty][tmp]]-1/cnt;
       end;
    end;
end;
begin
{assign(input,'mario.in');
reset(input);
assign(output,'mario.out');
rewrite(output);}
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(g[i][j]);
        if g[i][j]='$' then begin sx:=i; sy:=j; end;
        if (ord(g[i][j])>=ord('0'))and(ord(g[i][j])<=ord('9')) then a[i][j]:=ord(g[i][j])-ord('0');
        if (ord(g[i][j])>=ord('A'))and(ord(g[i][j])<=ord('Z')) then begin spe[ord(g[i][j])-ord('A')+1].xx:=i; spe[ord(g[i][j])-ord('A')+1].yy:=j; end;
        end;
    readln;
    end;
i:=ord(g[1][15])-ord('a')+1;
equal:=0;
fillchar(mat,sizeof(mat),0);
dfs(sx,sy,3);
for i:=1 to n do
    for j:=1 to m do
        for k:=1 to 3 do
            if (id[i][j][k]<>0)and(id[i][j][k]<>-1) then
               begin
               mat[id[i][j][k]][id[i][j][k]]:=mat[id[i][j][k]][id[i][j][k]]+1;
               mat[id[i][j][k]][equal+1]:=mat[id[i][j][k]][equal+1]+a[i][j];
               end;
i:=1; j:=1;
fillchar(hash,sizeof(hash),0);
while (i<=equal)and(j<=equal) do
  begin
  num:=i;
  for k:=i+1 to equal do if abs(mat[k][j])-abs(mat[num][j])>eps then num:=k;
  res[i]:=-1;
  if abs(mat[num][j])>eps then
     begin
     if num<>i then begin swap:=mat[i]; mat[i]:=mat[num]; mat[num]:=swap; end;
     res[i]:=j;
     hash[j]:=1;
     for k:=i+1 to equal do
         begin
         rate:=mat[k][j]/mat[i][j];
         for p:=j to equal+1 do mat[k][p]:=mat[k][p]-mat[i][p]*rate;
         end;
     inc(i);
     end;
  inc(j);
  end;
flag:=0;
for i:=1 to equal do
    begin
    pd:=1;
    for j:=1 to equal do if abs(mat[i][j])>eps then begin pd:=0; break; end;
    if pd=0 then continue;
    if abs(mat[i][equal+1])>eps then begin flag:=1; break; end;
    end;
for i:=1 to equal do if hash[i]=0 then begin flag:=1; break; end;
if flag=1 then writeln(-1)
   else begin
        for i:=equal downto 1 do
            begin
            if res[i]=-1 then continue;
            sum:=0.0;
            for j:=res[i]+1 to equal do sum:=sum+mat[i][j]*ans[j];
            sum:=mat[i][equal+1]-sum;
            ans[res[i]]:=sum/mat[i][res[i]];
            end;
        if equal=0 then writeln(0.0:0:12)
           else writeln(ans[id[sx][sy][3]]:0:12);
        end;
{close(input);
close(output);}
end.