const maxn=2000200;
type rec=record x,y:extended; end;
     linetype=record k,b:extended; end;
     stacktype=record id:longint; common:extended; end;
var n,len,i,top,now:longint;
    a:array[0..maxn]of rec;
    line:array[0..maxn]of linetype;
    stack:array[0..maxn]of stacktype;
    ans,res:extended;
procedure sort(l,r:longint);
var i,j,t:longint;swap:rec; cmpx,cmpy:extended;
begin
t:=random(r-l+1)+l;
i:=l; j:=r; cmpx:=a[t].x; cmpy:=a[t].y;
repeat
while (a[i].x<cmpx)or((a[i].x=cmpx)and(a[i].y<cmpy)) do inc(i);
while (cmpx<a[j].x)or((cmpx=a[j].x)and(cmpy<a[j].y)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
begin
assign(input,'mobile.in');
reset(input);
assign(output,'mobile.out');
rewrite(output);
readln(n,len);
randomize;
for i:=1 to n do
    begin
    readln(a[i].x,a[i].y);
    if a[i].y<0 then a[i].y:=-a[i].y;
    end;
sort(1,n);
for i:=1 to n do
    begin
    line[i].k:=-2*a[i].x;
    line[i].b:=a[i].x*a[i].x+a[i].y*a[i].y;
    end;
top:=1; stack[top].id:=1; stack[top].common:=0;
for i:=2 to n do
    begin
    if a[i].x=a[i-1].x then continue;
    while (top>0)and(stack[top].common*line[i].k+line[i].b<stack[top].common*line[stack[top].id].k+line[stack[top].id].b) do dec(top);
    inc(top); stack[top].id:=i;
    if top=1 then stack[top].common:=0
       else stack[top].common:=(line[i].b-line[stack[top-1].id].b)/(line[stack[top-1].id].k-line[i].k);
    end;
ans:=0; now:=-1;
for i:=1 to top do
    begin
    if stack[i].common>len then
       begin
       now:=i;
       break;
       end;
    res:=(a[stack[i].id].x-stack[i].common)*(extended(a[stack[i].id].x)-stack[i].common)+a[stack[i].id].y*a[stack[i].id].y;
    if res>ans then
       ans:=res;
    end;
if now=-1 then now:=top+1;
res:=(a[stack[now-1].id].x-len)*(a[stack[now-1].id].x-len)+a[stack[now-1].id].y*a[stack[now-1].id].y;
if res>ans then ans:=res;
ans:=sqrt(ans);
writeln(round(ans*1000000)/1000000:0:6);
close(input);
close(output);
end.
