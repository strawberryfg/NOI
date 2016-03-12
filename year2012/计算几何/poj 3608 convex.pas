const maxn=81111; eps=1e-16;
type rec=record x,y:extended; end;
     arr=array[0..maxn]of rec;
var n,m,i:longint;
    stack,a,b:arr;
    ans:extended;
function cmp(x:extended):longint;
begin
if abs(x)<eps then exit(0);
if x>eps then exit(1);
exit(-1);
end;
procedure cmin(var x:extended; y:extended);
begin
if cmp(y-x)<0 then x:=y;
end;
function cross(u,v,w:rec):extended;
begin
exit((v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y));
end;
function cross2(x1,y1,x2,y2:extended):extended;
begin
exit(x1*y2-x2*y1);
end;
function dist(u,v:rec):extended;
begin
exit(sqrt((u.x-v.x)*(u.x-v.x)+(u.y-v.y)*(u.y-v.y)));
end;
procedure sort(var data:arr; l,r:longint);
var i,j:longint; xx,yy:extended; swap:rec;
begin
i:=l; j:=r; xx:=data[(l+r) div 2].x; yy:=data[(l+r) div 2].y;
repeat
while (cmp(xx-data[i].x)>0)or((cmp(xx-data[i].x)=0)and(cmp(yy-data[i].y)>0)) do inc(i);
while (cmp(data[j].x-xx)>0)or((cmp(data[j].x-xx)=0)and(cmp(data[j].y-yy)>0)) do dec(j);
if not(i>j) then begin swap:=data[i]; data[i]:=data[j]; data[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(data,l,j);
if i<r then sort(data,i,r);
end;
procedure graham(var data:arr; opt:longint);
var tot,top,i,k:longint;
begin
if opt=1 then tot:=n else tot:=m;
sort(data,1,tot); top:=0;
for i:=1 to tot do
    begin
    while (top>1)and(cmp(cross(stack[top-1],stack[top],data[i]))<0) do dec(top);
    inc(top); stack[top]:=data[i];
    end;
k:=top;
for i:=tot-1 downto 1 do
    begin
    while (top>k)and(cmp(cross(stack[top-1],stack[top],data[i]))<0) do dec(top);
    inc(top); stack[top]:=data[i];
    end;
dec(top);
if opt=1 then n:=top else m:=top;
data:=stack;
end;
function calc(u,v,w,z:rec):longint;
begin
exit(cmp(cross2(v.x-u.x,v.y-u.y,z.x-w.x,z.y-w.y)));
end;
function mindis(u,v,w:rec):extended;
var t:longint; la,lb,lc,ret:extended;
begin
la:=dist(u,v); lb:=dist(v,w); lc:=dist(u,w);
ret:=la; cmin(ret,lc);
t:=cmp(la*la+lb*lb-lc*lc);
if t<0 then exit(ret);
t:=cmp(lb*lb+lc*lc-la*la);
if t<0 then exit(ret);
cmin(ret,abs(cross(u,v,w))/lb);
exit(ret);
end;
procedure work;
var i,num1,num2,p1,p2,nxt1,nxt2,opt:longint;
begin
num1:=-1;
for i:=1 to n do
    if (num1=-1)or(cmp(a[i].y-a[num1].y)<0)or((cmp(a[i].y-a[num1].y)=0)and(cmp(a[i].x-a[num1].x)<0)) then num1:=i;
num2:=-1;
for i:=1 to m do
    if (num2=-1)or(cmp(b[i].y-b[num2].y)>0)or((cmp(b[i].y-b[num2].y)=0)and(cmp(b[i].x-b[num2].x)>0)) then num2:=i;
ans:=dist(a[num1],b[num2]); p1:=num1; p2:=num2;
while true do
  begin
  nxt1:=num1+1; if nxt1>n then nxt1:=1; nxt2:=num2+1; if nxt2>m then nxt2:=1;
  opt:=calc(a[num1],a[nxt1],b[nxt2],b[num2]);
  if opt=0 then
     begin
     cmin(ans,mindis(a[num1],b[num2],b[nxt2]));
     cmin(ans,mindis(a[nxt1],b[num2],b[nxt2]));
     cmin(ans,mindis(b[num2],a[num1],a[nxt1]));
     cmin(ans,mindis(b[nxt2],a[num1],a[nxt1]));
     inc(num1); if num1>n then num1:=1;
     inc(num2); if num2>m then num2:=1;
     end
  else if opt<0 then  // second convex hull
          begin
          cmin(ans,mindis(a[num1],b[num2],b[nxt2]));
          cmin(ans,mindis(a[nxt1],b[num2],b[nxt2]));
          inc(num2); if num2>m then num2:=1;
          end
       else begin
            cmin(ans,mindis(b[num2],a[num1],a[nxt1]));
            cmin(ans,mindis(b[nxt2],a[num1],a[nxt1]));
            inc(num1); if num1>n then num1:=1;
            end;
  if (num1=p1)and(num2=p2) then break;
  end;
writeln(ans:0:9);
end;
begin
{assign(input,'convex.in');
reset(input);
assign(output,'convex.out');
rewrite(output);}
read(n,m);
while (n<>0)and(m<>0) do
  begin
  for i:=1 to n do read(a[i].x,a[i].y);
  for i:=1 to m do read(b[i].x,b[i].y);
  graham(a,1); graham(b,2);
  work;
  read(n,m);
  end;
{close(input);
close(output);}
end.