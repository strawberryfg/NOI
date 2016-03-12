const maxn=100020; inf=maxlongint;
type rec=record x,y,ind:longint; end;
     querytype=record id,key:longint; end;
var r,c,n,i,j,cntx,cnty:longint;
    a,b,ta,id:array[0..maxn]of rec;
    rmin,rmax,cmin,cmax,xx,yy:array[0..maxn]of longint;
    tree,h:array[0..4*maxn]of longint;
    ans,occ:qword;
procedure sortx(l,r: longint);
var i,j,cmpx,cmpy:longint; swap:rec;
begin
i:=l; j:=r; cmpx:=a[(l+r) div 2].x; cmpy:=a[(l+r) div 2].y;
repeat
while (a[i].x<cmpx)or((a[i].x=cmpx)and(a[i].y<cmpy)) do inc(i);
while (cmpx<a[j].x)or((cmpx=a[j].x)and(cmpy<a[j].y)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sortx(l,j);
if i<r then sortx(i,r);
end;
procedure sorty(l,r: longint);
var i,j,cmpx,cmpy:longint; swap:rec;
begin
i:=l; j:=r; cmpx:=b[(l+r) div 2].x; cmpy:=b[(l+r) div 2].y;
repeat
while (b[i].y<cmpy)or((b[i].y=cmpy)and(b[i].x<cmpx)) do inc(i);
while (cmpy<b[j].y)or((cmpy=b[j].y)and(cmpx<b[j].x)) do dec(j);
if not(i>j) then begin swap:=b[i]; b[i]:=b[j]; b[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sorty(l,j);
if i<r then sorty(i,r);
end;
function findx(v:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=cntx;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if xx[mid]<v then le:=mid+1
     else if xx[mid]>v then ri:=mid-1
             else exit(mid);
  end;
end;
function findy(v:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=cnty;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if yy[mid]<v then le:=mid+1
     else if yy[mid]>v then ri:=mid-1
             else exit(mid);
  end;
end;
procedure init(l,r,x,opt:longint);
var flag:longint;
begin
if l=r then
   begin
   if opt=1 then tree[x]:=cmax[l] else if opt=2 then tree[x]:=cmin[l] else if opt=3 then tree[x]:=rmin[l] else tree[x]:=rmax[l];
   h[x]:=l; exit;
   end;
init(l,(l+r) div 2,x*2,opt);
init((l+r) div 2+1,r,x*2+1,opt);
if opt=1 then begin if tree[x*2]<tree[x*2+1] then flag:=1 else flag:=2; end;
if opt=2 then begin if tree[x*2]>tree[x*2+1] then flag:=1 else flag:=2; end;
if opt=3 then begin if tree[x*2]>tree[x*2+1] then flag:=1 else flag:=2; end;
if opt=4 then begin if tree[x*2]<tree[x*2+1] then flag:=1 else flag:=2; end;
if flag=1 then begin tree[x]:=tree[x*2]; h[x]:=h[x*2]; end
   else begin tree[x]:=tree[x*2+1]; h[x]:=h[x*2+1]; end;
end;
function check(opt,key,v:longint):boolean;
begin
if opt=1 then if key>=v then exit(false);
if opt=2 then if key<=v then exit(false);
if opt=3 then if key<=v then exit(false);
if opt=4 then if key>=v then exit(false);
exit(true);
end;
function query(l,r,f,t,x,opt,num,spe:longint):querytype;
var mid,flag:longint;
    ret1,ret2:querytype;
begin
query.id:=-1;
if l=r then
   begin
   if check(opt,tree[x],num) then begin query.id:=l; query.key:=tree[x]; end;
   exit;
   end;
if not check(opt,tree[x],num) then exit;
ret1.id:=-1; ret2.id:=-1;
mid:=(l+r) div 2;
if spe=1 then
   begin
   if t>mid then ret2:=query(mid+1,r,f,t,x*2+1,opt,num,spe);
   if (ret2.id<>-1)and(check(opt,ret2.key,num)) then begin query.id:=ret2.id; query.key:=ret2.key; exit; end;
   if f<=mid then ret1:=query(l,mid,f,t,x*2,opt,num,spe);
   if (ret1.id<>-1)and(check(opt,ret1.key,num)) then begin query.id:=ret1.id; query.key:=ret1.key; exit; end;
   end
else
   begin
   if f<=mid then ret1:=query(l,mid,f,t,x*2,opt,num,spe);
   if (ret1.id<>-1)and(check(opt,ret1.key,num)) then begin query.id:=ret1.id; query.key:=ret1.key; exit; end;
   if t>mid then ret2:=query(mid+1,r,f,t,x*2+1,opt,num,spe);
   if (ret2.id<>-1)and(check(opt,ret2.key,num)) then begin query.id:=ret2.id; query.key:=ret2.key; exit; end;
   end;
end;
procedure work1(opt:longint);
var i,ll,rr,tmp:longint;
    res:querytype;
begin
for i:=1 to n do
    begin
    if a[i-1].x<>a[i].x then ll:=0 else ll:=id[a[i-1].ind].y;
    rr:=id[a[i].ind].y;
    if ll+1<=rr-1 then
       begin
       res:=query(1,cnty,ll+1,rr-1,1,opt,id[a[i].ind].x,1);
       if res.id<>-1 then
          begin
          if opt=1 then tmp:=r-a[i].x-(cntx-id[a[i].ind].x)
             else tmp:=a[i].x-1-(id[a[i].ind].x-1);
          if ll=0 then
             tmp:=tmp+yy[res.id]-1-(res.id-1);
          if (tmp>0)and(tmp>ans) then ans:=tmp;
          end;
       if ll=0 then
          begin
          tmp:=a[i].y-1-(id[a[i].ind].y-1)-1;
          if (tmp>0)and(tmp>ans) then ans:=tmp;
          end;
       end;
    if (ll=0)and(rr=1) then
       begin
       tmp:=a[i].y-2;
       if (tmp>0)and(tmp>ans) then
          ans:=tmp;
       end;
    if a[i+1].x<>a[i].x then
       begin
       ll:=id[a[i].ind].y; rr:=cnty+1;
       if ll+1<=rr-1 then
          begin
          res:=query(1,cnty,ll+1,rr-1,1,opt,id[a[i].ind].x,2);
          if res.id<>-1 then
             begin
             if opt=1 then tmp:=r-a[i].x-(cntx-id[a[i].ind].x)
                else tmp:=a[i].x-1-(id[a[i].ind].x-1);
             tmp:=tmp+c-yy[res.id]-(cnty-res.id);
             if (tmp>0)and(tmp>ans) then ans:=tmp;
             end;
          tmp:=c-a[i].y-(cnty-id[a[i].ind].y)-1;
          if (tmp>0)and(tmp>ans) then
             ans:=tmp;
          end;
       end
    end;
end;
procedure work2(opt:longint);
var i,ll,rr,tmp:longint;
    res:querytype;
begin
for i:=1 to n do
    begin
    if b[i-1].y<>b[i].y then ll:=0 else ll:=id[b[i-1].ind].x;
    rr:=id[b[i].ind].x;
    if ll+1<=rr-1 then
       begin
       res:=query(1,cntx,ll+1,rr-1,1,opt,id[b[i].ind].y,1);
       if res.id<>-1 then
          begin
          if opt=3 then tmp:=b[i].y-1-(id[b[i].ind].y-1)
             else tmp:=c-b[i].y-(cnty-id[b[i].ind].y);
          if ll=0 then
             tmp:=tmp+xx[res.id]-1-(res.id-1);
          if (tmp>0)and(tmp>ans) then ans:=tmp;
          end;
       if ll=0 then
          begin
          tmp:=b[i].x-1-(id[b[i].ind].x-1)-1;
          if (tmp>0)and(tmp>ans) then ans:=tmp;
          end;
       end;
    if (ll=0)and(rr=1) then
       begin
       tmp:=b[i].x-2;
       if (tmp>0)and(tmp>ans) then
          ans:=tmp;
       end;
    if b[i+1].y<>b[i].y then
       begin
       ll:=id[b[i].ind].x; rr:=cntx+1;
       if ll+1<=rr-1 then
          begin
          res:=query(1,cntx,ll+1,rr-1,1,opt,id[b[i].ind].y,2);
          if res.id<>-1 then
             begin
             if opt=3 then tmp:=b[i].y-1-(id[b[i].ind].y-1)
                else tmp:=c-b[i].y-(cnty-id[b[i].ind].y);
             tmp:=tmp+r-xx[res.id]-(cntx-res.id);
             if (tmp>0)and(tmp>ans) then ans:=tmp;
             end;
          tmp:=r-b[i].x-(cntx-id[b[i].ind].x)-1;
          if (tmp>0)and(tmp>ans) then
             ans:=tmp;
          end;
       end
    end;
end;
begin
assign(input,'dragon.in');
reset(input);
assign(output,'dragon.out');
rewrite(output);
readln(r,c,n);
for i:=1 to n do readln(a[i].x,a[i].y);
for i:=1 to n do begin a[i].ind:=i; b[i].ind:=i; end;
ta:=a;
b:=a;
sortx(1,n);
sorty(1,n);
i:=1;
cntx:=0;
while i<=n do
  begin
  j:=i;
  inc(cntx);
  xx[cntx]:=a[i].x;
  while (j+1<=n)and(a[j+1].x=a[i].x) do inc(j);
  i:=j+1;
  end;
i:=1;
cnty:=0;
while i<=n do
  begin
  j:=i;
  inc(cnty);
  yy[cnty]:=b[i].y;
  while (j+1<=n)and(b[j+1].y=b[i].y) do inc(j);
  i:=j+1;
  end;
for i:=1 to n do
    begin
    id[i].x:=findx(ta[i].x);
    id[i].y:=findy(ta[i].y);
    end;
for i:=1 to cntx do begin rmax[i]:=-inf; rmin[i]:=inf; end;
for i:=1 to cnty do begin cmax[i]:=-inf; cmin[i]:=inf; end;
for i:=1 to n do
    begin
    if id[i].y<rmin[id[i].x] then rmin[id[i].x]:=id[i].y;
    if id[i].y>rmax[id[i].x] then rmax[id[i].x]:=id[i].y;
    if id[i].x<cmin[id[i].y] then cmin[id[i].y]:=id[i].x;
    if id[i].x>cmax[id[i].y] then cmax[id[i].y]:=id[i].x;
    end;
occ:=qword(cntx)*qword(c)+qword(cnty)*qword(r)-qword(cntx)*qword(cnty);
ans:=0;
init(1,cnty,1,1); // opt:1 min{cmax}
work1(1);
init(1,cnty,1,2);
work1(2);
init(1,cntx,1,3);
work2(3);
init(1,cntx,1,4);
work2(4);
ans:=qword(r)*qword(c)-occ+ans;
writeln(ans);
close(input);
close(output);
end.
