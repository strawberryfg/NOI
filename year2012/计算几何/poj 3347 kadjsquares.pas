const maxn=51;
type rec=record left,right,len:longint; end;
var n,i,j:longint;
    ans:array[0..maxn]of longint;
    a:array[0..maxn]of rec;
procedure cmax(var x:longint; y:longint);
begin
if y>x then x:=y;
end;
procedure cmin(var x:longint; y:longint);
begin
if y<x then x:=y;
end;
begin
{assign(input,'kadjsquares.in');
reset(input);
assign(output,'kadjsquares.out');
rewrite(output);}
read(n);
while n<>0 do
  begin
  for i:=1 to n do
      begin
      read(a[i].len);
      a[i].left:=0;
      for j:=1 to i-1 do cmax(a[i].left,a[j].right-abs(a[i].len-a[j].len));
      a[i].right:=a[i].left+2*a[i].len;
      end;
  for i:=1 to n do
      begin
      for j:=1 to i-1 do
          if (a[j].left<a[j].right)and(a[j].len>a[i].len) then
             cmax(a[i].left,a[j].right);
      for j:=i+1 to n do
          if (a[j].len>a[i].len) then
             cmin(a[i].right,a[j].left);
      end;
  ans[0]:=0;
  for i:=1 to n do if a[i].left<a[i].right then begin inc(ans[0]); ans[ans[0]]:=i; end;
  for i:=1 to ans[0]-1 do write(ans[i],' '); write(ans[ans[0]]);
  writeln;
  read(n);
  end;
{close(input);
close(output);}
end.