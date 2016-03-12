uses math;
const maxn=51; eps=1e-16; inf1=100000; inf2=111111111;
type rec=record x,y:extended; end;
     segtype=record x1,y1,x2,y2:extended; end;
var n,m,i,j,cnt,tot:longint;
    ver:array[0..maxn*maxn*5]of rec;
    seg:array[0..maxn*maxn*5]of segtype;
    hash:array[0..maxn,0..maxn]of longint;
    map:array[0..maxn,0..maxn]of char;
    line:array[1..2]of segtype;
    ans,mmin:extended;
    p1,p2:rec;
procedure swap(var p,q:rec);
var tmp:rec;
begin
tmp:=p; p:=q; q:=tmp;
end;
procedure addseg(xx1,yy1,xx2,yy2:longint);
begin
inc(cnt); seg[cnt].x1:=xx1; seg[cnt].y1:=yy1; seg[cnt].x2:=xx2; seg[cnt].y2:=yy2;
hash[xx1][yy1]:=1; hash[xx2][yy2]:=1;
end;
procedure cmin(var x:extended; y:extended);
begin
if x-y>eps then x:=y;
end;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1) else exit(-1);
end;
function cross(u,v,w:rec):extended;
begin
exit((v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y));
end;
function cross2(xx1,yy1,xx2,yy2:extended):extended;
begin
exit(xx1*yy2-xx2*yy1);
end;
function dot(xx1,yy1,xx2,yy2:extended):extended;
begin
exit(xx1*xx2+yy1*yy2);
end;
function cmp2(xx1,yy1,xx2,yy2:extended):boolean;
var ret:longint;
begin
ret:=cmp(arctan2(yy1,xx1)-arctan2(yy2,xx2));
if ret>0 then exit(true) else exit(false);
end;
procedure sort(l,r:longint);
var i,j:longint; base:rec;
begin
i:=l; j:=r; base:=ver[random(r-l)+l];
repeat
begin
while (cmp2(base.x-ver[0].x,base.y-ver[0].y,ver[i].x-ver[0].x,ver[i].y-ver[0].y)) do inc(i);
while (cmp2(ver[j].x-ver[0].x,ver[j].y-ver[0].y,base.x-ver[0].x,base.y-ver[0].y))  do dec(j);
if not(i>j) then begin swap(ver[i],ver[j]); inc(i); dec(j); end;
end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function intersect(u,v:segtype):boolean;
var ret:longint;
begin
ret:=cmp(cross2(u.x2-u.x1,u.y2-u.y1,v.x1-u.x1,v.y1-u.y1))*cmp(cross2(u.x2-u.x1,u.y2-u.y1,v.x2-u.x1,v.y2-u.y1));
if ret>0 then exit(false);
ret:=cmp(cross2(v.x2-v.x1,v.y2-v.y1,u.x1-v.x1,u.y1-v.y1))*cmp(cross2(v.x2-v.x1,v.y2-v.y1,u.x2-v.x1,u.y2-v.y1));
if ret>0 then exit(false);
exit(true);
end;
function getcommon(u,v:segtype):rec;
var sabc,sabd:extended;
begin
sabc:=abs(cross2(v.x1-u.x1,v.y1-u.y1,u.x2-u.x1,u.y2-u.y1))/2;
sabd:=abs(cross2(v.x2-u.x1,v.y2-u.y1,u.x2-u.x1,u.y2-u.y1))/2;
getcommon.x:=(sabc*v.x2+sabd*v.x1)/(sabc+sabd);
getcommon.y:=(sabc*v.y2+sabd*v.y1)/(sabc+sabd);
end;
begin
assign(input,'shadowarea.in');
reset(input);
assign(output,'shadowarea.out');
rewrite(output);
readln(n,m);
ans:=n*m;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(map[i][j]);
        if map[i][j]='*' then
           begin
           ver[0].x:=i+0.5; ver[0].y:=j+0.5;
           end
        else if map[i][j]='#' then ans:=ans-1;
        end;
    readln;
    end;
cnt:=0;
addseg(1,1,1,m+1);
addseg(n+1,1,n+1,m+1);
addseg(1,1,n+1,1);
addseg(1,m+1,n+1,m+1);
for i:=1 to n+1 do
    for j:=1 to m+1 do
        if map[i][j]='#' then
           begin
           if map[i-1][j]<>'#' then addseg(i,j,i,j+1);
           if map[i][j-1]<>'#' then addseg(i,j,i+1,j);
           if map[i][j+1]<>'#' then addseg(i,j+1,i+1,j+1);
           if map[i+1][j]<>'#' then addseg(i+1,j,i+1,j+1);
           end;
tot:=0;
for i:=1 to n+1 do
    for j:=1 to m+1 do
        if hash[i][j]=1 then
           begin
           inc(tot); ver[tot].x:=i; ver[tot].y:=j;
           end;
sort(1,tot);
ver[tot+1]:=ver[1];
for i:=1 to tot do
    begin
    line[1].x1:=ver[0].x; line[1].y1:=ver[0].y;
    line[1].x2:=ver[0].x+(ver[i].x-ver[0].x)*inf1; line[1].y2:=ver[0].y+(ver[i].y-ver[0].y)*inf1;
    line[2].x1:=ver[0].x; line[2].y1:=ver[0].y;
    line[2].x2:=ver[0].x+(ver[i+1].x-ver[0].x)*inf1; line[2].y2:=ver[0].y+(ver[i+1].y-ver[0].y)*inf1;
    mmin:=inf2;
    for j:=1 to cnt do
        begin
        if (intersect(line[1],seg[j]))and(intersect(line[2],seg[j])) then
           begin
           p1:=getcommon(line[1],seg[j]); p2:=getcommon(line[2],seg[j]);
           cmin(mmin,abs(cross(ver[0],p1,p2))/2);
           end;
        end;
    ans:=ans-mmin;
    end;
writeln(ans:0:16);
close(input);
close(output);
end.