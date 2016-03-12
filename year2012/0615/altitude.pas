const maxn=520; inf=5555555555555555555;
type rec=record v,nxt:longint; w:qword; end;
var n,i,j,s,t,p,num,top,tot:longint;
    edge:array[0..maxn*maxn]of longint;
    g:array[0..maxn*maxn*12]of rec;
    dis:array[0..maxn*maxn]of qword;
    bel,heap:array[0..maxn*maxn]of longint;
    v:qword;
procedure addedge(x,y:longint; z:qword);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].w:=z;
end;
procedure up(x:longint);
var swap:longint;
begin
while x>1 do
  begin
  if dis[heap[x]]<dis[heap[x div 2]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     bel[heap[x div 2]]:=x div 2; bel[heap[x]]:=x;
     x:=x div 2;
     end
  else break;
  end;
end;
procedure down(x:longint);
var numa,numb:qword; opt:longint; swap:longint;
begin
while x*2<=top do
  begin
  numa:=dis[heap[x*2]]; if x*2+1<=top then numb:=dis[heap[x*2+1]] else numb:=inf;
  if numa<numb then opt:=0 else opt:=1;
  if dis[heap[x]]>dis[heap[x*2+opt]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x*2+opt]; heap[x*2+opt]:=swap;
     bel[heap[x]]:=x; bel[heap[x*2+opt]]:=x*2+opt;
     x:=x*2+opt;
     end
  else break;
  end;
end;
procedure insert(x:longint);
begin
inc(top); heap[top]:=x; bel[x]:=top;
up(top);
end;
procedure pop;
begin
num:=heap[1];
heap[1]:=heap[top]; heap[top]:=0;
bel[heap[1]]:=1;
dec(top);
down(1);
bel[num]:=0;
end;
begin
assign(input,'altitude.in');
reset(input);
assign(output,'altitude.out');
rewrite(output);
readln(n);
s:=0; t:=(n+1)*(n+1)+1;
for i:=1 to n+1 do
    for j:=1 to n do
        begin
        readln(v);
        if (i>1)and(i<n+1) then addedge((i-1)*(n+1)+j,(i-2)*(n+1)+j,v)
           else if i=1 then addedge((i-1)*(n+1)+j,t,v)
                   else addedge(s,(i-2)*(n+1)+j,v);
        end;
for i:=1 to n do
    for j:=1 to n+1 do
        begin
        readln(v);
        if (j>1)and(j<n+1) then addedge((i-1)*(n+1)+j-1,(i-1)*(n+1)+j,v)
           else if j=1 then addedge(s,(i-1)*(n+1)+j,v)
                   else addedge((i-1)*(n+1)+j-1,t,v);
        end;
for i:=1 to n+1 do
    for j:=1 to n do
        begin
        readln(v);
        if (i>1)and(i<n+1) then addedge((i-2)*(n+1)+j,(i-1)*(n+1)+j,v)
           else if i=1 then addedge(t,(i-1)*(n+1)+j,v)
                   else addedge((i-2)*(n+1)+j,s,v);
        end;
for i:=1 to n do
    for j:=1 to n+1 do
        begin
        readln(v);
        if (j>1)and(j<n+1) then addedge((i-1)*(n+1)+j,(i-1)*(n+1)+j-1,v)
           else if j=1 then addedge((i-1)*(n+1)+j,s,v)
                   else addedge(t,(i-1)*(n+1)+j-1,v);
        end;
for i:=s to t do dis[i]:=inf;
dis[s]:=0;
insert(s);
while top>0 do
  begin
  pop;
  p:=edge[num];
  while p<>0 do
    begin
    if dis[num]+g[p].w<dis[g[p].v] then
       begin
       dis[g[p].v]:=dis[num]+g[p].w;
       if bel[g[p].v]=0 then insert(g[p].v)
          else up(bel[g[p].v]);
       end;
    p:=g[p].nxt;
    end;
  end;
writeln(dis[t]);
close(input);
close(output);
end.