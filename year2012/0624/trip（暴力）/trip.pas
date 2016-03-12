//17:06; 17:42;
const maxn=30020; maxm=200020; maxque=200020;
type quetype=record opt,u,v:longint; end;
     rec=record v,nxt:longint; end;
var n,m,i,t,tot,cnt,x,t1,t2,anc,ans:longint;
    dep,edge,from,root,a:array[0..maxn]of longint;
    f:array[0..maxn,0..16]of longint;
    g:array[0..maxm]of rec;
    que:array[0..maxque]of quetype;
    s,ts:string;
    code:integer;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getfa(x:longint):longint;
begin
if from[x]<>x then from[x]:=getfa(from[x]);
exit(from[x]);
end;
function work(x,step:longint):longint;
var now:longint;
begin
now:=-1;
while step>0 do
  begin
  inc(now);
  if step mod 2=1 then x:=f[x][now];
  step:=step div 2;
  end;
work:=x;
end;
function lca(x,y:longint):longint;
var i:longint;
begin
if dep[x]<dep[y] then begin x:=x+y; y:=x-y; x:=x-y; end;
x:=work(x,dep[x]-dep[y]);
if x=y then exit(x);
for i:=16 downto 0 do
    if f[x][i]<>f[y][i] then
       begin
       x:=f[x][i]; y:=f[y][i];
       end;
exit(f[x][0]);
end;
procedure dfs(x,fa,d:longint);
var p,i:longint;
begin
dep[x]:=d;
root[x]:=cnt;
f[x][0]:=fa;
for i:=1 to 16 do f[x][i]:=f[f[x][i-1]][i-1];
p:=edge[x];
while p<>0 do
  begin
  if (g[p].v<>fa) then dfs(g[p].v,x,d+1);
  p:=g[p].nxt;
  end;
end;
begin
assign(input,'trip.in');
reset(input);
assign(output,'trip.out');
rewrite(output);
readln(n);
for i:=1 to n do read(a[i]);
readln(m);
for i:=1 to n do from[i]:=i;
for i:=1 to m do
    begin
    readln(s);
    t:=pos(' ',s); ts:=copy(s,1,t-1);
    if ts[1]='b' then que[i].opt:=1 else if ts[1]='p' then que[i].opt:=2 else que[i].opt:=3;
    delete(s,1,t); t:=pos(' ',s); ts:=copy(s,1,t-1); val(ts,que[i].u,code);
    delete(s,1,t); val(s,que[i].v,code);
    if que[i].opt=1 then
       begin
       t1:=getfa(que[i].u); t2:=getfa(que[i].v);
       if t1<>t2 then
          begin
          from[t2]:=t1;
          addedge(que[i].u,que[i].v);
          addedge(que[i].v,que[i].u);
          end;
       end;
    end;
cnt:=0;
for i:=1 to n do if root[i]=0 then begin inc(cnt); dfs(i,0,0); end;
for i:=1 to n do from[i]:=i;
for i:=1 to m do
    begin
    if que[i].opt=1 then
       begin
       t1:=getfa(que[i].u); t2:=getfa(que[i].v);
       if t1<>t2 then begin writeln('yes'); from[t2]:=t1; end else writeln('no');
       end
    else if que[i].opt=2 then a[que[i].u]:=que[i].v
            else begin
                 t1:=getfa(que[i].u); t2:=getfa(que[i].v);
                 if t1<>t2 then writeln('impossible')
                    else begin
                         anc:=lca(que[i].u,que[i].v);
                         ans:=0;
                         x:=que[i].u;
                         while (x<>anc) do begin ans:=ans+a[x]; x:=f[x][0]; end;
                         x:=que[i].v;
                         while (x<>anc) do begin ans:=ans+a[x]; x:=f[x][0]; end;
                         ans:=ans+a[anc];
                         writeln(ans);
                         end;
                 end;
    end;
close(input);
close(output);
end.