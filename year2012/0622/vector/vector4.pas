const maxn=100000; max=10000000;
var n,i,j,now,t:longint;
    a:array[0..maxn,0..4]of longint;
    sta,hash,anssta:array[0..maxn]of longint;
    x,y,tx,ty,px,py,ans,xxx,yyy:int64;
function dis(x,y:int64):int64;
begin
dis:=int64(x)*x+int64(y)*y;
end;
begin
assign(input,'d:\vector\vector5.in');
reset(input);
assign(output,'d:\vector\vector5.out');
rewrite(output);
readln(n);
randomize;
x:=0; y:=0;
for i:=1 to n do
    begin
    for j:=1 to 4 do read(a[i][j]);
    if (a[i][1]>=0)and(a[i][2]>=0) then begin sta[i]:=1; x:=x+a[i][1]; y:=y+a[i][2]; hash[i]:=1; end
       else if (a[i][1]<=0)and(a[i][2]<=0) then begin sta[i]:=-1; x:=x-a[i][1]; y:=y-a[i][2]; hash[i]:=1; end;
    end;
xxx:=x; yyy:=y;
for now:=1 to max div n do
begin
x:=xxx; y:=yyy;
for i:=1 to n do
    begin
    if hash[i]=1 then continue;
    tx:=x; ty:=y;
    px:=x; py:=y;
    tx:=tx+a[i][1]; ty:=ty+a[i][2];
    px:=px-a[i][1]; py:=py-a[i][2];
    t:=random(10);
    if dis(tx,ty)-dis(px,py)>0 then
       begin
       if t<=22222 then
          begin
          sta[i]:=1;
          x:=tx; y:=ty;
          end
       else
          begin
          sta[i]:=-1;
          x:=px; y:=py;
          end;
       end
    else
       begin
       if t<=22222 then
          begin
          sta[i]:=-1;
          x:=px; y:=py;
          end
       else
          begin
          sta[i]:=1;
          x:=tx; y:=ty;
          end;
       end;
    end;
if dis(x,y)>ans then begin ans:=dis(x,y); anssta:=sta; end;
end;
for i:=1 to n do writeln(anssta[i]);
writeln(ans);
//writeln(dis(x,y));
close(input);
close(output);
end.
