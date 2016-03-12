const maxn=25; maxm=200; maxq=5000000; inf=maxlongint;
type rec=record v,w,nxt:longint; end;
var test,now,i,n,le,ri,mid,ans,savetot,tot,tme:longint;
    edge,saveedge,dis,cnt,r,hash:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    g,saveg:array[0..maxm]of rec;
procedure init;
begin
tot:=0;
fillchar(cnt,sizeof(cnt),0);
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function check(x:longint):boolean;
var i,p,head,tail:longint;
begin
edge:=saveedge; tot:=savetot; g:=saveg;
fillchar(hash,sizeof(hash),0);
for i:=1 to 8 do addedge(i,i+16,-r[i-1]+x);  // x= s[23];
addedge(24,0,-x);
addedge(0,24,x);
for i:=0 to 24 do dis[i]:=inf;
fillchar(mark,sizeof(mark),false);
mark[0]:=true; q[1]:=0; head:=1; tail:=1;
for i:=1 to 24 do dis[i]:=inf;
dis[0]:=0; hash[0]:=1;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if dis[q[head]]+g[p].w<dis[g[p].v] then
       begin
       dis[g[p].v]:=dis[q[head]]+g[p].w;
       if not mark[g[p].v] then
          begin
          inc(hash[g[p].v]);
          if hash[g[p].v]>24 then
             exit(false);
          mark[g[p].v]:=true;
          inc(tail);
          q[tail]:=g[p].v;
          end
       end;
    p:=g[p].nxt;
    end;
  mark[q[head]]:=false;
  inc(head);
  end;
for i:=0 to 23 do if dis[i]=inf then exit(false);
exit(true);
end;
begin
{assign(input,'cashier.in');
reset(input);
assign(output,'e:\wqf2\cashier.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    init;
    for i:=0 to 23 do read(r[i]);
    readln(n);
    for i:=1 to n do
        begin
        readln(tme);
        inc(cnt[tme]);
        end;
    for i:=1 to 24 do begin addedge(i,i-1,0); addedge(i-1,i,cnt[i-1]); end;
    for i:=9 to 24 do addedge(i,i-8,-r[i-1]);
    saveedge:=edge; savetot:=tot; saveg:=g;
    le:=0; ri:=n; ans:=-1;
    while le<=ri do
      begin
      mid:=(le+ri) div 2;
      if check(mid) then begin ans:=mid; ri:=mid-1; end
         else le:=mid+1;
      end;
    if ans=-1 then writeln('No Solution')
       else writeln(ans);
    end;
{close(input);
close(output);}
end.