//14:01;
const maxn=41; max=10; maxopt=20020;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type arr=array[0..maxn,0..maxn]of char;
var n,m,i,j,sx,sy,pd1,pd2,x,y,cnt,tx,ty:longint;
    g:arr;
    ans:array[0..maxopt]of longint;
function work(x,y,opt:byte; map:arr):byte;
var i,tx,ty:byte; swap:char; sg:array[0..max]of byte;
begin
fillchar(sg,sizeof(sg),0);
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(((opt=1)and(map[tx][ty]='O'))or((opt=2)and(map[tx][ty]='X'))) then
       begin
       swap:=map[x][y]; map[x][y]:=map[tx][ty]; map[tx][ty]:=swap;
       sg[work(tx,ty,3-opt,map)]:=1;
       swap:=map[x][y]; map[x][y]:=map[tx][ty]; map[tx][ty]:=swap;
       end;
    end;
for i:=0 to max do if sg[i]=0 then exit(i);
end;
begin
assign(input,'game.in');
reset(input);
assign(output,'game.out');
rewrite(output);
readln(n,m);
for i:=1 to n do begin for j:=1 to m do begin read(g[i][j]); if g[i][j]='.' then begin sx:=i; sy:=j; end; end; readln; end;
pd1:=work(sx,sy,1,g);   //rabbit egg
readln(cnt);
ans[0]:=0;
for i:=1 to cnt do
    begin
    readln(x,y);
    for j:=1 to 4 do
        begin
        tx:=x+dx[j]; ty:=y+dy[j];
        if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]='.') then break;
        end;
    g[tx][ty]:=g[x][y]; g[x][y]:='.';
    pd2:=work(x,y,2,g);
    if (pd1<>0)and(pd2<>0) then begin inc(ans[0]); ans[ans[0]]:=i; end;
    readln(x,y);
    for j:=1 to 4 do
        begin
        tx:=x+dx[j]; ty:=y+dy[j];
        if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]='.') then break;
        end;
    g[tx][ty]:=g[x][y]; g[x][y]:='.';
    pd1:=work(x,y,1,g);
    end;
writeln(ans[0]);
for i:=1 to ans[0] do writeln(ans[i]);
close(input);
close(output);
end.
