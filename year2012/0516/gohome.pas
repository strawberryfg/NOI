//uses dos;
const maxm=200020;  maxheap=6000020; inf=maxlongint;
type newtype=record x,y:longint; end;
     heaptype=record u,v,w:longint; end;
var n,m,cnt,i,x,y,xx,yy,cost,ans,sx,sy,ex,ey,sum,j,belst,belen,flagst,flagen:longint;
    tot:longint;
    ind,ind2:array[0..maxm]of longint;
    edge:array[0..maxm,1..4]of longint;
    f,hash:array[0..maxm,1..4]of longint;
    a,b,ta:array[0..maxm]of newtype;
    heap:array[0..maxheap]of heaptype;
{    aa,bb,cc,dd:word;
    tt1,tt2:real;}
procedure sortx(l,r: longint);
var i,j,xx,yy,tmp:longint;
    swapnew:newtype;
begin
i:=l; j:=r; xx:=a[(l+r) div 2].x; yy:=a[(l+r)div 2].y;
repeat
while (a[i].x<xx)or((a[i].x=xx)and(a[i].y<yy)) do inc(i);
while (xx<a[j].x)or((xx=a[j].x)and(yy<a[j].y)) do dec(j);
if not(i>j) then begin swapnew:=a[i]; a[i]:=a[j]; a[j]:=swapnew; tmp:=ind[i]; ind[i]:=ind[j]; ind[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sortx(l,j);
if i<r then sortx(i,r);
end;
procedure sorty(l,r: longint);
var i,j,xx,yy,tmp:longint;
    swapnew:newtype;
begin
i:=l; j:=r; xx:=b[(l+r) div 2].x; yy:=b[(l+r)div 2].y;
repeat
while (b[i].y<yy)or((b[i].y=yy)and(b[i].x<xx)) do inc(i);
while (yy<b[j].y)or((yy=b[j].y)and(xx<b[j].x)) do dec(j);
if not(i>j) then begin swapnew:=b[i]; b[i]:=b[j]; b[j]:=swapnew; tmp:=ind2[i]; ind2[i]:=ind2[j]; ind2[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sorty(l,j);
if i<r then sorty(i,r);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure up(x:longint);
var swap:heaptype;
    tmp:longint;
begin
while x div 2>=1 do
  begin
  if heap[x].w<heap[x div 2].w then
     begin
     tmp:=hash[heap[x].u][heap[x].v]; hash[heap[x].u][heap[x].v]:=hash[heap[x div 2].u][heap[x div 2].v]; hash[heap[x div 2].u][heap[x div 2].v]:=tmp;
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     x:=x div 2;
     end
  else
     break;
  end;
end;
procedure down(x:longint);
var numx,numy,num,tmp:longint;
    swap:heaptype;
begin
while x*2<=tot do
  begin
  numx:=heap[x*2].w; if x*2+1>tot then numy:=inf else numy:=heap[x*2+1].w;
  if numx<numy then num:=0 else num:=1;
  if heap[x].w>heap[x*2+num].w then
     begin
     tmp:=hash[heap[x].u][heap[x].v]; hash[heap[x].u][heap[x].v]:=hash[heap[x*2+num].u][heap[x*2+num].v]; hash[heap[x*2+num].u][heap[x*2+num].v]:=tmp;
     swap:=heap[x]; heap[x]:=heap[x*2+num]; heap[x*2+num]:=swap;
     x:=x*2+num;
     end
  else
     break;
  end;
end;
procedure insert(x,y,z:longint);
begin
inc(tot);
heap[tot].u:=x; heap[tot].v:=y; heap[tot].w:=z;
f[x][y]:=z;
hash[x][y]:=tot;
up(tot);
end;
procedure modify(x,y,z:longint);
begin
f[x][y]:=z;
heap[hash[x][y]].w:=z;
up(hash[x][y]);
end;
procedure pop;
begin
xx:=heap[1].u; yy:=heap[1].v;
hash[xx][yy]:=0;
heap[1]:=heap[tot];
hash[heap[1].u][heap[1].v]:=1;
heap[tot].u:=0; heap[tot].v:=0;
heap[tot].w:=0;
dec(tot);
down(1);
end;
begin
assign(input,'gohome.in');
reset(input);
assign(output,'gohome.out');
rewrite(output);
readln(n,m);
{gettime(aa,bb,cc,dd);
tt1:=aa*3600+bb*60+cc+dd/100;}
cnt:=0;
for i:=1 to m do
    begin
    readln(x,y);

       inc(cnt); a[cnt].x:=x; a[cnt].y:=y;
    end;
readln(sx,sy,ex,ey);
flagst:=0; flagen:=0;
for i:=1 to cnt do
    begin
    if (a[i].x=sx)and(a[i].y=sy) then flagst:=1;
    if (a[i].x=ex)and(a[i].y=ey) then flagen:=1;
    end;
inc(cnt); a[cnt].x:=sx; a[cnt].y:=sy;
inc(cnt); a[cnt].x:=ex; a[cnt].y:=ey;
i:=1; sum:=0;
while i<=cnt do
  begin
  j:=i;
  while (j+1<=cnt)and(a[j+1].x=a[i].x)and(a[j+1].y=a[i].y) do inc(j);
  inc(sum);
  ta[sum]:=a[i];
  ind[sum]:=sum;
  if (a[i].x=sx)and(a[i].y=sy) then belst:=sum;
  if (a[i].x=ex)and(a[i].y=ey) then belen:=sum;
  i:=j+1;
  end;
cnt:=sum;
a:=ta;
b:=ta;
ind2:=ind;
sortx(1,cnt);
sorty(1,cnt);
i:=1;
while i<=cnt do
  begin
  j:=i;
  while (j+1<=cnt)and(a[i].x=a[j+1].x) do
    begin
    inc(j);
    edge[ind[j-1]][2]:=ind[j];
    edge[ind[j]][3]:=ind[j-1];
    end;
  i:=j+1;
  end;
i:=1;
while i<=cnt do
  begin
  j:=i;
  while (j+1<=cnt)and(b[i].y=b[j+1].y) do
    begin
    inc(j);
    edge[ind2[j-1]][4]:=ind2[j];
    edge[ind2[j]][1]:=ind2[j-1];
    end;
  i:=j+1;
  end;
for i:=1 to cnt do
    for j:=1 to 4 do
        f[i][j]:=inf;
for i:=1 to 4 do
    begin
    f[belst][i]:=0;
    insert(belst,i,0);
    end;
while true do
  begin
  xx:=-1; yy:=-1;
  if tot>0 then pop;
  if (xx=-1)or(yy=-1) then break;
  for i:=1 to 4 do
      begin
      if edge[xx][i]<>0 then
         begin
         cost:=abs(ta[xx].x-ta[edge[xx][i]].x)+abs(ta[xx].y-ta[edge[xx][i]].y);
         if i=yy then cost:=cost*2 else
            begin
            if (xx=belst)and(flagst=0) then continue;
            if (xx=belen)and(flagen=0) then continue;
            cost:=cost*2+1;
            end;
         if f[xx][yy]+cost<f[edge[xx][i]][i] then
            begin
            if hash[edge[xx][i]][i]=0 then insert(edge[xx][i],i,f[xx][yy]+cost)
               else modify(edge[xx][i],i,f[xx][yy]+cost);
            end;
         end;
      end;
  end;
ans:=inf;
for i:=1 to 4 do ans:=min(ans,f[belen][i]);
if ans=inf then writeln(-1) else writeln(ans);
{gettime(aa,bb,cc,dd);
tt2:=aa*3600+bb*60+cc+dd/100;
writeln(tt2-tt1:0:10);    }
close(input);
close(output);
end.
