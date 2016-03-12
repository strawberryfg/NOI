const maxn=300; maxm=40020; inf=maxlongint; domax=1000000;
type rec=record u,v,c,nxt,op:longint; end;
     readtype=record ll,rr,u,v:longint; end;
var n,m,s,t,i,flag,tot,lasttot,efirst,elast,le,ri,mid,fans:longint;
    ans:longint;
    edge,tedge,h,hash,q,inner,outer:array[0..maxn]of longint;
    g,tg:array[0..maxm]of rec;
    a:array[0..maxm]of readtype;
    sta,final:array[0..maxm]of longint;
function min(x,y:longint):longint;
begin
if x<y then min:=x else min:=y;
end;
procedure addedge(x,y,z,opt:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
if opt=1 then sta[i]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function flow(x,now:longint):longint;
var p,mmin:longint;
    res,tmp:longint;
begin
if x=t then begin flow:=now; exit; end;
tmp:=0;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(h[g[p].v]+1=h[x]) then
     begin
     res:=flow(g[p].v,min(g[p].c,now));
     g[p].c:=g[p].c-res; g[g[p].op].c:=g[g[p].op].c+res;
     now:=now-res; tmp:=tmp+res;
     if h[s]=t+1 then begin flow:=tmp; exit; end;
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
           mmin:=t;
           while p<>0 do
             begin
             if (g[p].c>0)and(h[g[p].v]<mmin) then
                mmin:=h[g[p].v];
             p:=g[p].nxt;
             end;
           h[x]:=mmin+1;
           inc(hash[h[x]]);
           end;
   end;
flow:=tmp;
end;
procedure sap;
var i,head,tail,p:longint;
begin
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=t+1;
h[t]:=0;
q[1]:=t; head:=1; tail:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=t+1) then
       begin
       h[g[p].v]:=h[q[head]]+1;;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
ans:=0;
while h[s]<t+1 do ans:=ans+flow(s,inf);
end;
procedure work;
var i,p:longint;
begin
flag:=1;
p:=edge[s];
while p<>0 do
  begin
  if g[p].c>0 then begin flag:=0; exit; end;
  p:=g[p].nxt;
  end;
end;
begin
{assign(input,'flow.in');
reset(input);
assign(output,'flow.out');
rewrite(output);}
readln(n,m);
s:=0; t:=n+1;
for i:=1 to m do
    begin
    readln(a[i].u,a[i].v,a[i].ll,a[i].rr);
    if a[i].rr=1 then a[i].rr:=a[i].ll
       else begin a[i].rr:=a[i].ll; a[i].ll:=0; end;
    inc(inner[a[i].v],a[i].ll);
    inc(outer[a[i].u],a[i].ll);
    end;
for i:=1 to n do
    begin
    if inner[i]-outer[i]>0 then addedge(s,i,inner[i]-outer[i],1);
    if inner[i]-outer[i]<0 then addedge(i,t,outer[i]-inner[i],1);
    end;
for i:=1 to m do
    addedge(a[i].u,a[i].v,a[i].rr-a[i].ll,1);
le:=0; ri:=domax; fans:=-1;
tg:=g; tedge:=edge;
lasttot:=tot;
while le<=ri do
  begin
  mid:=(le+ri)div 2;
  tot:=lasttot;
  for i:=1 to tot do g[i].c:=tg[i].c;
  edge[1]:=tedge[1]; edge[n]:=tedge[n];
  addedge(n,1,mid,2);
  sap;
  work;
  if flag=1 then begin fans:=mid; ri:=mid-1; end
     else le:=mid+1;
  end;
if fans=-1 then writeln('Impossible')
   else begin
        writeln(fans);
        tot:=lasttot;
        for i:=1 to tot do g[i].c:=tg[i].c;
        edge[1]:=tedge[1]; edge[n]:=tedge[n];
        addedge(n,1,fans,2);
        sap;
        work;
        for i:=1 to m-1 do write(a[i].rr-g[sta[i]].c,' ');
        write(a[m].rr-g[sta[m]].c);
        writeln;
        end;
{close(input);
close(output);}
end.
