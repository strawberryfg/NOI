const maxn=100020; eps=1e-16;
type segtype=record x1,y1,x2,y2:extended; end;
     atype=record xx,yy:extended; end;
var n,i,pd,j,cnt:longint;
    lastx,lasty,x,y:extended;
    seg:array[0..maxn]of segtype;
    a:array[0..maxn]of atype;
    ans:array[0..maxn]of longint;
function cmp(x:extended):longint;
begin
if abs(x)<eps then exit(0);
if x>eps then exit(1);
if x<-eps then exit(-1);
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
exit(x1*y2-x2*y1);
end;
function dot(x1,y1,x2,y2:extended):extended;
begin
exit(x1*x2+y1*y2);
end;
function online(x0,y0,lx,ly,rx,ry:extended):boolean;
var ret:extended;
begin
ret:=cross(lx-x0,ly-y0,rx-x0,ry-y0);
if cmp(ret)<>0 then exit(false);
ret:=dot(lx-x0,ly-y0,rx-x0,ry-y0);
if cmp(ret)>0 then exit(false);
exit(true);
end;
function intersect(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
var ret:longint;
begin
if online(x3,y3,x1,y1,x2,y2) then exit(true);
if online(x4,y4,x1,y1,x2,y2) then exit(true);
if online(x1,y1,x3,y3,x4,y4) then exit(true);
if online(x2,y2,x3,y3,x4,y4) then exit(true);
ret:=cmp(cross(x4-x3,y4-y3,x2-x3,y2-y3))*cmp(cross(x4-x3,y4-y3,x1-x3,y1-y3));
if ret>0 then exit(false);
ret:=cmp(cross(x2-x1,y2-y1,x3-x1,y3-y1))*cmp(cross(x2-x1,y2-y1,x4-x1,y4-y1));
if ret>0 then exit(false);
exit(true);
end;
begin
{assign(input,'circuit.in');
reset(input);
assign(output,'circuit.out');
rewrite(output);}
read(n);
for i:=1 to n do
    begin
    read(x,y); a[i].xx:=x; a[i].yy:=y;
    if i>1 then begin inc(cnt); seg[cnt].x1:=lastx; seg[cnt].y1:=lasty; seg[cnt].x2:=x; seg[cnt].y2:=y; end;
    lastx:=x; lasty:=y;
    end;
inc(cnt); seg[cnt].x1:=x; seg[cnt].y1:=y; seg[cnt].x2:=seg[1].x1; seg[cnt].y2:=seg[1].y1;
ans[0]:=0;
for i:=1 to n do
    begin
    pd:=1;
    for j:=1 to cnt do
        begin
        if (seg[j].x1=a[i].xx)and(seg[j].y1=a[i].yy) then continue;
        if (seg[j].x2=a[i].xx)and(seg[j].y2=a[i].yy) then continue;
        if intersect(0,0,a[i].xx,a[i].yy,seg[j].x1,seg[j].y1,seg[j].x2,seg[j].y2) then begin pd:=0; break; end;
        end;
    if pd=1 then begin inc(ans[0]); ans[ans[0]]:=i; end;
    end;
writeln(ans[0]);
for i:=1 to ans[0]-1 do write(ans[i],' ');
write(ans[ans[0]]);
writeln;
{close(input);
close(output);}
end.