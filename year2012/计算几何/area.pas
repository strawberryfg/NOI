const maxn=1111; eps=1e-16;
type point=record x,y:extended; end;
var n,m,i:longint;
    a,b,ver:array[0..maxn]of point;
    ans:extended;
    retx,rety:extended;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
procedure saveit(xx,yy:extended);
begin
retx:=xx; rety:=yy;
end;
function cross2(u,v,w:point):extended;
begin
cross2:=(v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y);
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
cross:=x1*y2-x2*y1;
end;
function dot(x1,y1,x2,y2:extended):extended;
begin
exit(x1*x2+y1*y2);
end;
function online(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
begin
if (cmp(dot(x1-x4,y1-y4,x2-x4,y2-y4))<=0)and(cmp(cross(x1-x4,y1-y4,x2-x4,y2-y4))=0) then begin saveit(x4,y4); exit(true); end;
if (cmp(dot(x1-x3,y1-y3,x2-x3,y2-y3))<=0)and(cmp(cross(x1-x3,y1-y3,x2-x3,y2-y3))=0) then begin saveit(x3,y3); exit(true); end;
if (cmp(dot(x3-x2,y3-y2,x4-x2,y4-y2))<=0)and(cmp(cross(x3-x2,y3-y2,x4-x2,y4-y2))=0) then begin saveit(x2,y2); exit(true); end;
if (cmp(dot(x3-x1,y3-y1,x4-x1,y4-y1))<=0)and(cmp(cross(x3-x1,y3-y1,x4-x1,y4-y1))=0) then begin saveit(x1,y1); exit(true); end;
exit(false);
end;
function intersect(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
var res:longint;
begin
res:=cmp(cross(x1-x3,y1-y3,x4-x3,y4-y3))*cmp(cross(x2-x3,y2-y3,x4-x3,y4-y3));
if res>0 then exit(false);
res:=cmp(cross(x3-x1,y3-y1,x2-x1,y2-y1))*cmp(cross(x4-x1,y4-y1,x2-x1,y2-y1));
if res>0 then exit(false);
exit(true);
end;
function getcommon(pa,pb,pc,pd:point):point;
var sabc,sabd,x1,y1,x2,y2,x3,y3,x4,y4:extended;
begin
x1:=pa.x; y1:=pa.y; x2:=pb.x; y2:=pb.y; x3:=pc.x; y3:=pc.y; x4:=pd.x; y4:=pd.y;
if online(x1,y1,x2,y2,x3,y3,x4,y4) then begin getcommon.x:=retx; getcommon.y:=rety; exit; end;
sabc:=abs(cross(x2-x1,y2-y1,x3-x1,y3-y1))/2;
sabd:=abs(cross(x2-x1,y2-y1,x4-x1,y4-y1))/2;
if intersect(x1,y1,x2,y2,x3,y3,x4,y4) then
   begin
   getcommon.x:=(x4*sabc+x3*sabd)/(sabc+sabd);
   getcommon.y:=(y4*sabc+y3*sabd)/(sabc+sabd);
   end
else begin
     getcommon.x:=(x4*sabc-x3*sabd)/(sabc-sabd);
     getcommon.y:=(y4*sabc-y3*sabd)/(sabc-sabd);
     end;
end;
procedure cut(p1,p2,p3:point);
var i,tot:longint; save,last,tmp:extended;
begin
if n=0 then exit;
save:=cross2(p1,p2,p3);
tot:=0;
last:=cross2(p1,p2,a[1]);
if last*save>=0 then begin inc(tot); ver[tot]:=a[1]; end;
for i:=2 to n+1 do
    begin
    tmp:=cross2(p1,p2,a[i]);
    if cmp(tmp*last)<0 then
       begin
       inc(tot); ver[tot]:=getcommon(a[i-1],a[i],p1,p2);
       end;
    if i=n+1 then break;
    if cmp(tmp*save)>=0 then begin inc(tot); ver[tot]:=a[i]; end;
    last:=tmp;
    end;
n:=tot;
a:=ver;
a[n+1]:=a[1];
end;
begin
assign(input,'area.in');
reset(input);
assign(output,'area.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i].x,a[i].y);
a[n+1]:=a[1];
readln(m);
for i:=1 to m do readln(b[i].x,b[i].y);
b[m+1]:=b[1]; b[m+2]:=b[2];
for i:=1 to m do cut(b[i],b[i+1],b[i+2]);
a[n+1]:=a[1];
ans:=0.0;
for i:=1 to n do ans:=ans+cross(a[i].x,a[i].y,a[i+1].x,a[i+1].y);
ans:=abs(ans)/2;
writeln(ans:0:3);
close(input);
close(output);
end.