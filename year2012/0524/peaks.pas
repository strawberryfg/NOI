//17:43;
const maxn=420; maxm=2020; maxq=10000020; max=11111111;
      dx:array[1..8]of longint=(-1,-1,-1,0,0,1,1,1);
      dy:array[1..8]of longint=(-1,0,1,-1,1,-1,0,1);
type rec=record xx,yy:longint; end;
     gtype=record ll,rr:longint; end;
     gridtype=record xx,yy,v:longint; end;
     boundtype=record u,v,nxt:longint; end;
var n,m,i,j,k,tot,cnt,tx,ty,total,t1,t2,p,tot2:longint;
    f:array[0..100]of rec;
    a,bel,id,flag:array[0..maxn,0..maxm]of longint;
    w,peak,hash,ans,ret,fa,res:array[0..maxn*maxm]of longint;
    spe:array[0..maxn*maxm]of rec;
    h:array[0..maxn*maxm]of rec;
    g:array[0..maxn*maxm]of gtype;
    q:array[0..maxq]of rec;
    grid:array[0..maxn*maxm]of gridtype;
    edge:array[0..maxn*maxm]of longint;
    bound:array[0..max]of boundtype;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
procedure addedge(x,y:longint);
var p:longint;
begin
inc(tot2); bound[tot2].v:=y; bound[tot2].nxt:=edge[x]; edge[x]:=tot2;
if edge[y]<>0 then
   begin
   p:=edge[x];
   while bound[p].nxt<>0 do p:=bound[p].nxt;
   bound[p].nxt:=edge[y];
   edge[y]:=0;
   end;
end;
procedure bfs(x,y:longint);
var head,tail,i,tx,ty,hou,qian:longint;
begin
hou:=1; qian:=1;
head:=1; tail:=1; q[1].xx:=x; q[1].yy:=y;
while (hou<qian)or((hou=qian)and(head<=tail)) do
  begin
  for i:=1 to 8 do
      begin
      tx:=q[head].xx+dx[i]; ty:=q[head].yy+dy[i];
      if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(a[tx][ty]=a[x][y])and(bel[tx][ty]=0) then
         begin
         bel[tx][ty]:=cnt;
         inc(tot); h[tot].xx:=tx; h[tot].yy:=ty;
         inc(g[cnt].rr);
         inc(tail);
         if tail>maxq then begin inc(qian); tail:=1; end;
         q[tail].xx:=tx; q[tail].yy:=ty;
         end;
      end;
  inc(head);
  if head>maxq then begin inc(hou); head:=1; end;
  end;
