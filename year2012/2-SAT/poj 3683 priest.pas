const maxn=2020; maxm=2500020;
type newtype=record ll,rr:longint; end;
     rec=record v,nxt:longint; end;
var n,i,t,x,y,tot,tot2,top,cnt,pd,mark,j,head,tail,p,now,hour,minute,total,tme:longint;
    opp,edge,edge2,col,stack,deg,sta,b,flag,q,ret:array[0..maxn]of longint;
    hash:array[0..maxn,0..maxn]of byte;
    vis:array[0..maxn]of boolean;
    a,node:array[0..maxn]of newtype;
    g,tg,h:array[0..maxm]of rec;
    xx,yy,ts,s:string;
    code:integer;
procedure addedge2(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
addedge2(y,x);
end;
procedure addedgescc(x,y:longint);
begin
inc(total); h[total].v:=y; h[total].nxt:=sta[x]; sta[x]:=total; inc(deg[y]);
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=true;
p:=edge[x];
while p<>0 do
  begin
  if not vis[g[p].v] then dfs(g[p].v);
  p:=g[p].nxt;
  end;
inc(top); stack[top]:=x;
end;
procedure dfs2(x:longint);
var p:longint;
begin
inc(now); b[now]:=x;
if node[cnt].ll=0 then node[cnt].ll:=now;
col[x]:=cnt;
p:=edge2[x];
while p<>0 do
  begin
  if col[tg[p].v]=0 then dfs2(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
procedure work(x:longint);
var p:longint;
begin
if flag[x]=1 then exit;
flag[x]:=1;
p:=sta[x];
while p<>0 do
   begin
   work(h[p].v);
   p:=h[p].nxt;
   end;
end;
begin
{assign(input,'priest.in');
reset(input);
assign(output,'priest.out');
rewrite(output);}
readln(n);
pd:=1; tot:=0; tot2:=0;
for i:=1 to n do
    begin
    readln(s);
    t:=pos(' ',s); xx:=copy(s,1,t-1); delete(s,1,t);
    t:=pos(' ',s); yy:=copy(s,1,t-1); delete(s,1,t);
    val(s,tme,code);
    t:=pos(':',xx); ts:=copy(xx,1,t-1); val(ts,hour,code); delete(xx,1,t);
    val(xx,minute,code); x:=hour*60+minute;
    t:=pos(':',yy); ts:=copy(yy,1,t-1); val(ts,hour,code); delete(yy,1,t);
    val(yy,minute,code); y:=hour*60+minute;
    if y-x<tme then begin pd:=0; break; end;
    a[i].ll:=x; a[i].rr:=x+tme;
    a[i+n].ll:=y-tme; a[i+n].rr:=y;
    end;
for i:=1 to n do begin opp[i]:=i+n; opp[i+n]:=i; end;
for i:=1 to 2*n do
    for j:=1 to 2*n do
        begin
        if (i=j)or(j=i+n)or(i=j+n) then continue;
        if hash[i][j]=1 then continue;
        mark:=1;
        if a[j].ll>=a[i].rr then mark:=0;
        if a[j].rr<=a[i].ll then mark:=0;
        if mark=1 then begin addedge(i,opp[j]); addedge(j,opp[i]); end;
        hash[i][j]:=1; hash[j][i]:=1;
        end;
top:=0;
for i:=1 to 2*n do if not vis[i] then dfs(i);
now:=0; cnt:=0;
for i:=top downto 1 do if col[stack[i]]=0 then begin inc(cnt); dfs2(stack[i]); node[cnt].rr:=now; end;
for i:=1 to n do if col[i]=col[i+n] then begin pd:=0; break; end;
if pd=0 then writeln('NO')
   else begin
        writeln('YES');
        for i:=1 to 2*n do
            begin
            p:=edge[i];
            while p<>0 do
              begin
              if col[i]<>col[g[p].v] then addedgescc(col[g[p].v],col[i]);
              p:=g[p].nxt;
              end;
            end;
        head:=1; tail:=0;
        for i:=1 to cnt do if deg[i]=0 then begin inc(tail); q[tail]:=i; end;
        while head<=tail do
          begin
          p:=sta[q[head]];
          while p<>0 do
            begin
            dec(deg[h[p].v]);
            if deg[h[p].v]=0 then begin inc(tail); q[tail]:=h[p].v; end;
            p:=h[p].nxt;
            end;
          inc(head);
          end;
        for i:=1 to tail do
            begin
            if flag[q[i]]=1 then continue;
            flag[q[i]]:=2;
            for j:=node[q[i]].ll to node[q[i]].rr do work(col[opp[b[j]]]);
            end;
        for i:=1 to cnt do if flag[i]=2 then for j:=node[i].ll to node[i].rr do if b[j]>n then ret[b[j]-n]:=b[j] else ret[b[j]]:=b[j];
        for i:=1 to n do
            begin
            x:=a[ret[i]].ll; y:=a[ret[i]].rr;
            t:=x div 60; if t<10 then write('0'); write(t,':');
            t:=x mod 60; if t<10 then write('0'); write(t,' ');
            t:=y div 60; if t<10 then write('0'); write(t,':');
            t:=y mod 60; if t<10 then write('0'); write(t);
            writeln;
            end;
        end;
{close(input);
close(output);}
end.