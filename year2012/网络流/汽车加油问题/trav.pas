const maxn=120; maxk=120; maxq=1000020; inf=maxlongint;
      dx:array[1..4]of longint=(0,1,0,-1);
      dy:array[1..4]of longint=(1,0,-1,0);
type rec=record u,v,nxt,w:longint; end;
     queuetype=record x,y,z,v:longint; end;
var n,k,a,b,c,i,j,l,u,x,y,z,t,p,tot,head,tail,ans:longint;
    w:array[0..maxn,0..maxn]of longint;
    bel:array[0..maxn,0..maxn,0..maxk]of longint;
    opp:array[0..maxn*maxn*maxk,1..3]of longint;
    q:array[0..maxq]of queuetype;
    g:array[0..maxn*12*maxn*maxk]of rec;
    edge:array[0..maxn*12*maxn*maxk]of longint;
    f:array[0..maxn*maxn*maxk]of longint;
    mark:array[0..maxn*maxn*maxk]of boolean;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'trav.in');
reset(input);
assign(output,'trav.out');
rewrite(output);
readln(n,k,a,b,c);
for i:=1 to n do
    begin
    for j:=1 to n do
        read(w[i][j]);
    readln;
    end;
for i:=1 to n do
    for j:=1 to n do
        for l:=0 to k do
            begin
            if (i=n)and(j=n) then
                t:=t;
            bel[i][j][l]:=((i-1)*n+j-1)*(k+1)+l;
            opp[((i-1)*n+j-1)*(k+1)+l][1]:=i;
            opp[((i-1)*n+j-1)*(k+1)+l][2]:=j;
            opp[((i-1)*n+j-1)*(k+1)+l][3]:=l;
            f[((i-1)*n+j-1)*(k+1)+l]:=inf;
            end;
for i:=1 to n do
    for j:=1 to n do
        for l:=0 to k do
            begin
            if w[i][j]=1 then t:=a else t:=a+c;
            if l<>k then addedge(bel[i][j][l],bel[i][j][k],t);
            if ((w[i][j]=0)and(l>0))or(l=k) then
               begin
               for u:=1 to 4 do
                   begin
                   x:=i+dx[u]; y:=j+dy[u];
                   if u<=2 then t:=0 else t:=b;
                   if (x>=1)and(x<=n)and(y>=1)and(y<=n) then
                      addedge(bel[i][j][l],bel[x][y][l-1],t);
                   end;
               end;
            end;
head:=1; tail:=1; q[1].x:=1; q[1].y:=1; q[1].z:=k; q[1].v:=bel[1][1][k];
f[bel[1][1][k]]:=0;
fillchar(mark,sizeof(mark),false);
mark[bel[1][1][k]]:=true;
while head<=tail do
  begin
  p:=edge[q[head].v];
  if f[bel[n][n][2]]=0 then
     t:=t;
  while p<>0 do
    begin
    t:=g[p].v;
    x:=opp[t][1]; y:=opp[t][2]; z:=opp[t][3];
    if (f[q[head].v]+g[p].w<f[t]) then
       begin
       f[t]:=f[q[head].v]+g[p].w;
       if not mark[t] then
          begin
          inc(tail);
          q[tail].x:=x; q[tail].y:=y; q[tail].z:=z;
          q[tail].v:=t; mark[t]:=true;
          end;
       end;
    p:=g[p].nxt;
    end;
  mark[q[head].v]:=false;
  inc(head);
  end;
ans:=inf;
for i:=0 to k do
    ans:=min(ans,f[bel[n][n][i]]);
writeln(ans);
close(input);
close(output);
end.