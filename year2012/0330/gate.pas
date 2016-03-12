const maxn=10020; maxm=200020; inf=maxlongint; maxq=10000000;
type rec=record u,v,c,key,nxt,op:longint; end;
var n,m,s,t,i,u,v,w,x,ans,min,p,tot,tmp,sum:longint;
    edge:array[0..2*maxn]of longint;
    g:array[0..2*maxm]of rec;
    dis,fa,a:array[0..2*maxn]of longint;
    q:array[0..maxq]of longint;
    mark:array[0..2*maxn]of boolean;
procedure addedge(x,y,z,w:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].key:=w; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].key:=-w; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function spfa:boolean;
var p,head,tail,i:longint;
begin
for i:=s to t do dis[i]:=inf;
dis[s]:=0;
head:=1; tail:=1; q[1]:=s;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(dis[q[head]]+g[p].key<dis[g[p].v]) then
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
if (dis[t]=inf)or(dis[t]>=0) then exit(false) else exit(true);
end;
function getmin(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'gate.in');
reset(input);
assign(output,'gate.out');
rewrite(output);
readln(n,m);
s:=0; t:=2*n+1;
for i:=1 to n do begin read(x); addedge(i,i+n,x,-1); a[i]:=x; sum:=sum+x; end;
for i:=1 to n do begin addedge(i+n,t,a[i],0); addedge(s,i,a[i],1); end;
for i:=1 to m do
    begin
    readln(u,v,w);
    tmp:=getmin(getmin(w,a[u]),a[v]);
    addedge(u+n,v,tmp,0);
    end;
ans:=0;
while spfa do
   begin
   min:=inf;
   p:=fa[t];
   while p<>0 do
     begin
     if (g[p].c>0)and(g[p].c<min) then min:=g[p].c;
     p:=fa[g[p].u];
     end;
   p:=fa[t];
   while p<>0 do
     begin
     dec(g[p].c,min);
     inc(g[g[p].op].c,min);
     p:=fa[g[p].u];
     end;
   ans:=ans+dis[t]*min;
   end;
writeln(ans+sum);
close(input);
close(output);
end.
