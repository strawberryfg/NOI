//14:25;
const maxn=20020; maxm=200020; maxq=10000020; inf=maxlongint;
type rec=record u,v,c,op,nxt:longint; end;
var n,m,s,t,x,i,y,z,head,tail,sum,tot,ans,p:longint;
    edge,h,hash:array[0..2*maxn]of longint;
    g:array[0..2*maxm]of rec;
    q:array[0..maxq]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].op:=tot+1; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].op:=tot-1; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var tmp,p,fmin,res:longint;
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
     if h[s]=2*n+2 then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[x]:=2*n+2
      else begin
           fmin:=n+1;
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
begin
assign(input,'gate.in');
reset(input);
assign(output,'gate.out');
rewrite(output);
readln(n,m);
s:=0; t:=2*n+1;
sum:=0;
for i:=1 to n do begin read(x); addedge(s,i,x); addedge(i+n,t,x); sum:=sum+x; end;
for i:=1 to m do
    begin
    read(x,y,z);
    addedge(x,y+n,z);
    end;
fillchar(hash,sizeof(hash),0);
head:=1; tail:=1;
for i:=s to t do h[i]:=2*n+2;
q[1]:=t; h[t]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=2*n+2) then
       begin
       h[g[p].v]:=h[q[head]]+1;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ans:=0;
while h[s]<2*n+2 do ans:=ans+flow(s,inf);
writeln(sum-ans);
close(input);
close(output);
end.
