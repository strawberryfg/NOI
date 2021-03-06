const maxn=51; eps=1e-16;
type rec=record id,x,y:longint; end;
var test,n,num,i,posi:longint;
    a:array[0..maxn]of rec;
    ans:array[0..maxn]of longint;
procedure swap(var c,d:rec);
var tmp:rec;
begin
tmp:=c; c:=d; d:=tmp;
end;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
function dist(c,d:rec):extended;
begin
dist:=sqrt((c.x-d.x)*(c.x-d.x)+(c.y-d.y)*(c.y-d.y));
end;
function cross(u,v,w:rec):extended;
begin
cross:=(v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y);
end;
procedure sort(l,r:longint);
var i,j:longint; base:rec;
begin
i:=l; j:=r; base:=a[random(r-l)+l];
repeat
begin
while (cmp(cross(a[posi],a[i],base))>0)or((cmp(cross(a[posi],a[i],base))=0)and(cmp(dist(a[i],a[posi])-dist(base,a[posi]))<0)) do inc(i);
while (cmp(cross(a[posi],a[j],base))<0)or((cmp(cross(a[posi],a[j],base))=0)and(cmp(dist(a[j],a[posi])-dist(base,a[posi]))>0)) do dec(j);
if not(i>j) then begin swap(a[i],a[j]); inc(i); dec(j); end;
end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
begin
{assign(input,'spaceant.in');
reset(input);
assign(output,'spaceant2.out');
rewrite(output);}
randomize;
read(test);
while test>0 do
  begin
  dec(test);
  read(n); num:=-1;
  for i:=1 to n do
      begin
      read(a[i].id,a[i].x,a[i].y);
      if (num=-1)or(a[i].y<a[num].y)or((a[i].y=a[num].y)and(a[i].x<a[num].x)) then num:=i;
      end;
  swap(a[1],a[num]);
  ans[1]:=a[1].id;
  for i:=2 to n do
      begin
      posi:=i-1;
      sort(i,n);
      ans[i]:=a[i].id;
      end;
  write(n,' ');
  for i:=1 to n-1 do write(ans[i],' '); write(ans[n]); writeln;
  end;
{close(input);
close(output);}
end.