const maxn=20020; maxlen1=20020; maxlen=500020; base=1000000;
type edgetype=record first,last:longint; end;
     rec=record v,nxt:longint; end;
     treetype=record flag,fall:longint; next:array[1..26]of longint; end;
var n,root,i,j,x,head,tail,id,xx,sum,total,tot,all,p,t:longint;
    edge:array[0..maxn]of edgetype;
    cnt:array[0..maxn]of longint;
    tree:array[0..maxlen1]of treetype;
    q:array[0..maxlen1]of longint;
    f:array[0..1,0..maxlen]of longint;
    a:array[0..1,0..maxlen]of longint;
    g:array[0..maxlen] of rec;
    ch:char;
procedure addedge(x,y:longint);
begin
inc(all); g[all].v:=y;
if edge[x].first=0 then edge[x].first:=all else g[edge[x].last].nxt:=all;
edge[x].last:=all;
end;
function binary(x:longint):longint;
var le,ri,mid,ans:longint;
begin
le:=1; ri:=a[xx][0]; ans:=0;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if a[xx][mid]<=x then begin ans:=mid; le:=mid+1; end
     else ri:=mid-1;
  end;
binary:=ans;
end;
begin
assign(input,'history.in');
reset(input);
assign(output,'history.out');
rewrite(output);
readln(n);
root:=1; tot:=1;
for i:=1 to n do
    begin
    x:=root; cnt[i]:=0;
    while not eoln do
      begin
      inc(cnt[i]);
      read(ch); id:=ord(ch)-ord('a')+1;
      if tree[x].next[id]=0 then
         begin
         inc(tot);
         tree[x].next[id]:=tot;
         end;
      x:=tree[x].next[id];
      end;
    tree[x].flag:=i;
    readln;
    end;
head:=1; tail:=1; q[1]:=root;
while head<=tail do
  begin
  for i:=1 to 26 do
      begin
      if tree[q[head]].next[i]<>0 then
         begin
         if q[head]=root then tree[tree[q[head]].next[i]].fall:=root
            else begin
                 p:=tree[q[head]].fall;
                 while p<>0 do
                   begin
                   if tree[p].next[i]<>0 then begin tree[tree[q[head]].next[i]].fall:=tree[p].next[i]; break; end;
                   p:=tree[p].fall;
                   end;
                 if tree[tree[q[head]].next[i]].fall=0 then tree[tree[q[head]].next[i]].fall:=root;
                 end;
         inc(tail); q[tail]:=tree[q[head]].next[i];
         end;
      end;
  inc(head);
  end;
x:=root; i:=0;
while not eoln do
  begin
  inc(i);
  read(ch);
  id:=ord(ch)-ord('a')+1;
  while (x<>0)and(tree[x].next[id]=0) do x:=tree[x].fall;
  x:=tree[x].next[id];
  if x=0 then x:=root;
  t:=x;
  while t<>root do
    begin
    if tree[t].flag<>0 then addedge(tree[t].flag,i);
    t:=tree[t].fall;
    end;
  end;
p:=edge[1].first;
xx:=0; i:=0; a[xx][0]:=0;
while p<>0 do
  begin
  inc(i);
  f[xx][i]:=(f[xx][i-1]+1) mod base;
  inc(a[xx][0]);
  a[xx][a[xx][0]]:=g[p].v;
  p:=g[p].nxt;
  end;
for j:=2 to n do
    begin
    f[xx xor 1][0]:=0;
    a[xx xor 1][0]:=0;
    i:=0;
    p:=edge[j].first;
    while p<>0 do
      begin
      t:=binary(g[p].v+1-cnt[j]-1);
      if f[xx][t]<>0 then
         begin
         inc(i);
         f[xx xor 1][i]:=f[xx xor 1][i-1];
         inc(a[xx xor 1][0]);
         a[xx xor 1][a[xx xor 1][0]]:=g[p].v;
         f[xx xor 1][i]:=(f[xx xor 1][i]+f[xx][t]) mod base;
         end;
      p:=g[p].nxt;
      end;
    xx:=xx xor 1;
    end;
writeln(f[xx][a[xx][0]]);
close(input);
close(output);
end.