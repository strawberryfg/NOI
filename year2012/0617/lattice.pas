//21:07; 22:23;
const max=25;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type node=record x,y:longint; end;
     rec=array[0..max]of node;
var n,w,h,ans,i:longint;
    vis:array[0..max,-max..max]of longint;
    block:rec;
procedure add(var a:rec; var num:longint; nx,ny:longint);
begin
inc(num); a[num].x:=nx; a[num].y:=ny;
end;
procedure sort(var a:rec;l,r:longint);
var i,j,cmpx,cmpy:longint; swap:node;
begin
i:=l; j:=r; cmpx:=a[(l+r) div 2].x; cmpy:=a[(l+r) div 2].y;
repeat
while (a[i].x<cmpx)or((a[i].x=cmpx)and(a[i].y<cmpy)) do inc(i);
while (cmpx<a[j].x)or((cmpx=a[j].x)and(cmpy<a[j].y)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(a,l,j);
if i<r then sort(a,i,r);
end;
procedure print(cmp:rec);
var i,j,k:longint;
begin
writeln('No. ',ans,' : ');
j:=1; k:=1;
while k<=n do
  begin
  for i:=j to cmp[k].y-1 do write(' ');
  write('* ');
  if k=n then begin writeln; break; end;
  if cmp[k].x<cmp[k+1].x then begin writeln; j:=1; end
     else j:=cmp[k].y+1;
  inc(k);
  end;
end;
procedure check;
var cmp,fmin:rec;
    flag,ll,rr,del,height,i:longint;
  procedure horizontal;
  var i:longint;
  begin
  for i:=1 to n do cmp[i].y:=rr+1-cmp[i].y;
  end;
  procedure vertical;
  var i:longint;
  begin
  for i:=1 to n do cmp[i].x:=height+1-cmp[i].x;
  end;
  procedure rotateclockwise;
  var i,tmp:longint;
  begin
  for i:=1 to n do
      begin
      tmp:=cmp[i].x; cmp[i].x:=cmp[i].y; cmp[i].y:=height+1-tmp;
      end;
  end;
  procedure cmpmin;
  var i:longint;
  begin
  for i:=1 to n do
      begin
      if cmp[i].x<fmin[i].x then begin flag:=0; exit; end
         else if (cmp[i].x=fmin[i].x) then
                 begin
                 if (cmp[i].y<fmin[i].y) then begin flag:=0; exit; end
                    else if (cmp[i].y>fmin[i].y) then exit;
                 end
              else exit;
      end;
  end;
begin
cmp:=block; sort(cmp,1,n);
ll:=max; rr:=-max;
for i:=1 to n do begin if cmp[i].y<ll then ll:=cmp[i].y; if cmp[i].y>rr then rr:=cmp[i].y; end;
del:=1-ll; rr:=rr+del;
height:=cmp[n].x;
if height>rr then exit;
if (height>h)or(rr>w) then exit;
for i:=1 to n do cmp[i].y:=cmp[i].y+del;
fmin:=cmp;
flag:=1;
if height<rr then
   begin
   horizontal; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   horizontal; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   end
else
   begin
   horizontal; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   rotateclockwise; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   horizontal; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   rotateclockwise; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   rotateclockwise; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   rotateclockwise; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   vertical; sort(cmp,1,n); cmpmin; if flag=0 then exit;
   end;
inc(ans);
end;
procedure work(num,last:longint); //num:blocks that have been painted  from last to num a stage
var i,j,tx,ty,sum:longint;
    sta:rec;
   procedure dfs(dep,cnt:longint);
   var i:longint;
   begin
   if dep>sum then
      begin
      if (cnt>0)and(num<=n) then work(num,last);
      exit;
      end;
   for i:=0 to 1 do
       begin
       if i=1 then begin add(block,num,sta[dep].x,sta[dep].y); dfs(dep+1,cnt+1); dec(num); end
          else dfs(dep+1,cnt);
       end;
   end;
begin
if num=n then
   begin
   check;
   exit;
   end;
sum:=0;
for i:=last to num do
    begin
    for j:=1 to 4 do
        begin
        tx:=block[i].x+dx[j]; ty:=block[i].y+dy[j];
        if vis[tx][ty]=0 then
           begin
           add(sta,sum,tx,ty);
           vis[tx][ty]:=-1;
           end;
        end;
    end;
last:=num+1;
dfs(1,0);
for i:=1 to sum do vis[sta[i].x][sta[i].y]:=0;
end;
begin
assign(input,'lattice.in');
reset(input);
assign(output,'lattice.out');
rewrite(output);
readln(n,w,h);
if w<h then begin w:=w+h; h:=w-h; w:=w-h; end;
ans:=0;
vis[1][1]:=1;  //used;
block[1].x:=1; block[1].y:=1;
for i:=-max to max do vis[0][i]:=-1;
for i:=-max to 0 do vis[1][i]:=-1;
work(1,1);
writeln(ans);
close(input);
close(output);
end.