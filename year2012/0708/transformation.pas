var n,i,j:longint;
    tmp,t,ans:qword;
    a:array[0..111]of qword;
function gcd(x,y:qword):qword;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
begin
assign(input,'transformation.in');
reset(input);
assign(output,'transformation.out');
rewrite(output);
read(n);
for i:=1 to n do read(a[i]);
for i:=1 to n do
    begin
    tmp:=a[i];
    for j:=1 to n do
        if i<>j then
           tmp:=gcd(tmp,a[i] div (gcd(a[i],a[j])));
    if tmp=1 then begin a[i]:=1; continue; end;
    ans:=1;
    t:=gcd(tmp,a[i]);
    while t<>1 do begin ans:=ans*t; a[i]:=a[i] div t; t:=gcd(tmp,a[i]); end;
    a[i]:=ans;
    end;
for i:=1 to n do writeln(a[i]);
close(input);
close(output);
end.