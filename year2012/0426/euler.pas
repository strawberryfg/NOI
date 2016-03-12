const maxline=1000020; maxn=1000200; eps=1e-12;
type rec=record x,y:extended; end;
     re=record x1,x2,y1,y2:longint; end;
     typ=record x,y:longint; end;
var n,x,y,lx,ly,vertex,now,tmpnow,cnt,tot,i,j,k,edge,flag,tnow,test,sum,total:longint;
    line:array[0..maxline]of re;
    a,b:array[0..maxn]of rec;
    v:array[0..maxn]of typ;
function min(xx,yy:extended):extended;
begin
if xx-yy>eps then exit(yy) else exit(xx);
end;
function max(xx,yy:extended):extended;
begin
if xx-yy>eps then exit(xx) else exit(yy);
end;
procedure cross(u,v:longint);
var a1,a2,b1,b2,c1,c2,x,y,minx,maxx,miny,maxy:extended;
begin
if line[u].x1=line[u].x2 then begin a1:=1; b1:=0; c1:=-line[u].x1; end
   else if line[u].y1=line[u].y2 then begin a1:=0; b1:=1; c1:=-line[u].y1; end
           else begin
                a1:=-(line[u].y1-line[u].y2)/(line[u].x1-line[u].x2);
                b1:=1; c1:=-(a1*line[u].x1+b1*line[u].y1);
                end;
if line[v].x1=line[v].x2 then begin a2:=1; b2:=0; c2:=-line[v].x1; end
   else if line[v].y1=line[v].y2 then begin a2:=0; b2:=1; c2:=-line[v].y1; end
           else begin
                a2:=-(line[v].y1-line[v].y2)/(line[v].x1-line[v].x2);
                b2:=1; c2:=-(a2*line[v].x1+b2*line[v].y1);
                end;
if a1*b2-a2*b1=0 then exit;
y:=(a2*c1-a1*c2)/(a1*b2-a2*b1);
x:=(c2*b1-c1*b2)/(a1*b2-a2*b1);
minx:=min(line[u].x1,line[u].x2); maxx:=max(line[u].x1,line[u].x2);
if (minx-x>eps)or(x-maxx>eps) then exit;
miny:=min(line[u].y1,line[u].y2); maxy:=max(line[u].y1,line[u].y2);
if (miny-y>eps)or(y-maxy>eps) then exit;
minx:=min(line[v].x1,line[v].x2); maxx:=max(line[v].x1,line[v].x2);
if (minx-x>eps)or(x-maxx>eps) then exit;
miny:=min(line[v].y1,line[v].y2); maxy:=max(line[v].y1,line[v].y2);
if (miny-y>eps)or(y-maxy>eps) then exit;
if (abs(line[u].x1-x)<eps)and(abs(line[u].y1-y)<eps) then exit;
if (abs(line[u].x2-x)<eps)and(abs(line[u].y2-y)<eps) then exit;
inc(tot);
a[tot].x:=x; a[tot].y:=y;
end;
procedure sort(l,r: longint);
var i,j: longint;
    xx,yy:extended;
    tmp:rec;
begin
i:=l; j:=r; xx:=a[(l+r) div 2].x; yy:=a[(l+r)div 2].y;
repeat
while (xx-a[i].x>eps)or((abs(xx-a[i].x)<eps)and(yy-a[i].y>eps)) do inc(i);
while (a[j].x-xx>eps)or((abs(a[j].x-xx)<eps)and(a[j].y-yy>eps)) do dec(j);
if not(i>j) then begin tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r: longint);
var i,j,xx,yy: longint;
    tmp:typ;
begin
i:=l; j:=r; xx:=v[(l+r) div 2].x; yy:=v[(l+r)div 2].y;
repeat
while (v[i].x<xx)or((v[i].x=xx)and(v[i].y<yy)) do inc(i);
while (xx<v[j].x)or((xx=v[j].x)and(yy<v[j].y)) do dec(j);
if not(i>j) then begin tmp:=v[i]; v[i]:=v[j]; v[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
begin
assign(input,'euler.in');
reset(input);
assign(output,'euler.out');
rewrite(output);
readln(n);
test:=0;
while n<>0 do
  begin
  inc(test);
  cnt:=0; vertex:=0; edge:=0;
  lx:=0; ly:=0;
  sum:=0;
  for i:=1 to n do
      begin
      read(x,y);
      inc(sum);
      v[sum].x:=x; v[sum].y:=y;
      if i<>1 then
         begin
         inc(cnt);
         line[cnt].x1:=lx; line[cnt].y1:=ly; line[cnt].x2:=x; line[cnt].y2:=y;
         end;
      lx:=x; ly:=y;
      end;
  sort2(1,sum);
  i:=1;
  while i<=sum do
    begin
    j:=i;
    while (j+1<=sum)and(v[i].x=v[j+1].x)and(v[i].y=v[j+1].y) do inc(j);
    inc(vertex);
    i:=j+1;
    end;
  now:=0;
  for i:=1 to cnt do
      begin
      tot:=0;
      for j:=1 to cnt do
          begin
          if i=j then continue;
          cross(i,j);
          end;
      sort(1,tot);
      j:=1;
      while j<=tot do
        begin
        k:=j;
        while (k+1<=tot)and(abs(a[k+1].x-a[k].x)<eps)and(abs(a[k+1].y-a[k].y)<eps) do inc(k);
        inc(now);
        b[now].x:=a[j].x; b[now].y:=a[j].y;
        j:=k+1;
        end;
      end;
  a:=b;
  tmpnow:=now;
  sort(1,now);
  total:=0;
  i:=1;
  while i<=now do
    begin
    j:=i;
    while (j+1<=now)and(abs(a[j+1].x-a[j].x)<eps)and(abs(a[j+1].y-a[j].y)<eps) do inc(j);
    inc(total); b[total].x:=a[i].x; b[total].y:=a[i].y;
    i:=j+1;
    end;
  now:=total;
  tnow:=0;
  for i:=1 to now do
      begin
      flag:=0;
      for j:=1 to cnt do
          begin
          if (abs(line[j].x1-b[i].x)<eps)and(abs(line[j].y1-b[i].y)<eps) then begin flag:=1; break; end;
          if (abs(line[j].x2-b[i].x)<eps)and(abs(line[j].y2-b[i].y)<eps) then begin flag:=1; break; end;
          end;
      if flag=0 then inc(tnow);
      end;
  edge:=edge+tmpnow+cnt;
  vertex:=vertex+tnow;
{  writeln('edge: ',edge);
  writeln('vertex: ',vertex);}
  writeln('Case ',test,': There are ',edge-vertex+2,' pieces.');
  readln(n);
  end;
close(input);
close(output);
end.
