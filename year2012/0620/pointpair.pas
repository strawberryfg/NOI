const maxn=300000; inf=5555555555555555555; eps=1e-12;
type rec=record x,y:extended; end;
var n,i,j,k,top,ll,rr,num:longint;
    tmp,mindis,maxdis,ret,fmax,now:extended;
    a:array[0..maxn]of rec;
    stack:array[0..maxn]of longint;
procedure sort(l,r:longint);
var i,j:longint; swap:rec; cmpx,cmpy:extended;
begin
i:=l; j:=r; cmpx:=a[(l+r) div 2].x; cmpy:=a[(l+r) div 2].y;
repeat
while (cmpx-a[i].x>eps)or((abs(cmpx-a[i].x)<eps)and(cmpy-a[i].y>eps)) do inc(i);
while (a[j].x-cmpx>eps)or((abs(a[j].x-cmpx)<eps)and(a[j].y-cmpy>eps)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function cross(u,v,w:longint):boolean;
var res:extended;
begin
res:=(a[v].x-a[u].x)*(a[w].y-a[u].y)-(a[w].x-a[u].x)*(a[v].y-a[u].y);
if 0-res>eps then exit(true) else exit(false);
end;
function calc(u,v:longint):extended;
var res:extended;
begin
res:=sqrt((a[u].x-a[v].x)*(a[u].x-a[v].x)+(a[u].y-a[v].y)*(a[u].y-a[v].y));
exit(res);
end;
begin
assign(input,'pointpair.in');
reset(input);
assign(output,'pointpair.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i].x,a[i].y);
if n<=2000 then
   begin
   mindis:=inf; maxdis:=-inf;
   for i:=1 to n-1 do
       for j:=i+1 to n do
           begin
           tmp:=calc(i,j);
           if tmp-maxdis>eps then maxdis:=tmp;
           if abs(tmp-12.55077686838547855)<eps then
              top:=top;
           if mindis-tmp>eps then mindis:=tmp;
           end;
   writeln(round(mindis*100)/100:0:2,' ',round(maxdis*100)/100:0:2);
   end
else
   begin
   sort(1,n);
   top:=0;
   for i:=1 to n do
       begin
       while (top>1)and(cross(stack[top-1],stack[top],i)) do dec(top);
       inc(top); stack[top]:=i;
       end;
   k:=top;
   for i:=n-1 downto 1 do
       begin
       while (top>k)and(cross(stack[top-1],stack[top],i)) do dec(top);
       inc(top); stack[top]:=i;
       end;
   dec(top);
   num:=-1; fmax:=-inf;
   for i:=2 to top do
       begin
       tmp:=calc(stack[i],stack[1]);
       if tmp-fmax>eps then begin fmax:=tmp; num:=i; end;
       end;
   rr:=num;
   for ll:=2 to top do
       begin
       now:=calc(stack[ll],stack[rr]);
       while true do
         begin
         inc(rr);
         if rr>top then rr:=1;
         ret:=calc(stack[ll],stack[rr]);
         if ret-now>eps then now:=ret else begin dec(rr); if rr=0 then rr:=top; break; end;
         end;
       if now-fmax>eps then fmax:=now;
       end;
   writeln(round(fmax*100)/100:0:2,' ',round(fmax*100)/100:0:2);
   end;
close(input);
close(output);
end.