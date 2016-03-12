//09:32;
const maxn=1020; inf=5555555555555555555;
type rec=record x,y:extended; id:longint; end;
var n,i,j:longint;
    a,b,sa,sb:array[0..maxn]of extended;
    head,tail:array[0..maxn]of longint;
    stack:array[0..maxn,0..maxn]of rec;
    f:array[0..maxn,0..maxn]of extended;
    res,ans:extended;
function max(x,y:extended):extended; begin if x>y then max:=x else max:=y; end;
function cross(opt:longint; ny,nx:extended):boolean;
begin
res:=(stack[opt][tail[opt]].y-ny)*(stack[opt][tail[opt]-1].x-stack[opt][tail[opt]].x);
res:=res-(stack[opt][tail[opt]-1].y-stack[opt][tail[opt]].y)*(stack[opt][tail[opt]].x-nx);
if res>=0 then cross:=true else cross:=false;
end;
procedure add(opt,nowid:longint; ny,nx:extended);
begin
while (head[opt]<tail[opt])and(cross(opt,ny,nx)) do dec(tail[opt]);
inc(tail[opt]);
stack[opt][tail[opt]].x:=nx; stack[opt][tail[opt]].y:=ny; stack[opt][tail[opt]].id:=nowid;
end;
function check(opt:longint; num:extended):boolean;
begin
res:=stack[opt][head[opt]].y-stack[opt][head[opt]+1].y-num*(stack[opt][head[opt]].x-stack[opt][head[opt]+1].x);
if res<=0 then check:=true else check:=false;
end;
procedure delete(opt:longint; num:extended);
begin
while (head[opt]<tail[opt])and(check(opt,num)) do inc(head[opt]);
end;
begin
assign(input,'baabo.in');
reset(input);
assign(output,'baabo.out');
rewrite(output);
readln(n);
sa[0]:=0; sb[0]:=0;
for i:=1 to n do begin readln(a[i]); sa[i]:=sa[i-1]+a[i]; end;
for i:=1 to n do begin readln(b[i]); sb[i]:=sb[i-1]+b[i]; end;
for i:=1 to n do
    for j:=1 to n do
        f[i][j]:=a[i]*b[j]-sa[i-1]*sa[i-1]-sb[j-1]*sb[j-1];
for i:=1 to n-1 do begin head[i]:=1; tail[i]:=0; end;
for i:=1 to n do
    begin
    head[0]:=1; tail[0]:=0;
    for j:=1 to n do
        begin
        if (i>1)and(j>1) then
           begin
           add(0,j-1,f[i-1][j-1]-sb[j-1]*sb[j-1],sb[j-1]);
           add(j-1,i-1,f[i-1][j-1]-sa[i-1]*sa[i-1],sa[i-1]);
           delete(0,-2*sb[j-1]);
           delete(j-1,-2*sa[i-1]);
           f[i][j]:=max(f[i][j],f[i-1][stack[0][head[0]].id]-(sb[j-1]-sb[stack[0][head[0]].id])*(sb[j-1]-sb[stack[0][head[0]].id])+a[i]*b[j]);
           f[i][j]:=max(f[i][j],f[stack[j-1][head[j-1]].id][j-1]-(sa[i-1]-sa[stack[j-1][head[j-1]].id])*(sa[i-1]-sa[stack[j-1][head[j-1]].id])+a[i]*b[j]);
           end;
        end;
    end;
ans:=-inf;
for i:=1 to n do
    for j:=1 to n do
        ans:=max(ans,f[i][j]-(sa[n]-sa[i])*(sa[n]-sa[i])-(sb[n]-sb[j])*(sb[n]-sb[j]));
writeln(int64(trunc(ans)));
close(input);
close(output);
end.