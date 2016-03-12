const maxn=700; maxm=1420; maxn1=30020; maxnode=10000020;
type rec=record u,v,nxt:longint; end;
     newtype=record l,r:longint; end;
var m,n,i,j,x,y,top,tot,total,cnt,num,tme,sum,u:longint;
    edge,bel,hash,vertex,low,dfn,stack:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    h:array[0..maxnode]of longint;
    edg:array[0..maxn1]of newtype;
    tmp,ans:qword;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure init;
begin
n:=0;
tot:=0;
total:=0;
//fillchar(vertex,sizeof(vertex),0);
fillchar(dfn,sizeof(dfn),0);
fillchar(low,sizeof(low),0);
fillchar(bel,sizeof(bel),0);
fillchar(edge,sizeof(edge),0);
fillchar(hash,sizeof(hash),0);
fillchar(g,sizeof(g),0);
//fillchar(h,sizeof(h),0);
fillchar(edg,sizeof(edg),0);
top:=0;
cnt:=0;
fillchar(stack,sizeof(stack),0);
end;
procedure tarjan(x,fa:longint);
var p,sum:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme;
inc(top); stack[top]:=x;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa)and(dfn[g[p].v]<dfn[x]) then
     begin
     if dfn[g[p].v]=0 then
        begin
        tarjan(g[p].v,x);
        low[x]:=min(low[x],low[g[p].v]);
        if low[g[p].v]>=dfn[x] then
           begin
           inc(cnt);
           sum:=0;
           while stack[top+1]<>g[p].v do
             begin
             inc(bel[stack[top]]);
             inc(sum);
             inc(total); h[total]:=stack[top];
             if sum=1 then edg[cnt].l:=total;
             dec(top);
             end;
           inc(bel[x]);
           inc(sum);
           inc(total); h[total]:=x;
           edg[cnt].r:=total;
           end;
        end
     else
        low[x]:=min(low[x],dfn[g[p].v]);
     end;
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'mining.in');
reset(input);
assign(output,'mining.out');
rewrite(output);
readln(m);
u:=0;
while m<>0 do
  begin
  inc(u);
  init;
  for i:=1 to m do
      begin
      readln(x,y);
      if hash[x]=0 then begin inc(n); vertex[n]:=x; hash[x]:=n; end;
      if hash[y]=0 then begin inc(n); vertex[n]:=y; hash[y]:=n; end;
      hash[x]:=x; hash[y]:=y;
      addedge(hash[x],hash[y]);
      addedge(hash[y],hash[x]);
      end;
  for i:=1 to n do
      if dfn[i]=0 then
         tarjan(i,0);
{  for i:=1 to cnt do
      writeln(i,' ',edg[i].l,' ',edg[i].r);
  for i:=1 to total do
      write(h[i],' ');
  writeln;
  for i:=1 to n do
      write(bel[i],' ');
  writeln;}
  num:=0; ans:=1;
  for i:=1 to cnt do
      begin
      sum:=0;
      for j:=edg[i].l to edg[i].r do
          begin
          if bel[h[j]]>1 then
             begin
             inc(sum);
             if sum>2 then break;
             end;
          end;
      tmp:=edg[i].r-edg[i].l+1;
      if sum=0 then begin inc(num,2); ans:=ans*qword(tmp)*qword(tmp-1) div 2; end
         else if sum=1 then begin inc(num); ans:=ans*qword(tmp-1); end;
      end;
  writeln('Case ',u,': ',num,' ',ans);
  readln(m);
  end;
close(input);
close(output);
end.
