const maxn=100020; maxm=1000000; inf=maxlongint;
type rec=record v,nxt:longint; end;
     save=record id,day:longint; end;
var n,d,m,i,j,k,x,le,ri,mid,ans,tot,top,cnt,last:longint;
    edge:array[0..maxn]of longint;
    heap:array[0..maxm]of longint;
    a:array[0..maxm]of longint;
    g:array[0..maxm]of rec;
    fans,sta:array[0..maxm]of save;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure up(x:longint);
var swap:longint;
begin
while x>0 do
  begin
  if a[heap[x]]<a[heap[x div 2]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     x:=x div 2;
     end
  else break;
  end;
end;
procedure down(x:longint);
var numa,numb,swap,opt:longint;
begin
while x*2<=top do
  begin
  numa:=a[heap[x*2]]; if x*2+1<=top then numb:=a[heap[x*2+1]] else numb:=inf;
  if numa<numb then opt:=0 else opt:=1;
  if a[heap[x]]>a[heap[x*2+opt]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x*2+opt]; heap[x*2+opt]:=swap;
     x:=x*2+opt;
     end
  else break;
  end;
end;
procedure insert(nowid:longint);
begin
inc(top); heap[top]:=nowid;
up(1);
end;
function check(lim:longint):boolean;
var i,j,p:longint;
begin
top:=0; cnt:=0;
for i:=1 to n do
    begin
    if (top>0)and(a[heap[1]]<i-d) then exit(false);
    p:=edge[i];
    while p<>0 do
      begin
      insert(g[p].v);
      p:=g[p].nxt;
      end;
    j:=0;
    while (top>0)and(j<lim) do
      begin
      inc(cnt); inc(j);
      sta[cnt].id:=heap[1]; sta[cnt].day:=i;
      heap[1]:=heap[top]; heap[top]:=0; dec(top);
      down(1);
      end;
    end;
exit(true);
end;
begin
assign(input,'jobs.in');
reset(input);
assign(output,'jobs.out');
rewrite(output);
read(n,d,m);
for i:=1 to m do
    begin
    read(x);
    addedge(x,i);
    a[i]:=x;
    end;
le:=1; ri:=m; ans:=-1;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if check(mid) then begin ans:=mid; fans:=sta; ri:=mid-1; end
     else le:=mid+1;
  end;
writeln(ans);
last:=0;
i:=1;
while i<=m do
  begin
  j:=i;
  while (j+1<=m)and(fans[j+1].day=fans[i].day) do inc(j);
  for k:=last+1 to fans[i].day-1 do writeln(0);
  for k:=i to j do write(fans[k].id,' ');
  write(0);
  writeln;
  last:=fans[i].day;
  i:=j+1;
  end;
for i:=last+1 to n do writeln(0);
close(input);
close(output);
end.