const base=1000000000;
      maxn=10020;
      maxm=200020;
type node=record first,last:longint; end;
     edgenode=record v,nxt:longint; end;
var n,m,i,x,y,t,p,num,tot,tot2:longint;
    edge,edge2:array[0..maxn]of node;
    g,h:array[0..maxm]of edgenode;
    vis,vis2:array[0..maxn]of boolean;
    col,cnt,a,inner:array[0..maxn]of longint;
    pd,flag:boolean;
    s:string;
procedure addedge(x,y:longint);
begin
inc(inner[y]);
inc(tot); g[tot].v:=y;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;
edge[x].last:=tot;
end;
procedure addedge2(x,y:longint);
begin
inc(tot2); h[tot].v:=y;
if edge2[x].first=0 then edge2[x].first:=tot
   else h[edge2[x].last].nxt:=tot;
edge2[x].last:=tot2;
end;
procedure dfs(x:longint);
var t,p:longint;
begin
vis[x]:=true;
t:=edge[x].first;
while t<>0 do
  begin
  p:=g[t].v;
  if not vis[p] then dfs(p);
  t:=g[t].nxt;
  end;
end;
procedure dfs2(x:longint);
var t,p:longint;
begin
vis2[x]:=true;
t:=edge2[x].first;
while t<>0 do
  begin
  p:=h[t].v;
  if not vis2[p] then dfs2(p);
  t:=h[t].nxt;
  end;
end;
procedure topsort(x:longint);
var t,p:longint;
begin
col[x]:=1;
t:=edge[x].first;
while t<>0 do
  begin
  p:=g[t].v;
  if (vis[p])and(vis2[p]) then
     begin
     if col[p]=1 then
        begin
        pd:=false;
        exit;
        end
     else if col[p]=0 then
             begin
             topsort(p);
             if not pd then exit;
             end;
     end;
  t:=g[t].nxt;
  end;
col[x]:=2;
inc(num);
a[num]:=x;
end;
begin
assign(input,'bicikli.in');
reset(input);
assign(output,'bicikli.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y);
    addedge2(y,x);
    end;
dfs(1);
dfs2(2);
pd:=true;
topsort(1);
if not pd then writeln('inf')
   else begin
        cnt[1]:=1;
        flag:=false;
        for i:=num downto 1 do
            begin
            t:=edge[a[i]].first;
            while t<>0 do
              begin
              p:=g[t].v;
              if (vis[p])and(vis2[p]) then
                 begin
                 if cnt[p]+cnt[a[i]]>=base then flag:=true;
                 cnt[p]:=(cnt[p]+cnt[a[i]])mod base;
                 end;
              t:=g[t].nxt;
              end;
            end;
        if not flag then writeln(cnt[2])
           else begin
                str(cnt[2],s);
                for i:=1 to 9-length(s) do write('0');
                write(s);
                writeln;
                end;
        end;
close(input);
close(output);
end.