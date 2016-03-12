const maxn=61; eps=1e-16;
type rec=record v,nxt:longint; end;
var n,most,tot,i,x,save:longint;
    edge,fa,dep:array[0..maxn]of longint;
    incircle:array[0..maxn]of boolean;
    g:array[0..maxn]of rec;
    c,pow:array[0..maxn+10]of extended;
    f:array[0..maxn,0..maxn,0..maxn]of extended;
    h:array[0..maxn]of extended;
    ans,num:extended;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
procedure cmax(var x:extended; y:extended);
begin
if y-x>eps then x:=y;
end;
procedure dp(x,d:longint);
var p,j,k,l:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  dp(g[p].v,d+1);
  for j:=most downto 0 do
      for k:=0 to d do
          for l:=0 to j do
              begin
              {if k+1<n then} cmax(f[x][j][k],f[x][j-l][k]+f[g[p].v][l][k+1]);
              if j-l-1>=0 then cmax(f[x][j][k],f[x][l][k]+f[g[p].v][j-l-1][1]);
              end;
  p:=g[p].nxt;
  end;
if not incircle[x] then for j:=0 to most do for k:=0 to d do f[x][j][k]:=f[x][j][k]+c[x]*pow[k];
end;
procedure work(now:longint);
var x,len,i,j,k,t,opt:longint; ret:extended;
begin
fillchar(edge,sizeof(edge),0); tot:=0;
fillchar(incircle,sizeof(incircle),false);
fillchar(f,sizeof(f),0);
fillchar(dep,sizeof(dep),0);
incircle[1]:=true;
x:=fa[1]; len:=0;
while x<>1 do begin incircle[x]:=true; x:=fa[x]; inc(len); end;
t:=len;
x:=fa[1];
while x<>1 do begin dep[x]:=t; dec(t); x:=fa[x]; end;
dep[1]:=0;
inc(len);
for i:=2 to n do if not incircle[i] then addedge(fa[i],i);
fillchar(h,sizeof(h),0);
for i:=2 to n do
    begin
    if not incircle[i] then
       begin
       if fa[i]=1 then opt:=1 else continue;
       dp(i,opt);
       for j:=most downto 0 do
          for k:=0 to j do
              cmax(h[j],h[j-k]+f[i][k][opt]);
       end
    else
       begin
       opt:=dep[i];
       dp(i,opt);
       for j:=most downto 0 do
          for k:=0 to j do
              cmax(h[j],h[j-k]+f[i][k][opt]);
       end;
    end;
ret:=0;
for i:=0 to most-1 do cmax(ret,h[i]);
if save=1 then cmax(ret,h[most]);
x:=fa[1]; t:=len-1;
while x<>1 do
  begin
  ret:=ret+c[x]*pow[t];
  dec(t);
  x:=fa[x];
  end;
ret:=ret+c[1];
cmax(ans,ret/(1-pow[len]));
end;
begin
assign(input,'trans.in');
reset(input);
assign(output,'trans.out');
rewrite(output);
readln(n,most,num);
for i:=1 to n do read(fa[i]);
for i:=1 to n do read(c[i]);
pow[0]:=1;
for i:=1 to n do pow[i]:=pow[i-1]*num;
x:=fa[1]; ans:=0;
while x<>1 do
  begin
  save:=fa[x]; fa[x]:=1;
  work(x);
  fa[x]:=save;
  x:=fa[x];
  end;
writeln(round(ans*100)/100:0:2);
close(input);
close(output);
end.