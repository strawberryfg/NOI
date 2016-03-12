const eps=1e-10;
      maxn=400; maxm=1600;
      inf=1e30;
type rec=record u,v,nxt,op:longint; c:extended; end;
var n,m,i,x,y,tot,tot2,s,t,cnt,total:longint;
    h,hash,edge,edge2,q,vis:array[0..maxn]of longint;
    g,tg:array[0..maxm]of rec;
    le,ri,mid,max,sum,z:extended;
    ans,flag:array[0..maxm]of longint;
function min(x,y:extended):extended;
begin
if x-y>eps then exit(y) else exit(x);
end;
procedure init;
begin
fillchar(edge,sizeof(edge),0);
fillchar(edge2,sizeof(edge2),0);
fillchar(vis,sizeof(vis),0);
fillchar(hash,sizeof(hash),0);
max:=0;  tot:=0; cnt:=0;
end;
procedure addedge(x,y:longint;z:extended);
begin
inc(tot); tg[tot].u:=x; tg[tot].v:=y; tg[tot].c:=z; tg[tot].nxt:=edge[x]; edge[x]:=tot; tg[tot].op:=tot+1;
inc(tot); tg[tot].u:=y; tg[tot].v:=x; tg[tot].c:=z; tg[tot].nxt:=edge[y]; edge[y]:=tot; tg[tot].op:=tot-1;
end;
procedure addedge2(x,y:longint;z:extended);
begin
inc(tot2); g[tot2].u:=x; g[tot2].v:=y; g[tot2].c:=z; g[tot2].nxt:=edge2[x]; edge2[x]:=tot2; g[tot2].op:=tot2+1;
inc(tot2); g[tot2].u:=y; g[tot2].v:=x; g[tot2].c:=0; g[tot2].nxt:=edge2[y]; edge2[y]:=tot2; g[tot2].op:=tot2-1;
end;
function flow(x:longint; now:extended):extended;
var fmin,p:longint;
    res,tmp:extended;
begin
if x=t then exit(now);
p:=edge2[x];
tmp:=0;
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
     now:=now-res; tmp:=tmp+res;
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
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
           p:=edge2[x];
           fmin:=n-1;
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
for i:=s to t do h[i]:=n;
h[t]:=0; q[1]:=t;
head:=1; tail:=1;
while head<=tail do
  begin
  p:=edge2[q[head]];
  while p<>0 do
    begin
    if (abs(g[p].c)<eps)and(h[g[p].v]=n) then
       begin
       h[g[p].v]:=h[q[head]]+1;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
fillchar(hash,sizeof(hash),0);
for i:=s to t do inc(hash[h[i]]);
while h[s]<n do
  begin
  sum:=sum+flow(s,inf);
  end;
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge2[x];
while p<>0 do
  begin
  if (g[p].c>0)and(vis[g[p].v]=0) then
     dfs(g[p].v);
  p:=g[p].nxt;
  end;
end;
begin
{assign(input,'d:\networkwars\networkwars.in');
reset(input);
assign(output,'d:\networkwars\networkwars.out');
rewrite(output);}
while not eof do
  begin
  init;
  readln(n,m);
  s:=1; t:=n;
  for i:=1 to m do
      begin
      readln(x,y,z);
      addedge(x,y,z);
      if z>max then max:=z;
      end;
  le:=1; ri:=max;
  if total=1 then writeln;
  while (ri-le>eps) do
    begin
    mid:=(le+ri)/2;
    sum:=0;
    tot2:=0;
    fillchar(flag,sizeof(flag),0);
    fillchar(edge2,sizeof(edge2),0);
    for i:=1 to tot do
        begin
        if 0-(tg[i].c-mid)>eps then
           begin
           if flag[(tg[i].op+1)div 2]=0 then
              begin
              sum:=sum+tg[i].c-mid;
              flag[(i+1)div 2]:=1;
              end;
           end
        else    
           addedge2(tg[i].u,tg[i].v,tg[i].c-mid);
        end;
    sap;
//  write(le:0:10,' ',mid:0:10,' ',ri:0:10,' ',sum:0:10);
//    if abs(sum)<eps then break;
    if 0-sum>eps then ri:=mid
       else le:=mid;
//  write(' ',abs(le-ri):0:10);
//    writeln;
    end;
//  writeln(mid:0:20);
  dfs(s);
  for i:=1 to tot do
      begin
      if (vis[tg[i].u]=1)and(vis[tg[i].v]=0) then
         flag[(i+1)div 2]:=1;
      end;
  for i:=1 to tot div 2 do
      if flag[i]=1 then
         begin
         inc(cnt);
         ans[cnt]:=i;
         end;
  writeln(cnt);
  for i:=1 to cnt-1 do write(ans[i],' ');
  write(ans[cnt]);
  total:=1;
  writeln;
  end;
{close(input);
close(output);}
end.
