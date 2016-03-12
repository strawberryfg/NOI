const maxn=100000;
type rec=record v:extended;y,z:longint; end;
var n,m,i,tot,cnt,y,z:longint;
    inf,sum,l:extended;
    a:array[0..maxn]of extended;
    heap:array[0..4*maxn]of rec;
function work(x:extended; k:longint):extended;
begin
exit(x*x/(1+k)-2*x*l+(1+k)*l*l);
end;
procedure up(p:longint);
var tmp:rec;
begin
while p div 2>=1 do
  begin
  if (heap[p div 2].v-heap[p].v>1e-10) then
     begin
     tmp:=heap[p div 2]; heap[p div 2]:=heap[p]; heap[p]:=tmp;
     p:=p div 2;
     end
  else
     break;
  end;
end;
procedure insert(x:extended;y,z:longint);
begin
inc(tot);
heap[tot].v:=x; heap[tot].y:=y; heap[tot].z:=z;
up(tot);
end;
procedure remove;
var p,num:longint;
    tmp:rec;
    v1,v2:extended;
begin
heap[1]:=heap[tot]; dec(tot);
if tot=1 then exit;
p:=1;
while (p*2<=tot) do
  begin
  v1:=heap[p*2].v; if p*2+1<=tot then v2:=heap[p*2+1].v else v2:=inf;
  if v2-v1>1e-10 then num:=0 else num:=1;
  if heap[p].v-heap[p*2+num].v>1e-10 then
     begin
     tmp:=heap[p]; heap[p]:=heap[p*2+num]; heap[p*2+num]:=tmp;
     p:=p*2+num;
     end
  else
     break;
  end;
end;
begin
assign(input,'seq.in');
reset(input);
assign(output,'seq.out');
rewrite(output);
readln(n,m,l);
inf:=1844674407370955;
for i:=1 to n do read(a[i]);
for i:=1 to n-1 do a[i]:=a[i+1]-a[i];
sum:=0;
for i:=1 to n-1 do
    sum:=sum+work(a[i],0);
tot:=0;
for i:=1 to n-1 do
    insert(work(a[i],1)-work(a[i],0),i,1);
cnt:=0;
while (tot>0)and(cnt<m) do
  begin
  inc(cnt);
  if heap[1].v>1e-10 then break;
  sum:=sum+heap[1].v;
  y:=heap[1].y; z:=heap[1].z;
  remove;
  insert(work(a[y],z+1)-work(a[y],z),y,z+1);
  end;
writeln(sum:0:3);
close(input);
close(output);
end.