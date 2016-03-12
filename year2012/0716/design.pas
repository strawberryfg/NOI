const maxn=111111; maxm=311111; maxx=12;
type rec=record v,nxt:longint; end;
var n,m,i,x,y,tot,base,d,xx,yy:longint;
    edge,q,hash:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    f:array[0..maxn,0..maxx,0..2]of longint;
    vis:array[0..maxn,0..maxx]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dp(x,j,fa:longint);
var p,son,numa,numb,res0,res1,res2:longint;
begin
if vis[x][j]=1 then exit;
vis[x][j]:=1;
p:=edge[x];
son:=0;
while p<>0 do
  begin
  if g[p].v=fa then begin p:=g[p].nxt; continue; end;
  inc(son);
  dp(g[p].v,j,x);
  if j-1>=0 then dp(g[p].v,j-1,x);
  p:=g[p].nxt;
  end;
if son=0 then begin f[x][j][0]:=1; f[x][j][1]:=0; f[x][j][2]:=0; exit; end;
if j=0 then
   begin
   f[x][j][0]:=0;
   if son>1 then f[x][j][1]:=0
      else begin
           p:=edge[x];
           if g[p].v=fa then p:=g[p].nxt;
           f[x][j][1]:=(f[g[p].v][j][0]+f[g[p].v][j][1]) mod base;
           end;
   if (son>2)or(son=1) then f[x][j][2]:=0
      else begin
           p:=edge[x]; numa:=0; numb:=0;
           while p<>0 do
             begin
             if g[p].v=fa then begin p:=g[p].nxt; continue; end;
             if numa=0 then numa:=g[p].v else if numb=0 then numb:=g[p].v;
             p:=g[p].nxt;
             end;
           f[x][j][2]:=(f[numa][j][0]+f[numa][j][1]) mod base;
           f[x][j][2]:=qword(f[x][j][2])*(f[numb][j][0]+f[numb][j][1]) mod base;
           end;
   exit;
   end;
p:=edge[x]; f[x][j][0]:=1; f[x][j][1]:=0; f[x][j][2]:=0;
while p<>0 do
  begin
  if g[p].v=fa then begin p:=g[p].nxt; continue; end;
  numa:=(f[g[p].v][j-1][0]+f[g[p].v][j-1][1]+f[g[p].v][j-1][2]) mod base;
  numb:=(f[g[p].v][j][0]+f[g[p].v][j][1]) mod base;
  res0:=qword(f[x][j][0])*numa mod base;
  res1:=(qword(f[x][j][0])*numb mod base+qword(f[x][j][1])*numa mod base) mod base;
  res2:=(qword(f[x][j][1])*numb mod base+qword(f[x][j][2])*numa mod base) mod base;
  f[x][j][0]:=res0; f[x][j][1]:=res1; f[x][j][2]:=res2;
  p:=g[p].nxt;
  end;
end;
procedure work;
var i,res:longint;
begin
for i:=0 to maxx do
    begin
    fillchar(f,sizeof(f),0);
    fillchar(vis,sizeof(vis),0);
    dp(1,i,0);
    res:=(f[1][i][0]+f[1][i][1]+f[1][i][2]) mod base;
    if res<>0 then
       begin
       writeln(i); writeln(res);
       break;
       end;
    end;
end;
begin
assign(input,'design.in');
reset(input);
assign(output,'design.out');
rewrite(output);
read(n,m);
read(base);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y); addedge(y,x);
    end;
if m<>n-1 then begin writeln(-1); writeln(-1); end
   else work;
close(input);
close(output);
end.