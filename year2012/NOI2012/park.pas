const maxn=211111; maxm=211111; maxq=1111111; maxn1=1555;
type rec=record v,nxt,w:longint; end;
     qtype=record id,fa,len,avo:longint; prob:extended; end;
var n,m,i,x,y,z,tot,cc:longint;
    edge,size,last,vis,cir,mark:array[0..maxn]of longint;
    bel:array[0..maxn1,0..maxn1]of longint;
    g:array[0..maxm]of rec;
    q:array[0..maxq]of qtype;
    ans:extended;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dfs1(x,fa:longint);
var p:longint;
begin
p:=edge[x]; size[x]:=0;
while p<>0 do
  begin
  if g[p].v<>fa then
     begin
     bel[x][g[p].v]:=1;
     dfs1(g[p].v,x);
     size[x]:=size[x]+1;
     end;
  p:=g[p].nxt;
  end;
end;
procedure bfs1(x:longint);
var head,tail,p,pd,t:longint;
begin
head:=1; tail:=1; q[1].id:=x; q[1].fa:=0; q[1].len:=0; q[1].prob:=1/n;
while head<=tail do
  begin
  p:=edge[q[head].id];
  pd:=0;
  while p<>0 do
    begin
    if g[p].v<>q[head].fa then
       begin
       pd:=1;
       inc(tail); q[tail].id:=g[p].v; q[tail].fa:=q[head].id; q[tail].len:=q[head].len+g[p].w;
       t:=size[q[head].id];
       if q[head].id<>1 then inc(t);
       if bel[q[head].id][q[head].fa]=1 then dec(t);
       if bel[q[head].fa][q[head].id]=1 then dec(t);
       q[tail].prob:=q[head].prob*1/t;
       end;
    p:=g[p].nxt;
    end;
  if pd=0 then ans:=ans+q[head].prob*q[head].len;
  inc(head);
  end;
end;
procedure solve1;
var i:longint;
begin
dfs1(1,0);
ans:=0.0;
for i:=1 to n do bfs1(i);
writeln(ans:0:10);
end;
procedure dfs2(x,fa:longint);
var p,t:longint;
begin
p:=edge[x]; size[x]:=0; vis[x]:=1;
last[x]:=fa;
while p<>0 do
  begin
  if g[p].v<>fa then
     begin
     if vis[g[p].v]=1 then
        begin
        if mark[g[p].v]=0 then
           begin
           bel[g[p].v][x]:=1;
           cir[g[p].v]:=1; cir[x]:=1;
           t:=x;
           while true do
             begin
             mark[t]:=1;
             if t=g[p].v then break;
             t:=last[t];
             end;
           end;
        end
     else
        begin
        bel[x][g[p].v]:=1;
        dfs2(g[p].v,x);
        size[x]:=size[x]+1;
        end;
     end;
  p:=g[p].nxt;
  end;
end;
procedure bfs2(x:longint);
var head,tail,p,pd,t,flag:longint;
begin
head:=1; tail:=1; q[1].id:=x; q[1].fa:=0; q[1].len:=0; q[1].prob:=1/n; q[1].avo:=0;
if mark[x]=1 then q[1].avo:=x;
while head<=tail do
  begin
  p:=edge[q[head].id];
  pd:=0;
  while p<>0 do
    begin
    if (g[p].v<>q[head].fa)and(g[p].v<>q[head].avo) then
       begin
       pd:=1;
       inc(tail);
       q[tail].id:=g[p].v; q[tail].fa:=q[head].id; q[tail].len:=q[head].len+g[p].w;
       q[tail].avo:=0;
       t:=size[q[head].id];
       if q[head].id<>1 then inc(t);
       if cir[q[head].id]=1 then inc(t);
       flag:=0;
       if bel[q[head].id][q[head].fa]=1 then begin flag:=q[head].fa; dec(t); end;
       if bel[q[head].fa][q[head].id]=1 then begin flag:=q[head].fa; dec(t); end;
       if (q[head].avo<>0)and(flag<>q[head].avo) then
          begin
          if bel[q[head].id][q[head].avo]=1 then dec(t);
          if bel[q[head].avo][q[head].id]=1 then dec(t);
          end;
       q[tail].prob:=q[head].prob*1/t;
       if q[head].avo<>0 then q[tail].avo:=q[head].avo
          else if mark[g[p].v]=1 then q[tail].avo:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  if pd=0 then
     begin
//     writeln('start from ',x,' ends at ',q[head].id,' len= ',q[head].len,' prob= ',q[head].prob:0:4);
     ans:=ans+q[head].prob*q[head].len;
     end;
  inc(head);
  end;
end;
procedure solve2;
var i:longint;
begin
dfs2(1,0);
ans:=0.0;
for i:=1 to n do bfs2(i);
writeln(ans:0:10);
end;
begin
assign(input,'park.in');
reset(input);
assign(output,'park.out');
rewrite(output);
read(n,m);
for i:=1 to m do
    begin
    read(x,y,z);
    addedge(x,y,z);   //z:integer;
    addedge(y,x,z);
    end;
if m=n-1 then solve1 //tree;
   else solve2;
close(input);
close(output);
end.