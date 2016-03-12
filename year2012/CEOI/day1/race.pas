const maxn=511;
type rec=record v,nxt:longint; end;
var n,opt,i,v,ans,num,ret,p,tot:longint;
    edge:array[0..maxn]of longint;
    g:array[0..maxn*maxn]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure dfs(l1,r1,l2,r2,x,len:longint);
var p:longint;
begin
if len>ret then ret:=len;
p:=edge[x];
while p<>0 do
  begin
  if (l1<g[p].v)and(g[p].v<r1) then
     begin
     dfs(l1,g[p].v,g[p].v,r1,g[p].v,len+1);
     end
  else if (l1<g[p].v+n)and(g[p].v+n<r1) then
          begin
          dfs(l1,g[p].v+n,g[p].v+n,r1,g[p].v,len+1)
          end
       else if (l2<g[p].v)and(g[p].v<r2) then
               begin
               dfs(l2,g[p].v,g[p].v,r2,g[p].v,len+1)
               end
            else if (l2<g[p].v+n)and(g[p].v+n<r2) then
                    begin
                    dfs(l2,g[p].v+n,g[p].v+n,r2,g[p].v,len+1);
                    end;
  p:=g[p].nxt;
  end;
end;
begin
{assign(input,'race.in');
reset(input);
assign(output,'race.out');
rewrite(output);}
read(n,opt);
for i:=1 to n do
    begin
    read(v);
    while v<>0 do
      begin
      addedge(i,v);
      read(v);
      end;
    end;
ans:=0; num:=0;
for i:=1 to n do
    begin
    ret:=0;
    p:=edge[i];
    while p<>0 do
      begin
      if i<g[p].v then dfs(i,g[p].v,g[p].v,i+n,g[p].v,1)
         else dfs(i,g[p].v+n,g[p].v+n,i+n,g[p].v,1);
      p:=g[p].nxt;
      end;
    if ret>ans then begin ans:=ret; num:=i; end;
    end;
writeln(ans);
writeln(num);
{close(input);
close(output);}
end.