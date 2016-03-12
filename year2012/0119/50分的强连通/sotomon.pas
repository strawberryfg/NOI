//13:38;init; 14:16; finish writing;
const maxn=100200;
      maxcoordinate=1000200;
      maxm=4000000;
      dx:array[1..8]of longint=(-1,-1,-1,0,0,1,1,1);
      dy:array[1..8]of longint=(-1,0,1,-1,1,-1,0,1);
type rec=record x,y,k,ind:longint; end;
     node=record first,last:longint; end;
     edgenode=record u,v,nxt:longint; end;
var tot,tot2,tot3,n,hang,lie,i,j,le,ri,nx,ny,tmp,total,cnt,p,ans,x:longint;
    a,ra,ca:array[0..maxn]of rec;
    stx,sty,enx,eny:array[0..maxcoordinate]of longint;
    vis:array[0..maxn]of boolean;
    topsort,col,inner,sum,f,outer:array[0..maxn]of longint;
    edge,edge2,edge3:array[0..maxn]of node;
    g,tg,h:array[0..maxm]of edgenode;
procedure sort1(l,r: longint);
var i,j,x,y: longint; t:rec;
begin
i:=l; j:=r; x:=ra[(l+r) div 2].x; y:=ra[(l+r)div 2].y;
repeat
 while (ra[i].x<x)or((ra[i].x=x)and(ra[i].y<y)) do inc(i);
 while (x<ra[j].x)or((x=ra[j].x)and(y<ra[j].y)) do dec(j);
 if not(i>j) then begin t:=ra[i]; ra[i]:=ra[j]; ra[j]:=t; inc(i); dec(j); end;
until i>j;
if l<j then sort1(l,j);
if i<r then sort1(i,r);
end;
procedure sort2(l,r: longint);
var i,j,x,y: longint; t:rec;
begin
i:=l; j:=r; y:=ca[(l+r) div 2].y; x:=ca[(l+r)div 2].x;
repeat
 while (ca[i].y<y)or((ca[i].y=y)and(ca[i].x<x)) do inc(i);
 while (y<ca[j].y)or((y=ca[j].y)and(x<ca[j].x)) do dec(j);
 if not(i>j) then begin t:=ca[i]; ca[i]:=ca[j]; ca[j]:=t; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
function find(x,y:longint):longint;
var le,ri,mid,ans:longint;
begin
le:=stx[x]; ri:=enx[x];
ans:=-1;
while (le<=ri) do
  begin
  mid:=(le+ri)div 2;
  if ra[mid].y<y then le:=mid+1
     else if ra[mid].y>y then ri:=mid-1
             else begin
                  ans:=ra[mid].ind;
                  break;
                  end;
  end;
find:=ans;
exit(find);
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;;
edge[x].last:=tot;
end;
procedure addedge2(x,y:longint);
begin
inc(tot2); tg[tot2].u:=x; tg[tot2].v:=y;
if edge2[x].first=0 then edge2[x].first:=tot2
   else tg[edge2[x].last].nxt:=tot2;;
edge2[x].last:=tot2;
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=true;
p:=edge[x].first;
while p<>0 do
  begin
  if not vis[g[p].v] then dfs(g[p].v);
  p:=g[p].nxt;
  end;
inc(total);
topsort[total]:=x;
end;
procedure dfs2(x:longint);
var p:longint;
begin
col[x]:=cnt;
sum[cnt]:=sum[cnt]+1;
p:=edge2[x].first;
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure addedge3(x,y:longint);
var p:longint;
begin
p:=edge3[x].first;
while p<>0 do
  begin
  if h[p].v=y then exit;
  p:=h[p].nxt;
  end;
inc(tot3); h[tot3].u:=x; h[tot3].v:=y;
inc(inner[y]);
inc(outer[x]);
if edge3[x].first=0 then edge3[x].first:=tot3
   else h[edge3[x].last].nxt:=tot3;
edge3[x].last:=tot3;
end;
begin
assign(input,'sotomon.in');
reset(input);
assign(output,'sotomon.out');
rewrite(output);
readln(n,hang,lie);
for i:=1 to n do begin readln(a[i].x,a[i].y,a[i].k); a[i].ind:=i; end;
ra:=a;  //row col
ca:=a;  //col row
sort1(1,n);
sort2(1,n);
i:=1;
while i<=n do
  begin
  j:=i; stx[ra[i].x]:=i;
  while (j+1<=n)and(ra[j+1].x=ra[i].x) do begin  inc(j); end;
  enx[ra[i].x]:=j;
  i:=j+1;
  end;
i:=1;
while i<=n do
  begin
  j:=i; sty[ca[i].y]:=i;
  while (j+1<=n)and(ca[j+1].y=ca[i].y) do begin  inc(j); end;
  eny[ca[i].y]:=j;
  i:=j+1;
  end;
for i:=1 to n do
    begin
    if a[i].k=1 then
       begin
       le:=stx[a[i].x]; ri:=enx[a[i].x];
       for j:=le to ri do
           begin
           if ra[j].y=a[i].y then continue;
           addedge(i,ra[j].ind);
           addedge2(ra[j].ind,i);
           end;
       end
    else if a[i].k=2 then
            begin
            le:=sty[a[i].y]; ri:=eny[a[i].y];
            for j:=le to ri do
                begin
                if ca[j].x=a[i].x then continue;
                addedge(i,ca[j].ind);
                addedge2(ca[j].ind,i);
                end;
            end
         else begin
              for j:=1 to 8 do
                  begin
                  nx:=a[i].x+dx[j]; ny:=a[i].y+dy[j];
                  if (nx>=1)and(nx<=hang)and(ny>=1)and(ny<=lie) then
                     begin
                     tmp:=find(nx,ny);
                     if (tmp<>-1)and(tmp<>i) then
                        begin
                        addedge(i,tmp);
                        addedge2(tmp,i);
                        end;
                     end;
                  end;
              end;
    end;
for i:=1 to n do
    begin
    if not vis[i] then
       dfs(i);
    end;
for i:=total downto 1 do
    begin
    if col[topsort[i]]=0 then
       begin
       inc(cnt);
       dfs2(topsort[i]);
       end;
    end;
for i:=1 to tot do
    begin
    if col[g[i].u]<>col[g[i].v] then
       addedge3(col[g[i].u],col[g[i].v]);
    end;
for i:=1 to cnt do
    if inner[i]=0 then f[i]:=sum[i];
for i:=total downto 1 do
    begin
    p:=edge3[col[topsort[i]]].first;
    x:=col[topsort[i]];
    while p<>0 do
      begin
      tmp:=h[p].v;
      if f[x]+sum[tmp]>f[tmp] then f[tmp]:=f[x]+sum[tmp];
      p:=h[p].nxt;
      end;
    end;
for i:=1 to cnt do
    if outer[i]=0 then
       if f[i]>ans then ans:=f[i];
writeln(ans);
close(input);
close(output);
end.
