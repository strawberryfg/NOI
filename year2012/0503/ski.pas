const maxn=200000; maxm=1000020; inf=maxlongint;
type heaptype=record id,v:longint; end;
     rec=record u,v,w,nxt:longint; end;
var n,m,i,x,y,z,top,tot,p,num,now,cnt:longint;
    ans:int64;
    edge,mind,bel,h:array[0..2*maxn]of longint;
    inheap:array[0..2*maxn]of boolean;
    heap:array[0..2*maxn]of heaptype;
    g:array[0..2*maxm]of rec;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure up(x:longint);
var tmp:longint;
    swap:heaptype;
begin
while x div 2>=1 do
  begin
  if heap[x].v<heap[x div 2].v then
     begin
     tmp:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x div 2].id]; bel[heap[x div 2].id]:=tmp;
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     x:=x div 2;
     end
  else
     break;
  end;
end;
procedure insert(x,y:longint);
begin
inc(top); heap[top].id:=x; heap[top].v:=y;
bel[x]:=top; inheap[x]:=true;
up(top);
end;
procedure down(x:longint);
var tmp:longint;
    swap:heaptype;
begin
while x*2<=top do
  begin
  if x*2+1>top then
     begin
     if heap[x].v>heap[x*2].v then
        begin
        tmp:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2].id]; bel[heap[x*2].id]:=tmp;
        swap:=heap[x]; heap[x]:=heap[x*2]; heap[x*2]:=swap;
        x:=x*2;
        end
     else
        break;
     end
  else if heap[x*2].v>heap[x*2+1].v then
          begin
          if heap[x].v>heap[x*2+1].v then
             begin
             tmp:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2+1].id]; bel[heap[x*2+1].id]:=tmp;
             swap:=heap[x]; heap[x]:=heap[x*2+1]; heap[x*2+1]:=swap;
             x:=x*2+1;
             end
          else
             break;
          end
       else
          begin
          if heap[x].v>heap[x*2].v then
             begin
             tmp:=bel[heap[x].id]; bel[heap[x].id]:=bel[heap[x*2].id]; bel[heap[x*2].id]:=tmp;
             swap:=heap[x]; heap[x]:=heap[x*2]; heap[x*2]:=swap;
             x:=x*2;
             end
          else
             break;
          end;
  end;
end;
procedure modify(x,y:longint);
begin
heap[x].v:=y;
up(x);
end;
procedure pop;
begin
if top>0 then
   begin
   num:=heap[1].id; now:=heap[1].v;
   inheap[heap[1].id]:=false;
   heap[1]:=heap[top]; heap[top].id:=0; heap[top].v:=0;
   bel[heap[1].id]:=1;
   dec(top);
   down(1);
   end;
end;
begin
assign(input,'ski.in');
reset(input);
assign(output,'ski.out');
rewrite(output);
readln(n,m);
for i:=1 to n do read(h[i]);
for i:=1 to m do
    begin
    readln(x,y,z);
    if h[x]>h[y] then addedge(x,y,z)
       else if h[x]<h[y] then addedge(y,x,z)
               else begin
                    addedge(x,y,z);
                    addedge(y,x,z);
                    end;
    end;
for i:=1 to n do mind[i]:=inf;
mind[1]:=0;
for i:=1 to n do inheap[i]:=false;
top:=0;
p:=edge[1];
while p<>0 do
  begin
  mind[g[p].v]:=g[p].w;
  insert(g[p].v,g[p].w);
  p:=g[p].nxt;
  end;
ans:=0;
cnt:=1;
while true do
  begin
  num:=-1; now:=-1;
  pop;
  if num=-1 then
     break;
  inc(cnt);
  ans:=ans+int64(now);
  mind[num]:=0;
  p:=edge[num];
  while p<>0 do
    begin
    if g[p].w<mind[g[p].v] then
       begin
       mind[g[p].v]:=g[p].w;
       if inheap[g[p].v] then modify(bel[g[p].v],g[p].w)
          else insert(g[p].v,g[p].w);
       end;
    p:=g[p].nxt;
    end;
  end;
writeln(cnt,' ',ans);
close(input);
close(output);
end.
