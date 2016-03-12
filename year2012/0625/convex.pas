const maxn=26; eps=1e-12;
type rec=record x,y:longint; end;
     arr=array[0..maxn]of longint;
var test,i,j,n,top:longint;
    ans:extended;
    a:array[0..maxn]of rec;
    stack,flag:array[0..2*maxn]of longint;
    spe:arr;
procedure sort(l,r:longint;var b:arr);
var i,j,cmpx,cmpy,swap:longint;
begin
i:=l; j:=r; cmpx:=a[b[(l+r) div 2]].x; cmpy:=a[b[(l+r) div 2]].y;
repeat
while (a[b[i]].x<cmpx)or((a[b[i]].x=cmpx)and(a[b[i]].y<cmpy)) do inc(i);
while (cmpx<a[b[j]].x)or((cmpx=a[b[j]].x)and(cmpy<a[b[j]].y)) do dec(j);
if not(i>j) then begin swap:=b[i]; b[i]:=b[j]; b[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j,b);
if i<r then sort(i,r,b);
end;
function cross(u,v,w:longint):longint;
begin
exit((a[v].x-a[u].x)*(a[w].y-a[u].y)-(a[w].x-a[u].x)*(a[v].y-a[u].y));
end;
procedure dfs(x,cnt:longint; b:arr);
var i,j,k,pd,opt,check:longint; res:extended;
begin
if x>n then
   begin
   if cnt<3 then exit;
   sort(1,cnt,b);
   top:=0;
   for i:=1 to cnt do
       begin
       while (top>1)and(cross(stack[top-1],stack[top],b[i])<0) do dec(top);
       inc(top); stack[top]:=b[i];
       end;
   k:=top;
   for i:=cnt-1 downto 1 do
       begin
       while (top>k)and(cross(stack[top-1],stack[top],b[i])<0) do dec(top);
       inc(top); stack[top]:=b[i];
       end;
   dec(top);
   if top<>cnt then exit;
   for i:=1 to n do
       begin
       if flag[i]=1 then continue;
       res:=0.0; a[n+1].x:=a[i].x; a[n+1].y:=a[i].y;
       stack[top+1]:=stack[1];
       pd:=-2; check:=0;
       for j:=1 to top do
           begin
           res:=cross(n+1,stack[j+1],stack[j]);
           if res>0 then opt:=1 else if res<0 then opt:=-1 else opt:=0;
           if (pd<>-2)and(opt<>0)and(opt<>pd) then begin check:=1; break; end;
           if opt<>0 then pd:=opt;
           end;
       if check=0 then exit;
       end;
   res:=0.0; a[0].x:=0; a[0].y:=0; stack[top+1]:=stack[1];
   for i:=1 to top do res:=res+cross(0,stack[i],stack[i+1]);
   res:=res/2;
   res:=abs(res);
   if res-ans>eps then ans:=res;
   exit;
   end;
for i:=0 to 1 do
    begin
    if i=0 then dfs(x+1,cnt,b)
       else begin
            b[cnt+1]:=x;
            flag[x]:=1;
            dfs(x+1,cnt+1,b);
            flag[x]:=0;
            end;
    end;
end;
begin
assign(input,'convex.in');
reset(input);
assign(output,'convex.out');
rewrite(output);
readln(test);
for i:=1 to test do
    begin
    readln(n);
    for j:=1 to n do read(a[j].x,a[j].y);
    ans:=0.0;
    dfs(1,0,spe);
    writeln(round(ans*10)/10:0:1);
    end;
close(input);
close(output);
end.