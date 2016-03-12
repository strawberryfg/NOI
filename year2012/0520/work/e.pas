const maxn=50020+1;
      maxm=100020+1;
      mol=1000003;
type cc=record
     len,u,v:longint;
     end;
var g:array[0..maxm]of cc;
    father:array[0..maxn]of longint;
    now,had,i,j,k,n,m,p,q,f1,f2,tot,o:longint;
    ans:int64;
    fa:array[0..20]of longint;
    d:array[0..20]of cc;
    bz,num:array[0..maxn]of longint;
procedure qsort(l,r:longint);
var
   i,j,x:longint;
   ls:cc;
begin
i:=l;
j:=r;
x:=g[(l+r)shr 1].len;
while i<j do
  begin
  while (g[i].len<x) do inc(i);
  while (g[j].len>x) do dec(j);
  if i<=j then
     begin
     ls:=g[i]; g[i]:=g[j]; g[j]:=ls;
     inc(i);
     dec(j);
     end;
  end;
if i<r then qsort(i,r);
if j>l then qsort(l,j);
end;
function getfather(x:longint):longint;
var ls:longint;
begin
if father[x]=x then exit(x);
ls:=getfather(father[x]);
father[x]:=ls;
exit(ls);
end;
function getfa(x:longint):longint;
var ls:longint;
begin
if fa[x]=x then exit(x);
ls:=getfa(fa[x]);
fa[x]:=ls;
exit(ls);
end;
begin
{assign(input,'count.in');
reset(input);}
readln(n,m);
for i:=1 to m do
    begin
    readln(g[i].u,g[i].v,g[i].len);
    end;

qsort(1,m);
for i:=1 to n do father[i]:=i;
i:=1;
had:=0;
ans:=1;
fillchar(bz,sizeof(bz),0);
while (had<n-1) do
  begin
  k:=g[i].len;
  j:=i;
  q:=0;
  tot:=0;
  repeat
  begin
  if g[i].len<>k then break;
  inc(q);
  d[q].len:=g[i].len;
  d[q].u:=father[g[i].u];
  d[q].v:=father[g[i].v];
  if bz[d[q].u]<>k then
     begin
     bz[d[q].u]:=k;
     inc(tot);
     num[d[q].u]:=tot;
     end;
  if bz[d[q].v]<>k then
     begin
     bz[d[q].v]:=k;
     inc(tot);
     num[d[q].v]:=tot;
     end;
  inc(i);
  end
  until false;
  i:=j;
  p:=0;
  repeat
    begin
    if g[i].len<>k then break;
    f1:=getfather(g[i].u);
    f2:=getfather(g[i].v);
    if f1<>f2 then
       begin
       inc(p);
       father[f2]:=f1;
       end;
    inc(i);
    end
  until false;
  had:=had+p;
  now:=0;
  for j:=0 to 1 shl q-1 do
      begin
      o:=0;
      for k:=0 to q-1 do
          if (1 shl k)and j<>0 then inc(o);
if o<>p then continue;
      for k:=1 to tot do
          fa[k]:=k;
      o:=0;
      for k:=0 to q-1 do
          if (1 shl k)and j<>0 then
             begin
             f1:=getfa(num[d[k+1].u]);
             f2:=getfa(num[d[k+1].v]);
             if f1<>f2 then
                begin
                fa[f2]:=f1;
                inc(o);
                end;
             end;
       if o=p then inc(now);
       end;
  ans:=ans*int64(now) mod mol;
  end;
writeln(ans);
//close(input);
end.