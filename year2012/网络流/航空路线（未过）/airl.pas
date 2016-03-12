const maxn=100; inf=maxlongint; maxq=1000;
type rec=record u,v,c,key,nxt,op:longint; end;
var n,m,s,t,ans,x,y,i,j,tot,total,find,cnt:longint;
    a,b,ts:string;
    st:array[0..maxn]of string;
    edge,dis,fa,vis:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    g:array[0..maxn*maxn]of rec;
    q:array[0..maxq]of longint;
    res:array[0..maxn]of longint;
procedure addedge(x,y,flow,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=flow; g[tot].key:=cost;  g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0;    g[tot].key:=-cost; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean;
var i,head,tail,x,p,tmp:longint;
begin
for i:=s to t do dis[i]:=-inf;
for i:=s to t do fa[i]:=-1;
head:=1; tail:=1;
q[1]:=s;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
dis[s]:=0;
while head<=tail do
  begin
  x:=q[head];
  p:=edge[x];
  while p>0 do
    begin
    tmp:=0;
    if (g[p].c>0)and(dis[x]<>-inf)and(dis[x]+g[p].key>dis[g[p].v])and(tmp=0) then
       begin
       dis[g[p].v]:=dis[x]+g[p].key;
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
  mark[x]:=false;
  end;
if dis[t]=-inf then exit(false) else exit(true);
end;
procedure doit;
var p,min,tmp:longint;
begin
cnt:=0;
while spfa do
  begin
  p:=fa[t];
  min:=inf;
  while p>0 do
    begin
    if (g[p].c>0)and(g[p].c<min) then min:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t];
  inc(cnt);
  while p>0 do
    begin
    if (g[p].u mod 2=1)and(g[p].v mod 2=0)and(g[p].v=g[p].u+1) then
       begin
       tmp:=0;
       if (cnt>1)and(g[p].v+1=t) then tmp:=1;
       if tmp=0 then
          begin
          inc(total);
          res[total]:=g[p].v div 2;
          vis[g[p].v div 2]:=1;
          end;
       end;
    p:=fa[g[p].u];
    end;
  if cnt=1 then
     begin
     for i:=1 to total div 2 do
         begin
         tmp:=res[i];
         res[i]:=res[total+1-i];
         res[total+1-i]:=tmp;
         end;
     end;
  p:=fa[t];
  while p>0 do
    begin
    dec(g[p].c,min);
    inc(g[g[p].op].c,min);
    p:=fa[g[p].u];
    end;
  ans:=ans+dis[t]*min;
  end;
end;
begin
assign(input,'airl.in');
reset(input);
assign(output,'airl.out');
rewrite(output);
readln(n,m);
for i:=1 to n do readln(st[i]);
s:=0; t:=2*n+1;
for i:=1 to m do
    begin
    readln(ts);
    find:=pos(' ',ts);
    a:=copy(ts,1,find-1);
    delete(ts,1,find);
    b:=ts;
    x:=0; y:=0;
    for j:=1 to n do
        if st[j]=a then x:=j;
    for j:=1 to n do
        if st[j]=b then y:=j;
    if x>y then begin x:=x+y; y:=x-y; x:=x-y; end;
    addedge(2*x,2*y-1,1,0);
    end;
for i:=1 to n do
    begin
    if (i=1)or(i=n) then addedge(2*i-1,2*i,2,1)
       else addedge(2*i-1,2*i,1,1);
    end;
addedge(s,1,2,0);
addedge(2*n,t,2,0);
doit;
if cnt<2 then
   begin
   writeln('No Solution!');
   end
else
   begin
   if ans=2 then writeln(2) else writeln(ans-2);
   for i:=1 to total do
       writeln(st[res[i]]);
   end;
close(input);
close(output);
end.
