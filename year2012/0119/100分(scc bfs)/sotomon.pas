//13:38;init; 14:16; finish writing;
const maxn=100020;
      maxcoordinate=1000200;
      maxm=4000020;
      dx:array[1..8]of longint=(-1,-1,-1,0,0,1,1,1);
      dy:array[1..8]of longint=(-1,0,1,-1,1,-1,0,1);
type rec=record x,y,k,ind:longint; end;
     edgenode=record u,v,nxt:longint; end;
var tot,tot2,tot3,n,hang,lie,i,j,le,ri,nx,ny,tmp,total,cnt,p,ans,x:longint;
    l,r:longint;
    a,ra,ca:array[0..maxn]of rec;
    stx,enx:array[0..maxcoordinate]of longint;
    vis:array[0..maxn]of boolean;
    topsort,col,inner,sum,f,outer,edge,edge2,edge3,q:array[0..maxn]of longint;
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
inc(tot);
g[tot].u:=x; g[tot].v:=y;
g[tot].nxt:=edge[x];
edge[x]:=tot;
end;
procedure addedge2(x,y:longint);
begin
inc(tot2);
tg[tot2].u:=x; tg[tot2].v:=y;
tg[tot2].nxt:=edge2[x];
edge2[x]:=tot2;
end;
procedure addedge3(x,y:longint);
var p:longint;
begin
p:=edge3[x];
inc(tot3); h[tot3].u:=x; h[tot3].v:=y;
inc(inner[y]);
inc(outer[x]);
h[tot3].nxt:=edge3[x];
edge3[x]:=tot3;
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=true;
p:=edge[x];
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
p:=edge2[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
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
for i:=1 to n do
    begin
    if a[i].k=3 then
       begin
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
i:=1;
while i<=n do
  begin
  if ra[i].k=1 then
     begin
     for j:=i-1 downto 1 do
         begin
         if ra[i].x<>ra[j].x then break;
         addedge(ra[i].ind,ra[j].ind);
         addedge2(ra[j].ind,ra[i].ind);
         if ra[j].k=1 then break;
         end;
     for j:=i+1 to n do
         begin
         if ra[i].x<>ra[j].x then
            begin
            i:=j-1;
            break;
            end;
         addedge(ra[i].ind,ra[j].ind);
         addedge2(ra[j].ind,ra[i].ind);
         if ra[j].k=1 then
            begin
            i:=j-1;
            break;
            end;
         end;
     end;
  inc(i);
  end;
i:=1;
while i<=n do
  begin
    if ca[i].k=2 then
     begin
     for j:=i-1 downto 1 do
         begin
         if ca[i].y<>ca[j].y then break;
         addedge(ca[i].ind,ca[j].ind);
         addedge2(ca[j].ind,ca[i].ind);
         if ca[j].k=2 then break;
         end;
     for j:=i+1 to n do
         begin
         if ca[i].y<>ca[j].y then
            begin
            i:=j-1;
            break;
            end;
         addedge(ca[i].ind,ca[j].ind);
         addedge2(ca[j].ind,ca[i].ind);
         if ca[j].k=2 then
            begin
            i:=j-1;
            break;
            end;
         end;
     end;
  inc(i);
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
l:=1; r:=0;
for i:=1 to cnt do
    if inner[i]=0 then
       begin
       f[i]:=sum[i];
       inc(r);
       q[r]:=i;
       end;
while l<=r do
  begin
  p:=edge3[q[l]];
  while p<>0 do
    begin
    dec(inner[h[p].v]);
    if inner[h[p].v]=0 then
       begin
       inc(r);
       q[r]:=h[p].v;
       end;
    p:=h[p].nxt;
    end;
  inc(l);
  end;
for i:=1 to r do
    begin
    p:=edge3[q[i]];
    while p<>0 do
      begin
      if f[q[i]]+sum[h[p].v]>f[h[p].v] then
         f[h[p].v]:=f[q[i]]+sum[h[p].v];
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
