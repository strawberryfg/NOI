const maxn=2111; maxm=3111111; inf=maxlongint;
type rec=record v,nxt,op,c:longint; end;
var n,i,j,s,t,tot,sum,ans:longint;
    edge,hash,h,q,a,w:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    t1,t2:qword;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function gcd(x,y:longint):longint;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
function flow(x,now:longint):longint;
var p,tmp,res,mmin:longint;
begin
if x=t then exit(now);
p:=edge[x]; tmp:=0;
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
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
           p:=edge[x]; mmin:=t;
           while p<>0 do
             begin
             if (g[p].c>0)and(h[g[p].v]<mmin) then mmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=mmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure sap;
var i,head,tail,p:longint;
begin
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=t+1;
head:=1; tail:=1; h[t]:=0; q[1]:=t;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=t+1) then
       begin
       h[g[p].v]:=h[q[head]]+1;
       inc(tail); q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ans:=0;
while h[s]<t+1 do ans:=ans+flow(s,inf);
end;
begin
assign(input,'b.in');
reset(input);
assign(output,'b.out');
rewrite(output);
readln(n);
for i:=1 to n do read(a[i]);
for i:=1 to n do read(w[i]);
s:=0; t:=2*n+1;
for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        t1:=qword(a[i])*qword(a[i])+qword(a[j])*qword(a[j]);
        t2:=trunc(sqrt(t1));
        if (qword(t2)*qword(t2)=t1)and(gcd(a[i],a[j])=1) then
           begin
           addedge(i,j+n,inf);
           addedge(j,i+n,inf);
           end;
        end;
for i:=1 to n do begin addedge(s,i,w[i]); addedge(i+n,t,w[i]); end;
sum:=0;
for i:=1 to n do sum:=sum+2*w[i];
sap;
sum:=sum-ans;
sum:=sum div 2;
writeln(sum);
close(input);
close(output);
end.
