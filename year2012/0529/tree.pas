const maxn=320; maxm=20020; inf=5555555555555555555; eps=1e-10;
type gtype=record u,v,p,q:longint; w:extended; end;
     rec=record u,v,v1,v2:longint; end;
var n,m,i:longint;
    kk:extended;
    tmp,fans:qword;
    sta:array[0..maxm]of longint;
    fa:array[0..maxn]of longint;
    g:array[0..maxm]of gtype;
    a:array[0..maxm]of rec;
    ans:array[1..2]of record v1,v2:qword; end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
procedure sort(l,r:longint);
var i,j:longint; swap:gtype; cmp:extended;
begin
i:=l; j:=r; cmp:=g[(l+r) div 2].w;
repeat
while (cmp-g[i].w>eps) do inc(i);
while (g[j].w-cmp>eps) do dec(j);
if not(i>j) then begin swap:=g[i]; g[i]:=g[j]; g[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r:longint);
var i,j:longint; swap:gtype; cmp:extended; xa,xb:longint;
begin
i:=l; j:=r; cmp:=g[(l+r) div 2].w; xa:=g[(l+r) div 2].p; xb:=g[(l+r) div 2].q;
repeat
while (cmp-g[i].w>eps)or((abs(cmp-g[i].w)<eps)and(g[i].p<xa))or((abs(cmp-g[i].w)<eps)and(g[i].p=xa)and(g[i].q<xb)) do inc(i);
while (g[j].w-cmp>eps)or((abs(g[j].w-cmp)<eps)and(xa<g[j].p))or((abs(g[j].w-cmp)<eps)and(xa=g[j].p)and(xb<g[j].q)) do dec(j);
if not(i>j) then begin swap:=g[i]; g[i]:=g[j]; g[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure work1;
var i,now,t1,t2:longint;
begin
for i:=1 to m do begin g[i].u:=a[i].u; g[i].v:=a[i].v; g[i].w:=a[i].v1; g[i].p:=a[i].v2; end;
sort(1,m);
for i:=1 to n do fa[i]:=i;
i:=1; now:=0; ans[1].v1:=0; ans[1].v2:=0;   //1: min(v1) 2:=min(v2);
while (i<=m)and(now<n-1) do
  begin
  t1:=getfa(g[i].u); t2:=getfa(g[i].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     inc(now);
     ans[1].v1:=ans[1].v1+trunc(g[i].w);
     ans[1].v2:=ans[1].v2+g[i].p;
     end;
  inc(i);
  end;
end;
procedure work2;
var i,now,t1,t2:longint;
begin
for i:=1 to m do begin g[i].u:=a[i].u; g[i].v:=a[i].v; g[i].w:=a[i].v2; g[i].p:=a[i].v1; end;
sort(1,m);
for i:=1 to n do fa[i]:=i;
i:=1; now:=0; ans[2].v1:=0; ans[2].v2:=0;   //1: min(v1) 2:=min(v2);
while (i<=m)and(now<n-1) do
  begin
  t1:=getfa(g[i].u); t2:=getfa(g[i].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     inc(now);
     ans[2].v2:=ans[2].v2+trunc(g[i].w);
     ans[2].v1:=ans[2].v1+g[i].p;
     end;
  inc(i);
  end;
end;
procedure work(x1,y1,x2,y2,kk:extended);
var i,now,t1,t2,retv1,retv2:longint;
    ret,k:extended;
    tmp:qword;
begin
for i:=1 to m do begin g[i].u:=a[i].u; g[i].v:=a[i].v; g[i].w:=a[i].v2-kk*a[i].v1; g[i].p:=a[i].v1; g[i].q:=a[i].v2; end;
sort2(1,m);
for i:=1 to n do fa[i]:=i;
i:=1; now:=0;
retv1:=0; retv2:=0; ret:=0;
while (i<=m)and(now<n-1) do
  begin
  t1:=getfa(g[i].u); t2:=getfa(g[i].v);
  if t1<>t2 then
     begin
     fa[t2]:=t1;
     inc(now);
     ret:=ret+g[i].w;
     retv1:=retv1+g[i].p;
     retv2:=retv2+g[i].q;
     end;
  inc(i);
  end;
tmp:=qword(retv1)*qword(retv2); if tmp<fans then fans:=tmp;
if abs(x1-retv1)>eps then
   begin
   k:=(y1-retv2)/(x1-retv1);
   if abs(k-kk)>eps then work(x1,y1,retv1,retv2,k);
   end;
if abs(x2-retv1)>eps then
   begin
   k:=(y2-retv2)/(x2-retv1);
   if abs(k-kk)>eps then work(retv1,retv2,x2,y2,k);
   end;
end;
procedure dfs(x,suma,sumb,cnt:longint);
var i,t1,t2:longint;
begin
if x>m then
   begin
   if cnt=n-1 then
      begin
      for i:=1 to n do fa[i]:=i;
      for i:=1 to m do
          begin
          if sta[i]=0 then continue;
          t1:=getfa(a[i].u); t2:=getfa(a[i].v);
          if t1<>t2 then fa[t2]:=t1;
          end;
      t1:=getfa(1);
      for i:=2 to n do if getfa(i)<>t1 then exit;
      if int64(suma)*int64(sumb)<fans then fans:=int64(suma)*int64(sumb);
      end;
   exit;
   end;
if cnt+m-x+1<n-1 then exit;
for i:=0 to 1 do
    begin
    sta[x]:=i;
    dfs(x+1,suma+i*a[x].v1,sumb+i*a[x].v2,cnt+i);
    end;
end;
begin
assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(a[i].u,a[i].v,a[i].v1,a[i].v2);
    inc(a[i].u); inc(a[i].v);
    end;
if (n<=10)and(m<=20) then
   begin
   fans:=inf;
   dfs(1,0,0,0);
   writeln(fans);
   end
else
   begin
   work1;
   work2;
   fans:=inf;
   tmp:=ans[1].v1*ans[1].v2;
   if tmp<fans then fans:=tmp;
   tmp:=ans[2].v1*ans[2].v2;
   if tmp<fans then fans:=tmp;
   if ans[1].v1<>ans[2].v1 then
      begin
      kk:=(ans[1].v2-ans[2].v2)/(ans[1].v1-ans[2].v1);
      work(ans[1].v1,ans[1].v2,ans[2].v1,ans[2].v2,kk);
      end;
   writeln(fans);
   end;
close(input);
close(output);
end.
