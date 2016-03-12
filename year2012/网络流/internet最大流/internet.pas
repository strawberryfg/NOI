//18:50;
const maxn=200; maxm=100020; maxq=1000020; inf=maxlongint;
type rec=record u,v,nxt,c,op:longint; end;
var n,m,s,t,i,x,y,z,tot,ans:longint;
    g:array[0..2*maxm]of rec;
    edge,hash,h:array[0..maxn]of longint;
    q:array[0..maxq]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; g[tot].c:=z; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; g[tot].c:=z; edge[y]:=tot; g[tot].op:=tot-1;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var fmin,p,tmp,res:longint;
begin
if x=t then exit(now);
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     now:=now-res; tmp:=tmp+res;
     if h[s]=n then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=n
      else begin
           fmin:=n-1;
           p:=edge[x];
           while p<>0 do
             begin
             if (g[p].c>0)and(h[g[p].v]<fmin) then
                fmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=fmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure sap;
var i,head,tail,p:longint;
begin
for i:=1 to n do h[i]:=n;
fillchar(hash,sizeof(hash),0);
head:=1; tail:=1; q[1]:=t;
h[t]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c>0)and(h[g[p].v]=n) then
       begin
       h[g[p].v]:=h[q[head]]+1;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=1 to n do inc(hash[h[i]]);
while h[s]<n do ans:=ans+flow(s,inf);
end;
begin
assign(input,'internet.in');
reset(input);
assign(output,'internet.out');
rewrite(output);
readln(n);
readln(s,t,m);
for i:=1 to m do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    end;
sap;
writeln('The bandwidth is ',ans,'.');
close(input);
close(output);
end.
