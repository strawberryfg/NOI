uses math;
const maxn=333; inf=1e30; eps=1e-16;
type rec=record x,y:extended; end;
var test,now,i,n,id,j,need,ans,start:longint;
    circle,hash,deg:array[0..maxn]of longint;
    a:array[0..maxn]of rec;
    map,mark:array[0..maxn,0..maxn]of longint;
    cnt:longint;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then cmp:=0 else if xx>eps then cmp:=1 else cmp:=-1;
end;
function cross(x1,y1,x2,y2:extended):extended;
begin
cross:=x1*y2-x2*y1;
end;
function dot(x1,y1,x2,y2:extended):extended;
begin
dot:=x1*x2+y1*y2;
end;
function calc(x1,y1,x2,y2:extended):extended;
begin
calc:=arctan2(cross(x1,y1,x2,y2),dot(x1,y1,x2,y2));
end;
function check(st,en:longint):boolean;
var num,i:longint; ret,fmin:extended;
begin
if en=start then begin check:=true; end
   else begin
        if en<>circle[2] then begin inc(circle[0]); circle[circle[0]]:=en; end;
        if (hash[en]=cnt)or(mark[st][en]=now) then
           begin
           check:=false;
           end
        else
        begin
        mark[st][en]:=now;
        hash[en]:=(now-1)*maxn+start;
        fmin:=inf;
        num:=-1;
        for i:=1 to deg[en] do
            begin
            if map[en][i]=st then continue;
            ret:=calc(a[map[en][i]].x-a[en].x,a[map[en][i]].y-a[en].y,a[en].x-a[st].x,a[en].y-a[st].y);
            if cmp(ret-fmin)<0 then
               begin
               fmin:=ret;
               num:=map[en][i];
               end;
            end;
        if num=-1 then check:=false else check:=check(en,num);
        end;
        end;
end;
function workarea:extended;
var i:longint; ret:extended;
begin
ret:=0;
circle[circle[0]+1]:=circle[1];
for i:=1 to circle[0] do
    ret:=ret+cross(a[circle[i]].x,a[circle[i]].y,a[circle[i+1]].x,a[circle[i+1]].y);
ret:=ret/2;
workarea:=ret;
end;
function solve(id:longint):boolean;
var i,first,last,ret1,ret2,pd,k1,k2,next:longint;
    d1,d2:extended;
begin
pd:=0;
first:=circle[2]; last:=circle[circle[0]];
for i:=1 to deg[id] do
    begin
    if (map[id][i]=first)or(map[id][i]=last) then continue;
    ret1:=cmp(cross(a[last].x-a[id].x,a[last].y-a[id].y,a[map[id][i]].x-a[id].x,a[map[id][i]].y-a[id].y));
    ret2:=cmp(cross(a[first].x-a[id].x,a[first].y-a[id].y,a[map[id][i]].x-a[id].x,a[map[id][i]].y-a[id].y));
    if (ret1<=0)and(ret2>=0) then begin pd:=1; break; end;
    end;
if pd=1 then solve:=false else solve:=true;
end;
begin
{assign(input,'farmland.in');
reset(input);
assign(output,'farmland.out');
rewrite(output);}
read(test);
cnt:=0;
for now:=1 to test do
    begin
    read(n);
    for i:=1 to n do
        begin
        read(id);
        read(a[id].x,a[id].y);
        read(deg[id]);
        for j:=1 to deg[id] do read(map[id][j]);
        readln;
        end;
    read(need);
    ans:=0;
    for i:=1 to n do
        begin
        start:=i;
        for j:=1 to deg[i] do
            begin
            inc(cnt);
            circle[0]:=2; circle[1]:=i;
            circle[2]:=map[i][j];
            if (check(i,map[i][j]))and(circle[0]=need)and(cmp(workarea)>0)and(solve(i)) then
               begin
               inc(ans);
               end;
            end;
        end;
    writeln(ans);
    end;
{close(input);
close(output);}
end.