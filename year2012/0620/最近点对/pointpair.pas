const maxn=300020; eps=1e-12; inf=1e30;
type rec=record x,y:extended; end;
var n,i,j,num,top:longint;
    a,b,c,d,stack:array[0..2*maxn]of rec;
    s:array[0..2*maxn]of extended;
    ans,fmin:extended;
function min(x,y:extended):extended;
begin
if x-y>eps then exit(y) else exit(x);
end;
function max(x,y:extended):extended;
begin
if x-y>eps then exit(x) else exit(y);
end;
function cmp(c,d:rec):boolean;
begin
if (d.x-c.x>eps)or((abs(d.x-c.x)<eps)and(d.y-c.y>eps)) then cmp:=true else cmp:=false;
end;
function cmp2(x,y:extended):longint;
begin
if y-x>eps then exit(1);
if abs(y-x)<eps then exit(2);
exit(3);
end;
procedure swap(var c,d:rec);
var tmp:rec;
begin
tmp:=c; c:=d; d:=tmp;
end;
function cross(u,v,w:rec):extended;
begin
cross:=((v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y));
end;
function calc(c,d:rec):extended;
begin
calc:=sqrt((c.x-d.x)*(c.x-d.x)+(c.y-d.y)*(c.y-d.y));
end;
procedure sort(l,r:longint);
var i,j:longint; cmpx,cmpy:extended; now:rec;
begin
i:=l; j:=r; cmpx:=a[(l+r) div 2].x; cmpy:=a[(l+r) div 2].y;
repeat
while (cmp2(a[i].x,cmpx)=1)or((cmp2(a[i].x,cmpx)=2)and(cmp2(a[i].y,cmpy)=1)) do inc(i);
while (cmp2(cmpx,a[j].x)=1)or((cmp2(cmpx,a[j].x)=2)and(cmp2(cmpy,a[j].y)=1)) do dec(j);
if not(i>j) then begin now:=a[i]; a[i]:=a[j]; a[j]:=now; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure hull(l,r:longint; c,d:rec);
var num,i,j,k:longint; opt:rec; ret:extended;
begin
num:=l; opt:=a[l];
for k:=l+1 to r do
    if (s[k]-s[num]>eps)or((abs(s[k]-s[num])<eps)and(cmp(opt,a[k]))) then
       begin
       num:=k;
       opt:=a[k];
       end;
i:=l-1; j:=r+1;
for k:=l to r do
    begin
    inc(i); ret:=cross(c,opt,a[k]);
    if ret>eps then begin s[i]:=ret; swap(a[i],a[k]); end else dec(i);
    end;
for k:=r downto l do
    begin
    dec(j); ret:=cross(opt,d,a[k]);
    if ret>eps then begin s[j]:=ret; swap(a[j],a[k]); end else inc(j);
    end;
if l<=i then hull(l,i,c,opt);
inc(top); stack[top]:=opt;
if j<=r then hull(j,r,opt,d);
end;
function dis(u,v:rec):extended;
begin
dis:=sqrt((u.x-v.x)*(u.x-v.x)+(u.y-v.y)*(u.y-v.y));
end;
function workmindis(l,r:longint):extended;
var mid,cnt,cnt1,cnt2,i,ll,rr,j,l1,r1,l2,r2:longint;
    fans,fmax:extended;
begin
if l=r then exit(inf);
if l+1=r then
   begin
   if a[l].y-a[r].y>eps then swap(a[l],a[r]);
   exit(dis(a[l],a[r]));
   end;
mid:=(l+r) div 2;
fans:=min(workmindis(mid+1,r),workmindis(l,mid));
fmax:=-inf;
for i:=l to mid do fmax:=max(fmax,a[i].x);
cnt1:=0; cnt2:=0;
for i:=l to mid do if cmp2(fmax-a[i].x,fans)<3 then begin inc(cnt1); b[cnt1]:=a[i]; end;
for i:=mid+1 to r do if cmp2(a[i].x-fmax,fans)<3 then begin inc(cnt2); c[cnt2]:=a[i]; end;
ll:=1; rr:=1;
for i:=1 to cnt1 do
    begin
    while (ll<cnt2+1)and(cmp2(c[ll].y,b[i].y-fans)=1) do inc(ll);
    while (rr<cnt2+1)and(cmp2(c[rr].y,b[i].y+fans)<3) do inc(rr);
    for j:=ll to rr-1 do fans:=min(fans,dis(b[i],c[j]));
    end;
l1:=l; r1:=mid; l2:=mid+1; r2:=r; cnt:=0;
while (l1<=r1)and(l2<=r2) do
  begin
  if cmp2(a[l1].y,a[l2].y)<3 then begin inc(cnt); d[cnt]:=a[l1]; inc(l1); end
     else begin inc(cnt); d[cnt]:=a[l2]; inc(l2); end;
  end;
while (l1<=r1) do begin inc(cnt); d[cnt]:=a[l1]; inc(l1); end;
while (l2<=r2) do begin inc(cnt); d[cnt]:=a[l2]; inc(l2); end;
for i:=l to r do a[i]:=d[i-l+1];
exit(fans);
end;
begin
assign(input,'pointpair.in');
reset(input);
assign(output,'pointpair.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i].x,a[i].y);
num:=1;
for i:=2 to n do if cmp(a[i],a[num]) then num:=i;
swap(a[1],a[num]);
stack[1]:=a[1];
top:=1;
hull(2,n,a[1],a[1]);
stack[top+1]:=stack[1];
j:=2; ans:=0.0;
for i:=1 to top do
    begin
    while cross(stack[i+1],stack[i],stack[j+1])-cross(stack[i+1],stack[i],stack[j])>eps do
      begin
      inc(j); if j>top then j:=1;
      end;
    ans:=max(ans,calc(stack[i],stack[j]));
    end;
sort(1,n);
fmin:=workmindis(1,n);
writeln(round(fmin*100)/100:0:2,' ',round(ans*100)/100:0:2);
close(input);
close(output);
end.