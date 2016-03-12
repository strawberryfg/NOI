//20:06;
const maxn=10020; maxm=2000020; max=10000020; eps=1e-12;
type rec=record v,nxt:longint; end;
     htype=record ll,rr:longint; end;
var n,m,s,t,i,x,y,tot,top,cnt,tot2,total,pd,mem:longint;
    edge,edge2,deg,vis,vis2,col,map,q,bel,stack,done:array[0..maxn]of longint;
    h:array[0..maxn]of htype;
    f:array[0..maxn]of extended;
    mat:array[0..max]of extended;
    g,tg:array[0..maxm]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; inc(deg[x]);
end;
procedure addedgeopp(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure dfss(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if vis[g[p].v]=0 then dfss(g[p].v);
  p:=g[p].nxt;
  end;
end;
procedure dfst(x:longint);
var p:longint;
begin
vis2[x]:=1;
p:=edge2[x];
while p<>0 do
  begin
  if vis2[tg[p].v]=0 then dfst(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure dfs(x:longint);
var p:longint;
begin
map[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if map[g[p].v]=0 then dfs(g[p].v);
  p:=g[p].nxt;
  end;
inc(top); stack[top]:=x;
end;
procedure dfs2(x:longint);
var p:longint;
begin
col[x]:=cnt; inc(total); q[total]:=x;
if h[cnt].ll=0 then h[cnt].ll:=total;
h[cnt].rr:=total;
p:=edge2[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure work(x:longint);     // x: component;
var all,i,left,p,xx,yy,tmp,xx1,yy1,tmp1,xx2,yy2,tmp2,tx,ty,sta,j,k,num,opt,l1,l2:longint;
    que,match:array[0..111]of longint;
    res:array[0..111]of extended;
    swap,rate,sum:extended;
begin
done[x]:=1;
all:=0;
for i:=h[x].ll to h[x].rr do
    begin
    inc(all);
    que[all]:=q[i]; bel[q[i]]:=all;
    end;
inc(mem); left:=mem;
mem:=mem+all*all-1;
for i:=1 to all do res[i]:=0.0;
for i:=1 to all do
    begin
    if que[i]=t then continue;
    res[i]:=1.0;
    p:=edge[que[i]];
    xx:=i; yy:=i; tmp:=(xx-1)*all+yy+left-1; mat[tmp]:=1.0;
    while p<>0 do
      begin
      if col[g[p].v]<>x then
         begin
         if done[col[g[p].v]]=0 then work(col[g[p].v]);
         res[i]:=res[i]+f[g[p].v]/deg[que[i]];
         end
      else if g[p].v<>t then
              begin
              xx:=i; yy:=bel[g[p].v]; tmp:=(xx-1)*all+yy+left-1; mat[tmp]:=mat[tmp]-1/deg[que[i]];
              end;
      p:=g[p].nxt;
      end;
    end;
for i:=1 to all do match[i]:=-1;
i:=1; j:=1;
while (i<=all)and(j<=all) do
  begin
  xx:=i; yy:=j; num:=(xx-1)*all+yy+left-1; opt:=i;
  for k:=i+1 to all do
      begin
      xx:=k; yy:=j; tmp:=(xx-1)*all+yy+left-1;
      if abs(mat[tmp])>abs(mat[num]) then begin num:=tmp; opt:=k; end;
      end;
  if abs(mat[num])>eps then
     begin
     match[i]:=j;
     if opt<>i then
        begin
        l1:=(i-1)*all+left; l2:=(opt-1)*all+left;
        for k:=1 to all do
            begin
            swap:=mat[l1+k-1]; mat[l1+k-1]:=mat[l2+k-1]; mat[l2+k-1]:=swap;
            end;
        swap:=res[i]; res[i]:=res[opt]; res[opt]:=swap;
        end;
     for k:=i+1 to all do
         begin
         xx2:=k; yy2:=j; tmp2:=(xx2-1)*all+yy2+left-1;
         xx1:=i; yy1:=j; tmp1:=(xx1-1)*all+yy1+left-1;
         rate:=mat[tmp2]/mat[tmp1];
         if abs(rate)<eps then continue;
         for p:=j to all do
             begin
             xx:=k; yy:=p; tmp:=(xx-1)*all+yy+left-1;
             tx:=i; ty:=p; sta:=(tx-1)*all+ty+left-1;
             mat[tmp]:=mat[tmp]-rate*mat[sta];
             end;
         res[k]:=res[k]-rate*res[i];
         end;
     inc(i);
     end;
  inc(j);
  end;
for i:=all downto 1 do
    begin
    if match[i]=-1 then continue;
    sum:=0;
    for j:=match[i]+1 to all do
        begin
        xx:=i; yy:=j; tmp:=(xx-1)*all+yy+left-1;
        sum:=sum+f[que[j]]*mat[tmp];
        end;
    sum:=res[i]-sum;
    xx:=i; yy:=match[i]; tmp:=(xx-1)*all+yy+left-1;
    f[que[match[i]]]:=sum/mat[tmp];
    end;
end;
begin
assign(input,'labyrinth.in');
reset(input);
assign(output,'labyrinth.out');
rewrite(output);
readln(n,m,s,t);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y);
    addedgeopp(y,x);
    end;
fillchar(vis,sizeof(vis),0);
fillchar(vis2,sizeof(vis2),0);
dfss(s);
dfst(t);
pd:=0;
for i:=1 to n do if (vis[i]=1)and(vis2[i]=0) then begin pd:=1; break; end;
if pd=1 then writeln('INF')
   else begin
        fillchar(map,sizeof(map),0);
        top:=0;
        for i:=1 to n do
            begin
            if vis[i]=0 then continue;
            if map[i]=0 then dfs(i);
            end;
        cnt:=0;
        for i:=top downto 1 do
            begin
            if col[stack[i]]=0 then
               begin
               inc(cnt);
               dfs2(stack[i]);
               end;
            end;
        fillchar(done,sizeof(done),0);
        fillchar(mat,sizeof(mat),0);
        fillchar(f,sizeof(f),0);
        mem:=0;
        work(col[s]);
        writeln(round(f[s]*1000)/1000:0:3);
        end;
close(input);
close(output);
end.