const maxn=1020; maxq=10000020; inf=1000000; inf2=9223372036854775807;
type rec=record u,v,nxt,op,c,key:longint; end;
var n,m,s,t,t1,i,j,x,tot:longint;
    ans:int64;
    edge,a,fa:array[0..2*maxn]of longint;
    dis:array[0..2*maxn]of int64;
    g:array[0..4*maxn*maxn]of rec;
    mark:array[0..2*maxn]of boolean;
    q:array[0..maxq]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedge(x,y,cap,cost:longint);
begin
//writeln(x,' -> ',y,'   :cap   ',cap,'    :cost   ',cost);
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1; g[tot].c:=cap; g[tot].key:=cost;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1; g[tot].c:=0;   g[tot].key:=-cost;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=s to t do begin dis[i]:=inf2; fa[i]:=0; end;
dis[s]:=0;
fillchar(mark,sizeof(mark),false);
head:=1; tail:=1;
q[1]:=s; mark[s]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[q[head]]+int64(g[p].key)<dis[g[p].v])then
       begin
//       writeln('          d[',q[head],']=    ',dis[q[head]]:14,'  c[',q[head],'][',g[p].v,']=  ',g[p].key:5,'    d[',g[p].v,']=     ',dis[g[p].v]);
       dis[g[p].v]:=dis[q[head]]+int64(g[p].key);
       fa[g[p].v]:=p;
       if not mark[g[p].v] then
          begin
          mark[g[p].v]:=true;
          inc(tail);
          q[tail]:=g[p].v;
          end;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  mark[q[head]]:=false;
  end;
if dis[t]<>inf2 then exit(true) else exit(false);
end;
procedure maxflow;
var fmin,p:longint;
    tmp:int64;
begin
while spfa do
  begin
  fmin:=inf;
  p:=fa[t];
  while p<>0 do
    begin
    if (g[p].c>0)and(g[p].c<fmin) then fmin:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t];
{ writeln;
  writeln;
  writeln;
  writeln;
  writeln('fmin=        ',fmin);
  writeln('dis[t]=      ',dis[t]);}
  while P<>0 do
    begin
    dec(g[p].c,fmin);
    inc(g[g[p].op].c,fmin);
//    writeln(g[p].u,'     -     >   ',g[p].v,'    - >     ',g[p].key);
    p:=fa[g[p].u];
    end;
{  writeln;
  writeln;
  writeln;
  writeln;}
  tmp:=dis[t]*int64(fmin);
  tmp:=tmp mod inf+inf;
{  writeln('ans:',ans);
  writeln('tmp:',tmp);}
  ans:=(ans+tmp)mod inf;
  if ans<0 then ans:=ans+inf;
//  writeln('ans:',ans);
  end;
end;
begin
assign(input,'tour.in');
reset(input);
assign(output,'tour.out');
rewrite(output);
readln(n,m);
s:=0; t1:=2*n+1; t:=2*n+2;
addedge(t1,t,m,0);
for i:=1 to n do
    begin
    read(a[i]);
    addedge(s,i,m,0);
    addedge(i+n,t1,m,0);
    addedge(i,i+n,a[i],-inf);
    end;
for i:=1 to n-1 do
    begin
    for j:=1 to n-i do
        begin
        read(x);
        if x<>-1 then
           begin
           addedge(i+n,i+j,min(a[i],a[i+j]),x);
           end;
        end;
    end;
ans:=0;
maxflow;
writeln(ans);
close(input);
close(output);
end.
