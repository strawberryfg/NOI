const maxn=500200; maxm=1000020; inf=maxlongint;
type rec=record u,v,w,nxt:longint; end;
var n,m,i,x,y,z,tme,tot:longint;
    edge,flag,low,dfn:array[0..maxn]of longint;
    f:array[0..maxn,0..2]of longint;
    g:array[0..2*maxm+100]of rec;
    bridge,mark:array[0..2*maxm+100]of longint;
procedure addedge(x,y,z:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].w:=z;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure tarjan(x,fa:longint);
var p:longint;
begin
inc(tme);
low[x]:=tme; dfn[x]:=tme;
p:=edge[x];
while p<>0 do
  begin
  if g[p].v<>fa then
     begin
     if dfn[g[p].v]=0 then
        begin
        mark[p]:=1;
        tarjan(g[p].v,x);
        if low[g[p].v]<low[x] then low[x]:=low[g[p].v];
        if low[g[p].v]>dfn[x] then bridge[p]:=1;
        end
     else if dfn[g[p].v]<low[x] then low[x]:=dfn[g[p].v];
     end;
  p:=g[p].nxt;
  end;
end;
procedure dp(x,fa:longint);
var num1,num2,p,res1,res2,res3,min1,min2,tmp,flag1,flag2:longint;
begin
flag[x]:=1;
f[x][0]:=inf; f[x][1]:=inf; f[x][2]:=inf; min1:=inf; min2:=inf;
num1:=-1; num2:=-1;
p:=edge[x];
flag1:=0;
while p<>0 do
  begin
  if g[p].v<>fa then
     begin
     if flag[g[p].v]=0 then
        begin
        dp(g[p].v,x);
        tmp:=f[g[p].v][0];
        flag2:=0;
        if bridge[p]=1 then
           begin
           if g[p].w<tmp then flag2:=1;
           tmp:=min(tmp,g[p].w);
           end;
        if tmp<min1 then begin if flag2=1 then flag1:=1 else flag1:=0; min2:=min1; num2:=num1; min1:=tmp; num1:=g[p].v; end
           else if tmp<min2 then begin min2:=tmp; num2:=g[p].v; end;
        end;
     end;
  p:=g[p].nxt;
  end;
p:=edge[x];
res1:=inf; res2:=inf; res3:=inf;
while p<>0 do
  begin
  if (g[p].v<>fa)and(mark[p]=1) then
     begin
     if g[p].v=num1 then
        begin
        f[x][1]:=min(f[x][1],f[g[p].v][1]);
        if flag1=1 then f[x][1]:=min(f[x][1],f[g[p].v][0]);
        end
     else begin
          f[x][1]:=min(f[x][1],f[g[p].v][0]);
          if bridge[p]=1 then f[x][1]:=min(f[x][1],g[p].w);
          end;
     if g[p].v=num1 then
        begin
        res1:=min(res1,f[g[p].v][2]);
        if bridge[p]=1 then res1:=min(res1,g[p].w);
        end
     else begin
          res1:=min(res1,f[g[p].v][0]);
          if bridge[p]=1 then res1:=min(res1,g[p].w);
          end;
     if g[p].v=num2 then
        begin
        res2:=min(res2,f[g[p].v][2]);
        if bridge[p]=1 then res2:=min(res2,g[p].w);
        end
     else begin
          res2:=min(res2,f[g[p].v][0]);
          if bridge[p]=1 then res2:=min(res2,g[p].w);
          end;
     if (g[p].v=num1)or(g[p].v=num2) then res3:=min(res3,f[g[p].v][1])
        else begin
             res3:=min(res3,f[g[p].v][0]);
             if bridge[p]=1 then res3:=min(res3,g[p].w);
             end;
     end;
  p:=g[p].nxt;
  end;
f[x][0]:=min1;
f[x][2]:=max(res1,max(res2,res3));
end;
begin
assign(input,'escape.in');
reset(input);
assign(output,'escape.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y,z);
    addedge(x,y,z);
    addedge(y,x,z);
    end;
for i:=1 to n do if dfn[i]=0 then tarjan(i,0);
for i:=1 to n do if flag[i]=0 then dp(i,0);
if f[1][2]=inf then writeln(-1) else writeln(f[1][2]);
close(input);
close(output);
end.