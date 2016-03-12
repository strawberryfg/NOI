const maxn=80000; inf=maxlongint;
type rec=record u,v,nxt,op,c:longint; end;
var n,m,s,t,p,a,b,c,sum,ans,i,tot,head,tail:longint;
    edge,hash,h:array[0..maxn]of longint;
    g:array[0..maxn*4]of rec;
    q:array[0..maxn*4]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function sap(x,now:longint):longint;
var res,tmp,p,fmin:longint;
begin
if x=t then exit(now);
p:=edge[x];
tmp:=0;
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=sap(g[p].v,min(g[p].c,now));
     now:=now-res; tmp:=tmp+res;
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     if h[s]=t+1 then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=t+1
      else begin
           p:=edge[x];
           fmin:=t;
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
begin
assign(input,'profit.in');
reset(input);
assign(output,'profit.out');
rewrite(output);
readln(n,m);
s:=0; t:=n+m+1;
for i:=1 to n do
    begin
    read(p);
    addedge(i+m,t,p);
    end;
sum:=0;
for i:=1 to m do
    begin
    read(a,b,c);
    sum:=sum+c;
    addedge(i,a+m,inf);
    addedge(i,b+m,inf);
    addedge(s,i,c);
    end;
for i:=s to t do h[i]:=t+1;
h[t]:=0; q[1]:=t;
head:=1; tail:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=t+1) then
       begin
       inc(tail);
       q[tail]:=g[p].v;
       h[g[p].v]:=h[q[head]]+1;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ans:=0;
while h[s]<t+1 do
  ans:=ans+sap(s,inf);
writeln(sum-ans);
close(input);
close(output);
end.