end;
procedure sort(l,r:longint);
var i,j,cmp:longint; swap:gridtype;
begin
i:=l; j:=r; cmp:=grid[(l+r) div 2].v;
repeat
while grid[i].v>cmp do inc(i);
while cmp>grid[j].v do dec(j);
if not(i>j) then begin swap:=grid[i]; grid[i]:=grid[j]; grid[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r:longint);
var i,j,cmpans,cmpres,tmp:longint;
begin
i:=l; j:=r; cmpans:=ans[(l+r) div 2]; cmpres:=res[(l+r) div 2];
repeat
while (ans[i]>cmpans)or((ans[i]=cmpans)and(res[i]>cmpres)) do inc(i);
while (cmpans>ans[j])or((cmpans=ans[j])and(cmpres>res[j])) do dec(j);
if not(i>j) then begin tmp:=res[i]; res[i]:=res[j]; res[j]:=tmp; tmp:=ans[i]; ans[i]:=ans[j]; ans[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
begin
assign(input,'peaks.in');
reset(input);
assign(output,'peaks.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    for j:=1 to m do
        begin
        if n>m then read(a[j][i])
           else read(a[i][j]);
        end;
if n>m then begin n:=n+m; m:=n-m; n:=n-m; end;
cnt:=0; tot:=0;
for i:=1 to n do
    for j:=1 to m do
        begin
        if bel[i][j]=0 then
           begin
           inc(cnt); w[cnt]:=a[i][j];
           bel[i][j]:=cnt;
           inc(tot); h[tot].xx:=i; h[tot].yy:=j;
           g[cnt].ll:=tot; g[cnt].rr:=tot;
           bfs(i,j);
           end;
        end;
for i:=1 to cnt do peak[i]:=1;
for i:=1 to cnt do
    begin
    for j:=g[i].ll to g[i].rr do
        begin
        for k:=1 to 8 do
            begin
            tx:=h[j].xx+dx[k]; ty:=h[j].yy+dy[k];
            if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m) then
               if (bel[tx][ty]<>i)and(a[tx][ty]>w[i]) then peak[i]:=0;  // not a peak;
            end;
        end;
    end;
for i:=1 to n do for j:=1 to m do begin id[i][j]:=(i-1)*m+j; spe[(i-1)*m+j].xx:=i; spe[(i-1)*m+j].yy:=j; end;
for i:=1 to n do for j:=1 to m do begin grid[id[i][j]].xx:=i; grid[id[i][j]].yy:=j; grid[id[i][j]].v:=a[i][j]; end;
for i:=1 to n*m do fa[i]:=i;
sort(1,n*m);
for i:=1 to n*m do
    begin
    total:=0;
    for j:=1 to 8 do
        begin
        tx:=grid[i].xx+dx[j]; ty:=grid[i].yy+dy[j];
        if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m) then
           begin
           if (a[tx][ty]>=a[grid[i].xx][grid[i].yy])and(flag[tx][ty]=1) then
              begin
              inc(total); f[total].xx:=tx; f[total].yy:=ty;
              if flag[grid[i].xx][grid[i].yy]=0 then
                 begin
                 t1:=getfa(id[tx][ty]); t2:=getfa(id[grid[i].xx][grid[i].yy]);
                 if t1<>t2 then
                    begin
                    fa[t2]:=t1;
                    flag[grid[i].xx][grid[i].yy]:=1;
                    end
                 end;
              end;
           end;
        end;
    if flag[grid[i].xx][grid[i].yy]=0 then flag[grid[i].xx][grid[i].yy]:=1;
    for j:=1 to total do
        for k:=1 to total do
            begin
            if j=k then continue;
            t1:=getfa(id[f[j].xx][f[j].yy]); t2:=getfa(id[f[k].xx][f[k].yy]);
            if t1<>t2 then
               begin
               if (a[spe[t1].xx][spe[t1].yy]<a[spe[t2].xx][spe[t2].yy]) then
                  begin
                  if ret[bel[spe[t1].xx][spe[t1].yy]]=0 then
                     begin
                     fa[t1]:=t2;
                     ret[bel[spe[t1].xx][spe[t1].yy]]:=grid[i].v;
                     end;
                  end
               else
                  if (a[spe[t2].xx][spe[t2].yy]<a[spe[t1].xx][spe[t1].yy]) then
                     begin
                     if ret[bel[spe[t2].xx][spe[t2].yy]]=0 then
                        begin
                        fa[t2]:=t1;
                        ret[bel[spe[t2].xx][spe[t2].yy]]:=grid[i].v;
                        end;
                     end
                  else
                     begin
                     fa[t1]:=t2;
                     addedge(bel[spe[t2].xx][spe[t2].yy],bel[spe[t1].xx][spe[t1].yy]);
                     end;
               end
            end;
    end;
for i:=1 to cnt do
    begin
    p:=edge[i];
    if ret[i]=0 then
       p:=p;
    while p<>0 do
      begin
      ret[bound[p].v]:=ret[i];
      p:=bound[p].nxt;
      end;
    end;
j:=0;
for i:=1 to n*m do
    begin
    if (peak[bel[grid[i].xx][grid[i].yy]]=1)and(hash[bel[grid[i].xx][grid[i].yy]]=0) then
       begin
       hash[bel[grid[i].xx][grid[i].yy]]:=1;
       inc(j);
       ans[j]:=grid[i].v;
       res[j]:=ret[bel[grid[i].xx][grid[i].yy]];
       end;
    end;
sort2(1,j);
writeln(j);
for i:=1 to j do writeln(ans[i],' ',res[i]);
close(input);
close(output);
end.