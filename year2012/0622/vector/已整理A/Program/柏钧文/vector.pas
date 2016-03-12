type re=array[1..4]of longint;
var n,i,j,t,cas:longint;
    a:array[0..200001]of re;
    f:array[0..200001,0..1]of re;
    pre:array[0..200001,0..1]of longint;
    ans:array[0..200001]of longint;
    s,s1,s2:string;
    
function calc(a:re):longint;
  var sum,i:longint;
  begin
  sum:=0;
  for i:=1 to 4 do
      sum:=sum+sqr(a[i]);
  exit(sum);
  end;

function jia(a,ta:re;tip:longint):re;
  var i:longint;
  begin
  if tip=0 then
     begin
     for i:=1 to 4 do
         a[i]:=a[i]-ta[i];
     end
     else
     begin
     for i:=1 to 4 do
         a[i]:=a[i]+ta[i];
     end;
  exit(a);
  end;

function pan(a,ta:re;tip:longint;b:re):boolean;
  var t1,t2,i:longint;
  begin
  if tip=0 then
     begin
     for i:=1 to 4 do
         a[i]:=a[i]-ta[i];
     end
     else
     begin
     for i:=1 to 4 do
         a[i]:=a[i]+ta[i];
     end;
  t1:=calc(ta);t2:=calc(b);
  if t1>=t2 then exit(true) else exit(false);
  end;

function check(a,b:re):boolean;
  var t1,t2:longint;
  begin
  t1:=calc(a);t2:=calc(b);
  if t1>t2 then exit(true) else exit(false);
  end;

begin
assign(input,'vector.in');reset(input);
assign(output,'vector.out');rewrite(output);
readln(n);
for i:=1 to n do
  begin
    for j:=1 to 4 do
    read(a[i,j]);
  readln;
  end;
fillchar(f,sizeof(f),0);fillchar(pre,sizeof(pre),0);
for i:=1 to n do
    for j:=0 to 1 do
    begin
    if pan(f[i-1,0],a[i],j,f[i,j]) then begin f[i,j]:=jia(f[i-1,0],a[i],j);t:=0;end;
    if pan(f[i-1,1],a[i],j,f[i,j]) then begin f[i,j]:=jia(f[i-1,1],a[i],j);t:=1; end;
    pre[i,j]:=t;
    end;
if check(f[n,0],f[n,1]) then t:=0 else t:=1;
for i:=n downto 1 do
    begin
    if t=1 then ans[i]:=1
       else ans[i]:=-1;
    t:=pre[i,t];
    end;
//writeln(calc(f[n,1]));
for i:=1 to n do
    writeln(ans[i]);
//while true do i:=i;
close(input);close(output);
end.
