//20:17;
const maxn=7020; maxm=30020; inf=maxlongint; inf2=100000;
type rec=record v,nxt,c,op:longint; end;
var n,i,j,s,t,le,ri,mid,ans,tot,savetot:longint;
    edge,saveedge,inner,outer,h,hash:array[0..maxn]of longint;
    q:array[0..10*maxn]of longint;
    map:array[0..maxn,0..maxn]of longint;
    g,saveg:array[0..maxm]of rec;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].v:=y; g[tot].c:=z; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].v:=x; g[tot].c:=0; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
function flow(x,now:longint):longint;
var tmp,p,res,mmin:longint;
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
function sap:boolean;
var i,p,head,tail,res:longint;
begin
fillchar(hash,sizeof(hash),0);
for i:=s to t do h[i]:=t+1;
q[1]:=t; h[t]:=0; head:=1; tail:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (g[p].c=0)and(h[g[p].v]=t+1) then
       begin
       inc(tail); q[tail]:=g[p].v;
       h[g[p].v]:=h[q[head]]+1;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
for i:=s to t do inc(hash[h[i]]);
res:=0;
while h[s]<t+1 do res:=res+flow(s,inf);
p:=edge[s];
while p<>0 do
  begin
  if g[p].c>0 then
     exit(false);
  p:=g[p].nxt;
  end;
exit(true);
end;
begin
assign(input,'nar.in');
reset(input);
assign(output,'nar.out');
rewrite(output);
readln(n);
for i:=1 to n-1 do
    begin
    read(map[i][0]);
    for j:=1 to map[i][0] do
        begin
        read(map[i][j]);
        inc(inner[map[i][j]]);
        inc(outer[i]);
        end;
    end;
s:=0; t:=n+1;
for i:=1 to n do if outer[i]>inner[i] then addedge(i,t,outer[i]-inner[i]) else if inner[i]>outer[i] then addedge(s,i,inner[i]-outer[i]);
for i:=1 to n-1 do
    for j:=1 to map[i][0] do
        addedge(i,map[i][j],inf-1);
savetot:=tot; saveedge:=edge; saveg:=g;
le:=1; ri:=inf2; ans:=-1;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  tot:=savetot; edge:=saveedge; g:=saveg;
  addedge(n,1,mid);
  if sap then begin ans:=mid; ri:=mid-1; end
     else le:=mid+1;
  end;
writeln(ans);
close(input);
close(output);
end.