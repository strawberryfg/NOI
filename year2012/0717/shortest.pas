const base=1000000007;
var i:longint;
    n,m,ans,swap,ret,last:qword;
function mul(std:qword; step:longint):qword;
var ret:qword;
begin
ret:=1;
while step>0 do
  begin
  if step mod 2=1 then ret:=ret*std mod base;
  step:=step div 2;
  std:=std*std mod base;
  end;
exit(ret);
end;
begin
assign(input,'shortest.in');
reset(input);
assign(output,'shortest.out');
rewrite(output);
readln(n,m);
if n<m then begin swap:=n; n:=m; m:=swap; end;
ans:=0;
ans:=(ans+n+1) mod base;
last:=1;
for i:=1 to m do
    begin
    ret:=last*qword(n+i) mod base;
    ret:=ret*mul(i,base-2) mod base;
    ans:=(ans+ret) mod base;
    last:=ret;
    end;
writeln(ans);
close(input);
close(output);
end.
