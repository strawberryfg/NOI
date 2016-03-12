const inf=maxlongint; eps=1e-14;
var n,i:longint;
    x1,y1,x2,y2,x3,y3,x4,y4,savex1,savey1,savex3,savey3,swap:extended;
    sabc,sabd,xx,yy:extended;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx<-eps then exit(-1);
exit(1);
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
exit(x1*y2-x2*y1);
end;
function dot(x1,y1,x2,y2:extended):extended;
begin
exit(x1*x2+y1*y2);
end;
procedure print(xx,yy:extended);
begin
writeln('POINT ',xx:0:2,' ',yy:0:2);
end;
function online(x1,y1,x2,y2,x3,y3,x4,y4:extended):boolean;
begin
if (cmp(dot(x1-x4,y1-y4,x2-x4,y2-y4))<=0)and(cmp(cross(x1-x4,y1-y4,x2-x4,y2-y4))=0) then begin print(x4,y4); exit(true); end;
if (cmp(dot(x1-x3,y1-y3,x2-x3,y2-y3))<=0)and(cmp(cross(x1-x3,y1-y3,x2-x3,y2-y3))=0) then begin print(x3,y3); exit(true); end;
if (cmp(dot(x3-x2,y3-y2,x4-x2,y4-y2))<=0)and(cmp(cross(x3-x2,y3-y2,x4-x2,y4-y2))=0) then begin print(x2,y2); exit(true); end;
if (cmp(dot(x3-x1,y3-y1,x4-x1,y4-y1))<=0)and(cmp(cross(x3-x1,y3-y1,x4-x1,y4-y1))=0) then begin print(x1,y1); exit(true); end;
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
begin
{assign(input,'intersect.in');
reset(input);
assign(output,'intersect.out');
rewrite(output);}
readln(n);
writeln('INTERSECTING LINES OUTPUT');
for i:=1 to n do
    begin
    readln(x1,y1,x2,y2,x3,y3,x4,y4);
    if abs(cross(x2-x1,y2-y1,x4-x3,y4-y3))<eps then
       begin
       if abs(cross(x2-x1,y2-y1,x3-x2,y3-y2))<eps then writeln('LINE')
          else writeln('NONE');
       end
    else
       begin
       if not online(x1,y1,x2,y2,x3,y3,x4,y4) then
          begin
          sabc:=abs(cross(x2-x1,y2-y1,x3-x1,y3-y1))/2;
          sabd:=abs(cross(x2-x1,y2-y1,x4-x1,y4-y1))/2;
          if intersect(x1,y1,x2,y2,x3,y3,x4,y4) then
             begin
             xx:=(x4*sabc+x3*sabd)/(sabc+sabd);
             yy:=(y4*sabc+y3*sabd)/(sabc+sabd);
             end
          else begin
               xx:=(x4*sabc-x3*sabd)/(sabc-sabd);
               yy:=(y4*sabc-y3*sabd)/(sabc-sabd);
               end;
          print(xx,yy);
          end;
       end;
    end;
writeln('END OF OUTPUT');
{close(input);
close(output);}
end.