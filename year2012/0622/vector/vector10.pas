const maxn=100000; max=600000000;
type rec=array[1..4]of int64;
var n,i,j,now,t:longint;
    a:array[0..maxn,0..4]of longint;
    sta,hash,anssta:array[0..maxn]of longint;
//    x,y,tx,ty,px,py,ans,xxx,yyy:int64;
    d,td,pd:rec;
    ans:int64;
function dis(x:rec):int64;
var i:longint;
begin
dis:=0;
for i:=1 to 4 do dis:=dis+x[i]*x[i];
end;
begin
assign(input,'d:\vector\vector10.in');
reset(input);
assign(output,'d:\vector\vector10.out');
rewrite(output);
readln(n);
randomize;
for i:=1 to n do
    begin
    for j:=1 to 4 do read(a[i][j]);
    end;

begin
for i:=1 to 4 do d[i]:=0;
for i:=1 to n do
    begin
    for j:=1 to 4 do begin td[j]:=d[j]+a[i][j]; pd[j]:=d[j]-a[i][j]; end;
    t:=random(10);
    if dis(td)-dis(pd)>0 then
       begin
       if t<=55 then
          begin
          sta[i]:=1;
          d:=td;
          end
       else
          begin
          sta[i]:=-1;
          d:=pd;
          end;
       end
    else
       begin
       if t<=55 then
          begin
          sta[i]:=-1;
          d:=pd;
          end
       else
          begin
          sta[i]:=1;
          d:=td;
          end;
       end;
    end;
if dis(d)>ans then begin ans:=dis(d); anssta:=sta; end;
end;
for i:=1 to n do writeln(anssta[i]);
writeln(ans);
//writeln(dis(x,y));
close(input);
close(output);
end.
