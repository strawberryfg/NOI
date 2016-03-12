const eps=1e-10;  maxn=200; maxm=8020; maxq=7000020; inf=maxlongint;
type rec=record u,v,nxt,op:longint; c:extended; end;
var n,m,s,t,i,x,y,total,tot,k,num:longint;
    le,ri,mid,delta,res,u,ans:extended;
    edge,info,hash,h,cnt,vis:array[0..maxn]of longint;
    g,tg:array[0..maxm]of rec;
    q:array[0..maxq]of longint;
    flag:boolean;
procedure addedge(x,y:longint;z:extended);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; g[tot].op:=tot+1; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; g[tot].op:=tot-1; edge[y]:=tot;
end;
function min(x,y:extended):extended;
begin
if x-y>eps then exit(y) else exit(x);
end;
function flow(x:longint;now:extended):extended;
var p,fmin:longint;
    tmp,res:extended;
begin
if x=t then begin exit(now); end;
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>eps)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(now,g[p].c));
     now:=now-res; tmp:=tmp+res;
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     if now<eps then break;
     if h[s]=n+2 then exit(tmp);
     end;
  p:=g[p].nxt;
  end;
if tmp<eps then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=n+2
      else begin
           fmin:=n+1;
           p:=edge[x];
           while p<>0 do
             begin
             if (g[p].c>eps)and(h[g[p].v]<fmin) then
                fmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=fmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure dfs(x:longint);
var p:longint;
begin
if (x<>s)and(x<>t) then inc(k);
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if (vis[g[p].v]=0)and(g[p].c>eps) then
     dfs(g[p].v);
  p:=g[p].nxt;
  end;
end;
function check(x:extended):extended;
var i,head,tail,p:longint;
    sum,tmp:extended;
begin
edge:=info;
tot:=total;
g:=tg;
for i:=1 to n do
    begin
    addedge(i,t,u+2*x-cnt[i]);
    addedge(s,i,u);
    end;
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=n+2;
q[1]:=t; h[t]:=0;
head:=1; tail:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c<eps)and(h[g[p].v]=n+2) then
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
sum:=0;
while h[s]<n+2 do sum:=sum+flow(s,inf);
if sum>n*u then writeln('false');
sum:=((n*u-sum)/2);
k:=0;
fillchar(vis,sizeof(vis),0);
dfs(s);
//for i:=1 to n do if vis[i]=1 then write(i,'   ');
//writeln;
exit(sum);
end;
begin
assign(input,'hardlife.in');
reset(input);
assign(output,'hardlife.out');
rewrite(output);
readln(n,m);
u:=m+100;
s:=0; t:=n+1;
for i:=1 to n do cnt[i]:=0;
for i:=1 to m do
    begin
    readln(x,y);
    inc(cnt[x]); inc(cnt[y]);
    addedge(x,y,1.0);
    addedge(y,x,1.0);
    end;
tg:=g;
info:=edge;
total:=tot;
le:=0; ri:=m/1; delta:=0;
while ri-le>eps do
  begin
  inc(num);
  mid:=(le+ri)/2;
  res:=check(mid);
  if abs(res)<eps then
     begin
     if k<>0 then
        begin
        ans:=mid;
        break;
        end;
     end;
{  writeln('le  :  ',le:0:14,'  ri   :',ri:0:14,'  res:   ',res:0:14);
  writeln('mid :  ',mid:0:14);}
  if res>eps then begin ans:=mid; le:=mid+delta; end
     else ri:=mid-delta;
  end;
if m=0 then
   begin
   writeln(1);
   writeln(1);
   end
else
   begin
//   writeln('le  :  ',le:0:14,'   mid:   ',mid:0:14,'  ri   :',ri:0:14);
   flag:=true;
   res:=check(ans);
   writeln(k);
   for i:=1 to n do
       if vis[i]=1 then writeln(i);
{   res:=check(0.999999999955);
   writeln('------------------------------------------');
   fillchar(vis,sizeof(vis),0);
   dfs(s);
   writeln(k);
   for i:=1 to n do
       if vis[i]=1 then writeln(i);
   writeln(res:0:20);}
   end;
//for i:=1 to n do writeln(i,':',cnt[i]);
close(input);
close(output);
end.
