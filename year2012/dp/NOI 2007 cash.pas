//14:03;
const maxn=200200; inf=maxlongint; eps=1e-12;
type rec=record x,y,k1,k2:extended; end;
var n,s,i,tot,root:longint;
    res:extended;
    tmp:rec;
    f,a,b,rate:array[0..maxn]of extended;
    left,right,fa:array[0..maxn]of longint;
    tree:array[0..maxn]of rec;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then cmp:=0
   else if xx>eps then cmp:=1
          else cmp:=-1;
end;
function slope(u,v:rec):extended;
begin
if cmp(u.x-v.x)=0 then slope:=-inf
   else slope:=(v.y-u.y)/(v.x-u.x);
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
left[x]:=y;
fa[x]:=fa[y];
fa[y]:=x;
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
if fa[y]<>0 then
   begin
   if y=left[fa[y]] then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
right[x]:=y;
fa[x]:=fa[y];
fa[y]:=x;
end;
procedure splay(x,y:longint);
begin
while fa[x]<>y do
  begin
  if fa[fa[x]]=y then
     begin
     if x=left[fa[x]] then rightrotate(x) else leftrotate(x)
     end
  else
     begin
     if fa[x]=left[fa[fa[x]]] then
        begin
        if x=left[fa[x]] then begin rightrotate(fa[x]); rightrotate(x) end
           else begin leftrotate(x); rightrotate(x); end;
        end
     else
        begin
        if x=right[fa[x]] then begin leftrotate(fa[x]); leftrotate(x); end
           else begin rightrotate(x); leftrotate(x); end;
        end;
     end;
  end;
if y=0 then root:=x;
end;
procedure insert(now:rec);
var t,num,pd:longint;
begin
t:=root; num:=0;
while t<>0 do
  begin
  if cmp(now.x-tree[t].x)>=0 then
     begin
     num:=t;
     t:=right[t];
     end
  else
     t:=left[t];
  end;
pd:=0;
if num=0 then
   begin
   inc(tot);
   left[tot]:=0; right[tot]:=root; fa[root]:=tot; tree[tot].x:=now.x; tree[tot].y:=now.y;
   root:=tot;
   end
else
   begin
   if cmp(tree[num].k2-slope(tree[num],now))>=0 then pd:=1;
   if (cmp(tree[num].x-now.x)=0)and(cmp(tree[num].y-now.y)=0) then pd:=1;
   if pd=0 then
      begin
      splay(num,0);
      inc(tot); right[tot]:=right[num]; tree[tot].x:=now.x; tree[tot].y:=now.y;
      if right[num]<>0 then fa[right[num]]:=tot;
      right[num]:=0; left[tot]:=num;
      fa[num]:=tot;
      root:=tot;
      end;
   end;
if pd=0 then
   begin
   t:=num; num:=0;
   while t<>0 do
     begin
     if cmp(tree[t].k1-slope(tree[t],now))>0 then
        begin
        num:=t;
        t:=right[t];
        end
     else
        t:=left[t];
     end;
   if num=0 then
      begin
      left[root]:=0;
      tree[root].k1:=0;
      end
   else
      begin
      splay(num,root);
      right[num]:=0;
      tree[num].k2:=slope(tree[num],tree[root]);
      tree[root].k1:=tree[num].k2;
      end;
   t:=right[root]; num:=0;
   while t<>0 do
     begin
     if cmp(slope(now,tree[t])-tree[t].k2)>0 then
        begin
        num:=t;
        t:=left[t];
        end
     else
        t:=right[t];
     end;
   if num=0 then
      begin
      right[root]:=0;
      tree[root].k2:=-inf;
      end
   else
      begin
      splay(num,root);
      left[num]:=0;
      tree[num].k1:=slope(tree[root],tree[num]);
      tree[root].k2:=tree[num].k1;
      end;
   end;
end;
function find(xx:extended):rec;
var x:longint;
begin
x:=root;
while x<>0 do
  begin
  if (cmp(tree[x].k1-xx)>=0)and(cmp(xx-tree[x].k2)>=0) then
     begin
     splay(x,0);
     find:=tree[x]; break;
     end;
  if cmp(tree[x].k2-xx)>0 then x:=right[x]
     else x:=left[x];
  end;
end;
begin
assign(input,'cash.in');
reset(input);
assign(output,'cash.out');
rewrite(output);
readln(n,s);
f[1]:=s;
for i:=1 to n do readln(a[i],b[i],rate[i]);
tree[1].x:=f[1]*rate[1]/(a[1]*rate[1]+b[1]);
tree[1].y:=f[1]/(a[1]*rate[1]+b[1]);
tree[1].k1:=0; tree[1].k2:=-inf;
tot:=1; root:=1;
for i:=2 to n do
    begin
    if f[i-1]-f[i]>eps then f[i]:=f[i-1]; // do nothing
    tmp:=find(-a[i]/b[i]);
    res:=a[i]*tmp.x+b[i]*tmp.y;
    if res-f[i]>eps then f[i]:=res;
    tmp.x:=rate[i]*f[i]/(a[i]*rate[i]+b[i]);
    tmp.y:=f[i]/(a[i]*rate[i]+b[i]);
    insert(tmp);
    end;
writeln(round(f[n]*1000)/1000:0:3);
close(input);
close(output);
end.