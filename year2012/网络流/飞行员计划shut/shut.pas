const maxn=100; inf=maxlongint;
type rec=record u,v,c,nxt,op:longint; end;
var n,m,sum,s,t,i,v,ch,j,x,p,ans,min,num,now,tot:longint;
    edge,hash,h,his,info,fa,vis,used,a,b:array[0..maxn]of longint;
    g:array[0..maxn*maxn]of rec;
    flag:boolean;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=z;
g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0;
g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if (g[p].c>0)and(vis[g[p].v]=0) then dfs(g[p].v);
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'shut.in');
reset(input);
assign(output,'shut.out');
rewrite(output);
readln(n,m);
sum:=0;
s:=0; t:=n+m+1;
for i:=1 to n do
    begin
    read(v);
    sum:=sum+v;
    addedge(s,i,v);
    while not eoln do
        begin
        read(x);
        addedge(i,n+x,inf);
        end;
    end;
for i:=1 to m do
    begin
    read(v);
    addedge(n+i,t,v);
    end;
ans:=0;
hash[0]:=n+m+2;
now:=inf;
info:=edge;
i:=s;
while h[s]<n+m+2 do
  begin
  his[i]:=now;
  flag:=false;
  p:=info[i];
  while p<>0 do
    begin
    x:=g[p].v;
    if (g[p].c>0)and(h[x]+1=h[i]) then
       begin
       flag:=true;
       if g[p].c<now then now:=g[p].c;
       fa[g[p].v]:=p;
       info[i]:=p;
       i:=g[p].v;
       if i=t then
          begin
          ans:=ans+now;
          while i<>s do
            begin
            dec(g[fa[i]].c,now);
            inc(g[g[fa[i]].op].c,now);
            i:=g[fa[i]].u;
            end;
          now:=inf;
          end;
       break;
       end;
    p:=g[p].nxt;
    end;
  if not flag then
     begin
     p:=edge[i];
     min:=inf;
     while p<>0 do
       begin
       if (g[p].c>0)and(h[g[p].v]<min) then
          begin
          num:=p;
          min:=h[g[p].v];
          end;
       p:=g[p].nxt;
       end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     info[i]:=num;
     inc(hash[h[i]]);
     if i<>s then begin i:=g[fa[i]].u; now:=his[i]; end;
     end;
  end;
dfs(s);
for i:=1 to n do used[i]:=1;
for i:=1 to tot do
    begin
    if (vis[g[i].u]=1)and(vis[g[i].v]=0) then
       begin
       if g[i].v=t then
          begin
          inc(b[0]);
          b[b[0]]:=g[i].u-n;
          end
       else
          begin
          used[g[i].v]:=0;
          end;
       end;
    end;
for i:=1 to n do if used[i]=1 then begin inc(a[0]); a[a[0]]:=i; end;
for i:=1 to a[0]-1 do write(a[i],' ');
write(a[a[0]],' ');
writeln;
for i:=1 to b[0]-1 do write(b[i],' ');
write(b[b[0]],' ');
writeln;
writeln(sum-ans);
close(input);
close(output);
end.
