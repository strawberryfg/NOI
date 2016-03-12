//{$inline on}
//{$optimization on}
const maxn=303; maxm=186666; eps=1e-4; eps2=1e-6; inf=1e20;
type rec=record v,nxt:longint; w:extended; end;
     rec2=record v,nxt,op:longint; c:extended; end;
var n,m,i,p,x,y,tot,cnt,top,tme,tot2,savetot2,s,t:longint;
    le,ri,mid,ans,res,u,ans2:extended;
    edge,edge2,saveedge2,low,dfn,stack,col,h,hash,q:array[0..maxn]of longint;
    a,sum:array[0..maxn]of extended;
    deg:array[0..maxn]of extended;
    instack:array[0..maxn]of boolean;
    g:array[0..maxm]of rec;
    tg,savetg:array[0..maxm*2]of rec2;
    vis2,b:array[0..maxn]of longint;
function min(x,y:extended):extended;
begin
if y-x>eps2 then exit(x) else exit(y);
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure addedge2(x,y:longint;z:extended);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].c:=z; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2; tg[tot2].op:=tot2+1;
inc(tot2); tg[tot2].v:=x; tg[tot2].c:=0; tg[tot2].nxt:=edge2[y]; edge2[y]:=tot2; tg[tot2].op:=tot2-1;
end;
procedure tarjan(x:longint);
var p:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme; inc(top); stack[top]:=x; instack[x]:=true;
p:=edge[x];
if x=61 then
   p:=p;
if x=70 then
   p:=p;
if x=63 then
   p:=p;
while p<>0 do
  begin
  if g[p].v<>x then
     begin
     if dfn[g[p].v]=0 then
        begin
        if g[p].v=51 then
           top:=top;
        tarjan(g[p].v);
        if low[g[p].v]<low[x] then low[x]:=low[g[p].v];
        end
     else if (instack[g[p].v])and(dfn[g[p].v]<low[x]) then low[x]:=dfn[g[p].v];
     end;
  p:=g[p].nxt;
  end;
if low[x]=dfn[x] then
   begin
   inc(cnt);
   while stack[top+1]<>x do
     begin
     if stack[top]=51 then
        top:=top;
     stack[top+1]:=0;
     instack[stack[top]]:=false;
     col[stack[top]]:=cnt;
     sum[cnt]:=sum[cnt]+a[stack[top]];
     dec(top);
     end;
   end;
end;
function flow(x:longint; now:extended):extended;
var tmp,ret:extended; p,mmin:longint;
begin
if x=t then exit(now);
tmp:=0;
p:=edge2[x];
while p<>0 do
  begin
  if (tg[p].c>0)and(h[tg[p].v]+1=h[x]) then
     begin
     ret:=flow(tg[p].v,min(tg[p].c,now));
     now:=now-ret; tmp:=tmp+ret;
     tg[p].c:=tg[p].c-ret; tg[tg[p].op].c:=tg[tg[p].op].c+ret;
     if h[s]=t+1 then exit(tmp);
     if now=0 then break;
     end;
  p:=tg[p].nxt;
  end;
if tmp=0 then
   begin
   dec(hash[h[x]]);
   if hash[h[x]]=0 then h[s]:=t+1
      else begin
           p:=edge2[x]; mmin:=t;
           while p<>0 do
             begin
             if (tg[p].c>0)and(h[tg[p].v]<mmin) then mmin:=h[tg[p].v];
             p:=tg[p].nxt;
             end;
           h[x]:=mmin+1;
           inc(hash[h[x]]);
           end;
   end;
exit(tmp);
end;
procedure dfss(x:longint);
var p:longint;
begin
vis2[x]:=1;
if x<>s then begin inc(b[0]); b[b[0]]:=x; end;
p:=edge2[x];
while p<>0 do
  begin
  if (tg[p].c>0)and(vis2[tg[p].v]=0) then dfss(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
function check(x:extended):extended;
var i,head,tail,p:longint; ans,suma:extended;
begin
tot2:=savetot2; edge2:=saveedge2;
for i:=1 to tot2 do tg[i].c:=savetg[i].c;
//tg:=savetg;
for i:=1 to n do
    begin
    addedge2(s,i,u);
    addedge2(i,t,u+x-deg[i]);
    end;
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=t+1;
head:=1; tail:=1; q[1]:=t; h[t]:=0;
while head<=tail do
  begin
  p:=edge2[q[head]];
  while p<>0 do
    begin
    if (tg[p].c=0)and(h[tg[p].v]=t+1) then
       begin
       inc(tail); q[tail]:=tg[p].v;
       h[tg[p].v]:=h[q[head]]+1;
       end;
    p:=tg[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ans:=0;
while h[s]<t+1 do ans:=ans+flow(s,inf);
fillchar(vis2,sizeof(vis2),0);
b[0]:=0;
dfss(s);
if b[0]<>0 then
   begin
   suma:=0;
   for i:=1 to b[0] do
       begin
       p:=edge[b[i]];
       while p<>0 do
         begin
         if (vis2[g[p].v]=1) then suma:=suma+g[p].w;
         p:=g[p].nxt;
         end;
       end;
   if suma/b[0]-ans2>eps then ans2:=suma/b[0];
   end;
check:=(u*n-ans);
end;
begin
assign(input,'c.in');
reset(input);
assign(output,'c.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    read(a[i]);
tot:=0;
for i:=1 to m do
    begin
    read(x,y);
    addedge(x,y);
    end;
fillchar(instack,sizeof(instack),false);
top:=0; tme:=0; cnt:=0;
for i:=1 to n do if dfn[i]=0 then tarjan(i);
u:=0;
for i:=1 to n do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      if col[i]=col[g[p].v] then g[p].w:=g[p].w+sum[col[i]];
      p:=g[p].nxt;
      end;
    end;
u:=0.0;
for i:=1 to n do
    begin
    deg[i]:=0;
    p:=edge[i];
    while p<>0 do
      begin
      deg[i]:=deg[i]+g[p].w;
      if abs(g[p].w-3089)<eps then
         ans:=ans;
      p:=g[p].nxt;
      end;
    u:=u+deg[i];
    end;
for i:=1 to n do
    begin
    p:=edge[i];
    while p<>0 do
      begin
      addedge2(i,g[p].v,g[p].w);
      p:=g[p].nxt;
      end;
    end;
s:=0; t:=n+1;
saveedge2:=edge2; savetg:=tg; savetot2:=tot2;
u:=u+100;
le:=0.0;  ri:=u;  ans:=0.0; ans2:=0.0;
while ri-le>eps do
  begin
  mid:=(le+ri)/2;
  res:=check(mid);
  if (res>eps2) then begin ans:=mid; le:=mid; end
     else ri:=mid;
  end;
writeln(round(ans*100)/100:0:2);
//writeln(round(ans2*100)/100:0:2);
close(input);
close(output);
end.