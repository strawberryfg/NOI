const maxn=1020; maxm=4020; maxq=1000020; maxquery=2020; inf=maxlongint;
type querytype=record ll,rr,c:longint; end;
     rec=record u,v,w,nxt:longint; end;
var n,k,m,i,j,sum,sum2,pd,le,ri,mid,ans1,ans2,tot,num:longint;
    flag,flag2,a,ta,ans,edge,dis,hash:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    que,opt:array[0..maxquery]of querytype;
    g:array[0..maxm]of rec;
    found:boolean;
procedure init;
begin
fillchar(edge,sizeof(edge),0);
tot:=0;
end;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].w:=z;
end;
function spfa:boolean;
var i,head,tail,p:longint;
begin
for i:=0 to sum2 do dis[i]:=inf;
dis[0]:=0;
fillchar(mark,sizeof(mark),false);
mark[0]:=true;
head:=1; tail:=1; q[1]:=0;
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
          mark[g[p].v]:=true;
          inc(tail);
          inc(hash[g[p].v]);
          if hash[g[p].v]>sum2 then exit(false);
          q[tail]:=g[p].v;
          end;
       end;
    p:=g[p].nxt;
    end;
  mark[q[head]]:=false;
  inc(head);
  end;
for i:=0 to sum2 do if dis[i]=inf then exit(false);
exit(true);
end;
begin
assign(input,'guard.in');
reset(input);
assign(output,'guard.out');
rewrite(output);
readln(n,k,m);
for i:=1 to m do
    begin
    readln(que[i].ll,que[i].rr,que[i].c);
    if que[i].c=0 then for j:=que[i].ll to que[i].rr do flag[j]:=-1;
    end;
sum:=0;
for i:=1 to n do if flag[i]<>-1 then begin inc(sum); a[sum]:=i; end;
for i:=1 to m do
    begin
    le:=1; ri:=sum; ans1:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if a[mid]>=que[i].ll then begin ans1:=mid; ri:=mid-1; end
         else le:=mid+1;
      end;
    le:=1; ri:=sum; ans2:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if a[mid]<=que[i].rr then begin ans2:=mid; le:=mid+1; end
         else ri:=mid-1;
      end;
    if ans1=ans2 then begin flag2[a[ans1]]:=-1; ans[a[ans1]]:=1; end;
    end;
for i:=1 to sum do
    begin
    if flag2[a[i]]=-1 then continue;
    sum2:=0;
    for j:=1 to sum do if i<>j then begin inc(sum2); ta[sum2]:=a[j]; end;
    init;
    found:=true;
    for j:=1 to m do
        begin
        if que[j].c=0 then continue;
        le:=1; ri:=sum2; ans1:=-1;
        while le<=ri do
          begin
          mid:=(le+ri) div 2;
          if ta[mid]>=que[j].ll then begin ans1:=mid; ri:=mid-1; end
             else le:=mid+1;
          end;
        le:=1; ri:=sum2; ans2:=-1;
        while le<=ri do
          begin
          mid:=(le+ri) div 2;
          if ta[mid]<=que[j].rr then begin ans2:=mid; le:=mid+1; end
             else ri:=mid-1;
          end;
        if (ans1=-1)or(ans2=-1)or(ans1>ans2) then
           begin
           found:=false;
           break;
           end;
        addedge(ans2,ans1-1,-1);
        addedge(ans1-1,ans2,ans2-ans1+1);
        opt[j].ll:=ans1; opt[j].rr:=ans2;
        end;
    if not found then continue;
    for j:=1 to sum2 do
        begin
        if flag2[ta[j]]=-1 then continue;
        addedge(j,j-1,0);
        addedge(j-1,j,1);
        end;
    addedge(0,sum2,k);
    addedge(sum2,0,-k);
    fillchar(hash,sizeof(hash),0);
    num:=i;
    if not spfa then ans[a[i]]:=1;
    end;
pd:=0;
for i:=1 to n do if ans[i]=1 then begin pd:=1; writeln(i); end;
if pd=0 then writeln(-1);
close(input);
close(output);
end.