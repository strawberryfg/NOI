const inf=maxlongint; maxn=1020; maxm=70020;
type rec=record u,v,c,nxt,op:longint; end;
var test,u,n,m,i,j,k,t,y,max,s,cnt,sum,tot:longint;
    q,c,hash,h,edge,vis:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    a,b:array[0..maxm]of longint;
    f:array[0..maxn,0..33]of longint;
    two:array[0..33]of int64;
    ret:int64;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function flow(x,now:longint):longint;
var p,tmp,res,fmin:longint;
begin
if x=t then exit(now);
p:=edge[x];
tmp:=0;
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(now,g[p].c));
     now:=now-res; tmp:=tmp+res;
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     if now=0 then break;
     if h[s]=n+2 then exit(tmp);
     end;
  p:=g[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=n+2
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
procedure sap;
var i,p,head,tail:longint;
begin
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=n+2;
head:=1; tail:=1; q[1]:=t; h[t]:=0;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=n+2) then
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
while h[s]<n+2 do
   sum:=sum+flow(s,inf);
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(vis[g[p].v]=0) then
     dfs(g[p].v);
  p:=g[p].nxt;
  end;
end;
begin
{assign(input,'e:\work\optimalmarks.in');
reset(input);
assign(output,'e:\work\optimalmarks.out');
rewrite(output);}
readln(test);
two[0]:=1;
for i:=1 to 31 do two[i]:=two[i-1]*2;
for u:=1 to test do
    begin
    fillchar(f,sizeof(f),0);
    readln(n,m);
    for i:=1 to m do
        begin
        readln(a[i],b[i]);
        end;
    readln(k);
    max:=0;
    for i:=1 to k do
        begin
        read(c[i],y);
        t:=y;
        cnt:=0;
        while t<>0 do
          begin
          inc(cnt);
          f[c[i]][cnt]:=t mod 2;
          t:=t div 2;
          end;
        if cnt>max then
           max:=cnt;
        end;
    s:=0; t:=n+1;
    for i:=1 to max do
        begin
        for j:=s to t do edge[j]:=0;
        fillchar(g,sizeof(g),0);
        tot:=0;
        for j:=1 to m do
            begin
            addedge(a[j],b[j],1);
            addedge(b[j],a[j],1);
            end;
        for j:=1 to k do
            if f[c[j]][i]=0 then
               addedge(c[j],t,inf)
            else
               addedge(s,c[j],inf);
        sum:=0;
        sap;
        fillchar(vis,sizeof(vis),0);
        dfs(s);
        for j:=1 to n do
            begin
            if vis[j]=1 then f[j][i]:=1 else f[j][i]:=0;
            end;
        end;
    for i:=1 to n do
        begin
        ret:=0;
        for j:=1 to max do
            ret:=ret+two[j-1]*f[i][j];
        writeln(ret);
        end;
    end;
{close(input);
close(output);}
end.
