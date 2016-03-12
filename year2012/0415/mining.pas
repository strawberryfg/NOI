const maxn=700; maxm=700;
type rec=record u,v,nxt:longint; end;
var i,j,n,m,tme,top,tot,cnt,sum,t:longint;
    hash,vertex,edge,dfn,low,stack:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    x,y:array[0..maxm]of longint;
    h,com:array[0..maxn,0..1000]of longint;
    num,ans:qword;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure tarjan(x,fa:longint);
var p,t:longint;
begin
inc(tme); dfn[x]:=tme; low[x]:=tme;
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
          while stack[top+1]<>g[p].v do
             begin
             t:=stack[top];
             inc(h[t][0]); h[t][h[t][0]]:=cnt;
             inc(com[cnt][0]); com[cnt][com[cnt][0]]:=t;
             dec(top);
             end;
          inc(h[x][0]); h[x][h[x][0]]:=cnt;
          inc(com[cnt][0]); com[cnt][com[cnt][0]]:=x;
          end;
       end
    else
       begin
       low[x]:=min(low[x],dfn[g[p].v]);
       end;
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
for i:=1 to m do
    begin
    readln(x[i],y[i]);
    if hash[x[i]]=0 then
       begin
       inc(n);
       vertex[n]:=x[i];
       hash[x[i]]:=n;
       end;
    if hash[y[i]]=0 then
       begin
       inc(n);
       vertex[n]:=y[i];
       hash[y[i]]:=n;
       end;
    end;
n:=6;
for i:=1 to m do
    begin
{    addedge(hash[x[i]],hash[y[i]]);
    addedge(hash[y[i]],hash[x[i]]);}
    addedge(x[i],y[i]);
    addedge(y[i],x[i]);
    end;
for i:=1 to n do
    if dfn[i]=0 then
       tarjan(i,0);
num:=0; ans:=1;
for i:=1 to cnt do
    begin
    sum:=0;
    for j:=1 to com[i][0] do
        begin
        t:=com[i][j];
        if h[t][0]>1 then
           inc(sum);
        end;
    if sum=0 then
       begin
       inc(num,2);
       ans:=ans*qword(com[i][0])*qword(com[i][0]-1)div 2;
       end
    else
       if sum=1 then
          begin
          inc(num);
          ans:=ans*qword(com[i][0]-1);
          end;
    end;
writeln(num,' ',ans);
close(input);
close(output);
end.