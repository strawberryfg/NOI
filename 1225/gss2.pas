//20:28;
const maxn=100020; maxm=100020; inf=maxlongint; maxv=100020;
type edgenode=record first,last:longint; end;
     node=record nxt:longint; end;
     treenode=record l,r,cdelta,edelta,cmax,emax:longint; end;
     querynode=record l,r:longint; end;
var n,m,i,d,t:longint;
    edge:array[0..maxn]of edgenode;
    a:array[0..maxn]of longint;
    g:array[0..maxm]of node;
    tree:array[0..4*maxn]of treenode;
    q:array[0..maxm]of querynode;
    ans,ind:array[0..maxm]of longint;
    last:array[-maxv..maxv]of longint;
procedure sort(l,r: longint);
      var
         i,j,x,tmp: longint;
         y:querynode;
      begin
         i:=l;
         j:=r;
         x:=q[(l+r) div 2].r;
         repeat
           while q[i].r<x do
            inc(i);
           while x<q[j].r do
            dec(j);
           if not(i>j) then
             begin
                y:=q[i];
                q[i]:=q[j];
                q[j]:=y;
                tmp:=ind[i];
                ind[i]:=ind[j];
                ind[j]:=tmp;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure lazy(x:longint);
begin
tree[x*2].edelta:=max(tree[x*2].edelta,tree[x].edelta+tree[x*2].cdelta);
tree[x*2+1].edelta:=max(tree[x*2+1].edelta,tree[x].edelta+tree[x*2+1].cdelta);
tree[x*2].cdelta:=tree[x*2].cdelta+tree[x].cdelta;
tree[x*2+1].cdelta:=tree[x*2+1].cdelta+tree[x].cdelta;
tree[x].cdelta:=0; tree[x].edelta:=0;
end;
procedure update(x:longint);
begin
tree[x].cmax:=max(tree[x*2].cmax+tree[x*2].cdelta,tree[x*2+1].cmax+tree[x*2+1].cdelta);
tree[x].emax:=max(tree[x*2].emax,tree[x*2+1].emax);
tree[x].emax:=max(tree[x].emax,tree[x*2].cmax+tree[x*2].edelta);
tree[x].emax:=max(tree[x].emax,tree[x*2+1].cmax+tree[x*2+1].edelta);
end;
procedure modify(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].cdelta:=tree[x].cdelta+d;
   tree[x].edelta:=max(tree[x].edelta,tree[x].cdelta);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
lazy(x);
if f<=mid then modify(f,t,x*2);
if t>mid then modify(f,t,x*2+1);
update(x);
end;
function query(f,t,x:longint):longint;
var mid,res:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
    exit(max(tree[x].emax,tree[x].cmax+tree[x].edelta));
mid:=(tree[x].l+tree[x].r)div 2;
lazy(x);
update(x);
res:=-inf;
if f<=mid then res:=max(res,query(f,t,x*2));
if t>mid then res:=max(res,query(f,t,x*2+1));
exit(res);
end;
begin
{assign(input,'gss2.in');
reset(input);}
readln(n);
for i:=1 to n do read(a[i]);
readln(m);
for i:=1 to m do
    begin
    read(q[i].l,q[i].r);
    ind[i]:=i;
    end;
sort(1,m);
for i:=1 to m do
    begin
    if edge[q[i].r].first=0 then edge[q[i].r].first:=i
       else g[edge[q[i].r].last].nxt:=i;
    edge[q[i].r].last:=i;
    end;
init(1,n,1);
for i:=1 to n do
    begin
    d:=a[i];
    modify(last[d]+1,i,1);
    t:=edge[i].first;
    while t<>0 do
       begin
       ans[ind[t]]:=query(q[t].l,q[t].r,1);
       t:=g[t].nxt;
       end;
    last[d]:=i;
    end;
for i:=1 to m do writeln(ans[i]);
//close(input);
end.