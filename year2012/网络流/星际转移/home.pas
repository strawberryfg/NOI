const maxn=1000; maxday=100; maxm=100000; maxq=1000020; inf=maxlongint;
type rec=record u,v,nxt,op,c:longint; end;
var n,m,k,i,j,s,t,ans,le,ri,mid,tot:longint;
    edge,h,hash:array[0..maxn*maxday]of longint;
    v:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    q:array[0..maxq]of longint;
    rnd:array[0..maxn,0..maxn]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1; g[tot].c:=z;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1; g[tot].c:=0;
end;
function calc(x,y:longint):longint;
begin
y:=y mod rnd[x][0];
if y=0 then y:=rnd[x][0];
y:=rnd[x][y];
if y=-1 then y:=n+1;
exit(y);
end;
function getmin(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var tmp,p,res,min:longint;
begin
if x=t then exit(now);
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,getmin(g[p].c,now));
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     now:=now-res; tmp:=tmp+res;
     if h[s]=t+1 then exit(tmp);
     if now=0 then break;
     end;
  p:=g[p].nxt;
  end;
dec(hash[h[x]]);
if hash[h[x]]=0 then h[s]:=t+1
   else begin
        min:=t;
        p:=edge[x];
        while p<>0 do
          begin
          if (g[p].c>0)and(h[g[p].v]<min) then
             min:=h[g[p].v];
          p:=g[p].nxt;
          end;
        h[x]:=min+1;
        inc(hash[h[x]]);
        end;
exit(tmp);
end;
function check(x:longint):boolean;
var i,j,p,last,now,head,tail,ret:longint;
begin
s:=0; t:=(n+2)*(x+1)+1;
tot:=0;
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
for i:=1 to x+1 do addedge(s,i,k);
for i:=1 to x+1 do addedge((n+1)*(x+1)+i,t,k);
for i:=0 to n do
    for j:=1 to x do
        addedge(i*(x+1)+j,i*(x+1)+j+1,inf);
for i:=1 to m do
    begin
    for j:=1 to x do
        begin
        last:=calc(i,j); now:=calc(i,j+1);
        addedge(last*(x+1)+j,now*(x+1)+j+1,v[i]);
        end;
    end;
for i:=s to t do h[i]:=t+1;
h[t]:=0; q[1]:=t;
head:=1; tail:=1;
fillchar(hash,sizeof(hash),0);
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=t+1) then
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
ret:=0;
while h[s]<t+1 do
   ret:=ret+flow(s,inf);
if ret>=k then exit(true) else exit(false);
end;
begin
assign(input,'home.in');
reset(input);
assign(output,'home.out');
rewrite(output);
readln(n,m,k);
for i:=1 to m do
    begin
    read(v[i],rnd[i][0]);
    for j:=1 to rnd[i][0] do read(rnd[i][j]);
    readln;
    end;
ans:=inf;
le:=1; ri:=50;
while le<=ri do
   begin
   mid:=(le+ri)div 2;
   if check(mid) then begin ans:=mid; ri:=mid-1; end
      else le:=mid+1;
   end;
if ans=inf then writeln(0)
   else writeln(ans);
close(input);
close(output);
end.