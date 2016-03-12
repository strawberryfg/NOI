const maxn=100020; maxm=1000010; inf=maxlongint;
type rec=record v,nxt:longint; end;
     save=record id,day:longint; end;
var n,d,m,i,j,k,x,le,ri,mid,ans,tot,head,tail,cnt,last:longint;
    edge:array[0..maxn]of longint;
    heap:array[0..maxm]of longint;
    a:array[0..maxm]of longint;
    g:array[0..maxm]of rec;
    sta,fans:array[0..maxm]of save;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function check(lim:longint):boolean;
var i,j,p:longint;
begin
head:=1; tail:=0; cnt:=0;
for i:=1 to n do
    begin
    j:=0;
    while (head<=tail)and(j<lim) do
      begin
      if a[heap[head]]<i-d then exit(false);
      inc(cnt); inc(j); sta[cnt].id:=heap[head]; sta[cnt].day:=i;
      inc(head);
      end;
    p:=edge[i];
    while p<>0 do
      begin
      inc(tail); heap[tail]:=g[p].v;
      p:=g[p].nxt;
      end;
    while (head<=tail)and(j<lim) do
      begin
      inc(cnt); inc(j); sta[cnt].id:=heap[head]; sta[cnt].day:=i;
      inc(head);
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
  if check(mid) then begin fans:=sta; ans:=mid; ri:=mid-1; end
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
//while true do i:=i;
close(input);
close(output);
end.