const maxn=11111; maxx=20; maxtime=20; inf=1e30; eps=1e-16; eps2=0.02; rate=0.8;
type rec=record x,y,res:extended; end;
var now,test,allx,ally,kind,i,j,opt:longint;
    t,ansx,ansy,ans,xx,yy,mmax,numx,numy,res:extended;
    a,b:array[0..maxn]of rec;
function cmp(num:extended):longint;
begin
if abs(num)<eps then exit(0);
if num>eps then exit(1);
exit(-1);
end;
function dist(x1,y1,x2,y2:extended):extended;
begin
dist:=((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
end;
function calc(nx,ny:extended):extended;
var ret,res:extended; i:longint;
begin
ret:=inf;
for i:=1 to kind do begin res:=dist(a[i].x,a[i].y,nx,ny); if cmp(res-ret)<0 then ret:=res; end;
exit(ret);
end;
begin
{assign(input,'runaway.in');
reset(input);
assign(output,'runaway.out');
rewrite(output);}
randomize;
read(test);
for now:=1 to test do
    begin
    read(allx,ally,kind);
    for i:=1 to kind do read(a[i].x,a[i].y);
    for i:=1 to maxx do
        begin
        b[i].x:=random(allx)+1; b[i].y:=random(ally)+1;
        b[i].res:=calc(b[i].x,b[i].y);
        end;
    t:=dist(0,0,allx,ally);
    ansx:=1.0; ansy:=1.0; ans:=0.0;
    while t>eps2 do
      begin
      for i:=1 to maxx do
          begin
          numx:=0.0; numy:=0.0; mmax:=-inf;
          for j:=1 to maxtime do
              begin
              opt:=random(2);
              if opt=0 then
                 begin
                 xx:=random(100)/100;
                 yy:=sqrt(1-xx*xx)*t;
                 xx:=xx*t;
                 if (cmp(allx-(b[i].x+xx))>=0)and(cmp(ally-(b[i].y+yy))>=0) then
                    begin
                    res:=calc(b[i].x+xx,b[i].y+yy);
                    if cmp(res-mmax)>0 then
                       begin
                       mmax:=res;
                       numx:=b[i].x+xx;
                       numy:=b[i].y+yy;
                       end;
                    end;
                 if (cmp(allx-(b[i].x+xx))>=0)and(cmp(b[i].y-yy)>=0) then
                    begin
                    res:=calc(b[i].x+xx,b[i].y-yy);
                    if cmp(res-mmax)>0 then
                       begin
                       mmax:=res;
                       numx:=b[i].x+xx;
                       numy:=b[i].y-yy;
                       end;
                    end;
                 end
              else
                 begin
                 xx:=-(random(100)+1)/100;
                 yy:=sqrt(1-xx*xx)*t;
                 xx:=xx*t;
                 if (cmp(b[i].x+xx)>=0)and(cmp(ally-(b[i].y+yy))>=0) then
                    begin
                    res:=calc(b[i].x+xx,b[i].y+yy);
                    if cmp(res-mmax)>0 then
                       begin
                       mmax:=res;
                       numx:=b[i].x+xx;
                       numy:=b[i].y+yy;
                       end;
                    end;
                 if (cmp(b[i].x+xx)>=0)and(cmp(b[i].y-yy)>=0) then
                    begin
                    res:=calc(b[i].x+xx,b[i].y-yy);
                    if cmp(res-mmax)>0 then
                       begin
                       mmax:=res;
                       numx:=b[i].x+xx;
                       numy:=b[i].y-yy;
                       end;
                    end;
                 end;
              end;
          if cmp(mmax-b[i].res)>0 then begin b[i].res:=mmax; b[i].x:=numx; b[i].y:=numy; end;
          if cmp(b[i].res-ans)>0 then begin ans:=b[i].res; ansx:=b[i].x; ansy:=b[i].y; end;
          end;
      t:=t*rate;
      end;
    writeln('The safest point is (',ansx:0:1,', ',ansy:0:1,').')
    end;
{close(input);
close(output);}
end.