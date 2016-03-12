//15:20
const maxn=10020;
type rec=record x,y1,y2,flag:longint; end;
     treetype=record l,r,ll,rr,res,sum,cover:longint; end;
var n,i,j,tot,cnt,ans,last:longint;
    x1,x2,y1,y2,y,ty:array[0..maxn]of longint;
    ind:array[0..maxn]of rec;
    tree:array[0..4*maxn]of treetype;
procedure sort(l,r: longint);
var i,j,t,tmp: longint;
begin
i:=l; j:=r; t:=y[(l+r) div 2];
repeat
while y[i]<t do inc(i);
while t<y[j] do dec(j);
if not(i>j) then begin tmp:=y[i]; y[i]:=y[j]; y[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function work(v:longint):longint;
var le,ri,mid,ans:longint;
begin
le:=1; ri:=cnt; ans:=0;
while le<=ri do
  begin
  mid:=(le+ri)div 2;
  if v>ty[mid] then le:=mid+1
     else if v<ty[mid] then ri:=mid-1
             else begin
                  ans:=mid;
                  break;
                  end;
  end;
exit(ans);
end;
procedure sort2(l,r: longint);
var i,j,t1,t2: longint;
    tt:rec;
begin
i:=l; j:=r; t1:=ind[(l+r) div 2].x; t2:=ind[(l+r)div 2].flag;
repeat
while (ind[i].x<t1)or((ind[i].x=t1)and(ind[i].flag>t2)) do inc(i);
while (t1<ind[j].x)or((t1=ind[j].x)and(t2>ind[j].flag)) do dec(j);
if not(i>j) then begin tt:=ind[i]; ind[i]:=ind[j]; ind[j]:=tt; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].ll:=0; tree[x].rr:=0; tree[x].sum:=0; tree[x].res:=0; tree[x].cover:=0;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure doit(f,t,d,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].cover:=tree[x].cover+d;
   end
else
   begin
   mid:=(tree[x].l+tree[x].r)div 2;
   if f<=mid then doit(f,t,d,x*2);
   if t>mid then doit(f,t,d,x*2+1);
   end;
if (tree[x].cover>0) then
   begin
   tree[x].res:=ty[tree[x].r+1]-ty[tree[x].l];
   tree[x].ll:=1; tree[x].rr:=1; tree[x].sum:=1;
   exit;
   end;
if (tree[x].cover=0)and(tree[x].l=tree[x].r) then
   begin
   tree[x].res:=0; tree[x].ll:=0; tree[x].rr:=0; tree[x].sum:=0;
   exit;
   end;
tree[x].ll:=tree[x*2].ll; tree[x].rr:=tree[x*2+1].rr;
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum-tree[x*2].rr*tree[x*2+1].ll;
tree[x].res:=tree[x*2].res+tree[x*2+1].res;
end;
begin
{assign(input,'picture.in');
reset(input);
assign(output,'picture.out');
rewrite(output);}
readln(n);
tot:=0;
for i:=1 to n do
    begin
    readln(x1[i],y1[i],x2[i],y2[i]);
    inc(tot); y[tot]:=y1[i];
    inc(tot); y[tot]:=y2[i];
    end;
sort(1,tot);
i:=1;
cnt:=0;
while i<=tot do
  begin
  j:=i;
  while (j+1<=tot)and(y[i]=y[j+1]) do inc(j);
  inc(cnt);
  ty[cnt]:=y[i];
  i:=j+1;
  end;
if cnt-1>=1 then init(1,cnt-1,1);
tot:=0;
for i:=1 to n do
    begin
    inc(tot);
    ind[tot].flag:=1;  ind[tot].x:=x1[i]; ind[tot].y1:=work(y1[i]); ind[tot].y2:=work(y2[i]);
    inc(tot);
    ind[tot].flag:=-1; ind[tot].x:=x2[i]; ind[tot].y1:=ind[tot-1].y1; ind[tot].y2:=ind[tot-1].y2;
    end;
sort2(1,tot);
ans:=0;
last:=0;
for i:=1 to tot do
    begin
    if i>1 then ans:=ans+(ind[i].x-ind[i-1].x)*2*tree[1].sum;
    doit(ind[i].y1,ind[i].y2-1,ind[i].flag,1);
    ans:=ans+abs(last-tree[1].res);
    last:=tree[1].res;
    end;
writeln(ans);
{close(input);
close(output);}
end.
