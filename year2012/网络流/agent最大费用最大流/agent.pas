const eps=1e-12; inf=1e30;
      maxn=400; maxm=500000; maxq=6000020;
type rec=record u,v,nxt,op,c:longint; key:extended; end;
var n,k,s,t,t1,i,x,y,ms,tot:longint;
    saf,ans:extended;
    dis,safe:array[0..maxn]of extended;
    edge,a,fa,msg:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    g:array[0..maxm]of rec;
    q:array[0..maxq]of longint;
procedure addedge(opt,x,y,flow:longint; cost:extended);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1; g[tot].c:=flow; g[tot].key:=cost;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1; g[tot].c:=0; g[tot].key:=-cost;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=s to t1 do dis[i]:=-inf;
dis[s]:=0;
head:=1; tail:=1; q[1]:=s;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[q[head]]+g[p].key-dis[g[p].v]>eps) then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].key;
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
  mark[q[head]]:=false;
  inc(head);
  end;
if dis[t1]<>-inf then exit(true) else exit(false);
end;
procedure maxflow;
var p,fmin:longint;
    tmp:extended;
begin
while spfa do
  begin
  p:=fa[t1];
  fmin:=maxlongint;
  while p<>0 do
    begin
    if (g[p].c<fmin) then fmin:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t1];
  while p<>0 do
    begin
    g[p].c:=g[p].c-fmin;
    g[g[p].op].c:=g[g[p].op].c+fmin;
    p:=fa[g[p].u];
    end;
//  writeln('dis[t1]=',dis[t1]:0:12,'       fmin=       ',fmin);
  ans:=ans+dis[t1]*fmin;
//  writeln(' ans =        ',ans:0:12);
  end;
end;
begin
assign(input,'agent.in');
reset(input);
assign(output,'agent.out');
rewrite(output);
readln(n,k);
s:=0; t:=n+1; t1:=n+2;
addedge(0,t,t1,k,0);
for i:=1 to n do read(safe[i]);
for i:=1 to n do read(msg[i]);
readln;
for i:=1 to n do read(a[i]);
for i:=1 to n do
    begin
    if (msg[i]<>0)and(safe[i]>eps) then
       begin
       addedge(0,s,i,msg[i],ln(safe[i]));

       end;
    if a[i]=1 then addedge(0,i,t,k,0);
    end;
read(x,y);
while (x<>-1)and(y<>-1) do
  begin
  read(saf,ms);
  if (saf>eps)and(ms<>0) then
     begin
     addedge(0,x,y,ms,ln(saf));
     addedge(0,y,x,ms,ln(saf));
     end;
  readln;
  read(x,y);
  end;
ans:=0;
maxflow;
ans:=exp(ans);
writeln(round(ans*1000000000000)/1000000000000:0:12);
close(input);
close(output);
end.
