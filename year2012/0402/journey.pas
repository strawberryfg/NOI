const maxn=400200;
type arr=array[1..2]of longint;
     rec=record u,v,nxt,op:longint; end;
     treetype=record l,r,del,max:longint; end;
var n,i,x,y,z,p,tot,total,ans:longint;
    a:array[0..2*maxn]of arr;
    g:array[0..2*maxn]of rec;
    edge:array[0..maxn]of longint;
    tree:array[0..8*maxn]of treetype;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure sort(l,r: longint);
var i,j,x,y: longint;
    tmp:arr;
begin
i:=l; j:=r; x:=a[(l+r) div 2][1]; y:=a[(l+r)div 2][2];
repeat
while (a[i][1]<x)or((a[i][1]=x)and(a[i][2]<y)) do inc(i);
while (x<a[j][1])or((x=a[j][1])and(y<a[j][2])) do dec(j);
if not(i>j) then begin tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure add(x,y:longint);
begin
if x>y then begin x:=x+y; y:=x-y; x:=x-y; end;
if (x=1)and(y=n) then exit;
if (x+1=y) then exit;
inc(tot);
a[tot][1]:=x; a[tot][2]:=y;
end;
procedure addedge(x,y:longint);
begin
inc(total); g[total].u:=x; g[total].v:=y; g[total].nxt:=edge[x]; edge[x]:=total; g[total].op:=total+1;
inc(total); g[total].u:=y; g[total].v:=x; g[total].nxt:=edge[y]; edge[y]:=total; g[total].op:=total-1;
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].del:=0; tree[x].max:=0;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure lazy(x:longint);
begin
if tree[x].l=tree[x].r then exit;
if tree[x].del<>0 then
   begin
   tree[x*2].del:=tree[x*2].del+tree[x].del;
   tree[x*2].max:=tree[x*2].max+tree[x].del;
   tree[x*2+1].del:=tree[x*2+1].del+tree[x].del;
   tree[x*2+1].max:=tree[x*2+1].max+tree[x].del;
   tree[x].del:=0;
   end;
end;
procedure update(x:longint);
begin
tree[x].max:=max(tree[x*2].max,tree[x*2+1].max);
end;
procedure work(f,t,x,d:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].del:=tree[x].del+d;
   tree[x].max:=tree[x].max+d;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then work(f,t,x*2,d);
if t>mid then work(f,t,x*2+1,d);
update(x);
end;
begin
assign(input,'journey.in');
reset(input);
assign(output,'journey.out');
rewrite(output);
readln(n);
init(1,n,1);
for i:=1 to n-2 do
    begin
    readln(x,y,z);
    add(x,y); add(x,z); add(y,z);
    end;
sort(1,tot);
i:=1;
a[0][1]:=-1; a[0][2]:=-1;    //boundary;
while i<=tot do
  begin
  if (a[i][1]<>a[i-1][1])or(a[i][2]<>a[i-1][2]) then
     begin
     addedge(a[i][1],a[i][2]);
     end;
  inc(i);
  end;
for i:=1 to total do
    begin
    if g[i].op<>i-1 then
       begin
       if g[i].u<>1 then
          begin
          work(g[i].u+1,g[i].v-1,1,1);
          end;
       end;
    end;
ans:=0;
for i:=2 to n do
    begin
    ans:=max(ans,tree[1].max);
    p:=edge[i-1];
    while p<>0 do
       begin
       x:=g[p].u; y:=g[p].v;
       if x>y then begin x:=x+y; y:=x-y; x:=x-y; end;
       if y=i-1 then
          begin
          work(x+1,y-1,1,1);
          end
       else
          begin
          if x-1>=1 then work(1,x-1,1,1);
          if y+1<=n then work(y+1,n,1,1);
          end;
       p:=g[p].nxt;
       end;
    p:=edge[i];
    while p<>0 do
       begin
       x:=g[p].u; y:=g[p].v;
       if x>y then begin x:=x+y; y:=x-y; x:=x-y; end;
       if x=i then work(x+1,y-1,1,-1)
          else begin
               if x-1>=1 then work(1,x-1,1,-1);
               if y+1<=n then work(y+1,n,1,-1);
               end;
       p:=g[p].nxt;
       end;
    end;
writeln(ans+1);
close(input);
close(output);
end.
