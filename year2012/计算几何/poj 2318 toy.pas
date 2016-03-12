const maxn=5111; eps=1e-14;
type rec=record up,down:extended; end;
var n,i,run,m,le,ri,ans,res,mid:longint;
    px1,py1,px2,py2,xx,yy:extended;
    a:array[0..maxn]of rec;
    fans:array[0..maxn]of longint;
function cmp(x:extended):longint;
begin
if abs(x)<eps then exit(0);
if x>eps then exit(1) else exit(-1);
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
exit(x1*y2-x2*y1);
end;
function intersect(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
var ret:longint;
begin
if (y1=y2)and(x1<x3)and(x3<x2) then exit(true);
ret:=cmp(cross(x2-x1,y2-y1,x3-x1,y3-y1))*cmp(cross(x2-x1,y2-y1,x4-x1,y4-y1));
if ret>0 then exit(false);
ret:=cmp(cross(x3-x4,y3-y4,x1-x4,y1-y4))*cmp(cross(x3-x4,y3-y4,x2-x4,y2-y4));
if ret>0 then exit(false);
exit(true);
end;
function check(posi:longint):longint;
begin
if intersect(a[posi-1].up,py1,xx,yy,a[posi].up,py1,a[posi].down,py2) then exit(-1);
if intersect(xx,yy,a[posi].up,py1,a[posi-1].up,py1,a[posi-1].down,py2) then exit(1);
exit(0);
end;
begin
{assign(input,'toy.in');
reset(input);
assign(output,'toy.out');
rewrite(output);}
read(n); run:=0;
while n<>0 do
  begin
  inc(run);
  if run>1 then writeln;
  read(m,px1,py1,px2,py2);
  for i:=1 to n do read(a[i].up,a[i].down);
  a[0].up:=px1; a[0].down:=px1;
  a[n+1].up:=px2; a[n+1].down:=px2;
  fillchar(fans,sizeof(fans),0);
  for i:=1 to m do
      begin
      read(xx,yy);
      le:=1; ri:=n+1; ans:=-1;
      while le<=ri do
        begin
        mid:=(le+ri) div 2;
        res:=check(mid);
        if res=-1 then le:=mid+1
           else if res=1 then ri:=mid-1
                   else begin ans:=mid-1; break; end;
        end;
      inc(fans[ans]);
      end;
  for i:=0 to n do writeln(i,': ',fans[i]);
  read(n);
  end;
{close(input);
close(output);}
end.