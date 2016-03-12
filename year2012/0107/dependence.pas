const maxbina=2048; maxm=1020;
var n,m,t,x,y,c,i,j,sum:longint;
    res,hash:array[0..maxbina]of longint;
    can:array[0..maxbina,0..maxm]of longint;
    a:array[0..maxm]of record x,y:longint; end;
    s,tmp:string;
    pd:boolean;
    ans:array[0..maxbina]of string;
procedure work(x:longint);
var t,p,i:longint;
begin
t:=x;
while true do
  begin
  p:=t;
  for i:=1 to m do
      begin
      if (can[t][i]=1) then
         begin
         p:=p or a[i].y;
         end;
      end;
  if p=t then break;
  if p=1 shl n-1 then
     begin
     inc(sum);
     res[sum]:=x;
     hash[x]:=1;
     end;
  t:=p;
  end;
end;
begin
assign(input,'dependence.in');
reset(input);
assign(output,'dependence.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(s);
    t:=pos('-',s);
    x:=0; y:=0;
    for j:=1 to t-1 do
        begin
        c:=ord(s[j])-ord('A')+1;
        x:=x or 1 shl (c-1);
        end;
    delete(s,1,t+1);
    for j:=1 to length(s) do
        begin
        c:=ord(s[j])-ord('A')+1;
        y:=y or 1 shl (c-1);
        end;
    a[i].x:=x; a[i].y:=y;
    end;
for i:=0 to 1 shl n-1 do
    begin
    for j:=1 to m do
        begin
        if (i and a[j].x=a[j].x) then can[i][j]:=1;
        end;
    end;
for i:=0 to 1 shl n-1 do
    begin
    pd:=false;
    j:=i; t:=i;
    while (t>0) do
      begin
      t:=(t-1)and j;
      if hash[t]=1 then begin pd:=true; break; end;
      end;
    if not pd then
       begin
       work(i);
       end;
    end;
for i:=1 to sum do
    begin
    x:=res[i];
    ans[i]:='';
    for j:=1 to n do
        begin
        if x and (1 shl (j-1))<>0 then
           begin
           ans[i]:=ans[i]+char(64+j);
           end;
        end;
    end;
for i:=1 to sum-1 do
    for j:=i+1 to sum do
        begin
        if ans[i]>ans[j] then
           begin
           tmp:=ans[i]; ans[i]:=ans[j]; ans[j]:=tmp;
           end;
        end;
if sum<>0 then writeln(sum);
for i:=1 to sum do writeln(ans[i]);
if sum=0 then writeln('No candidate key');
close(input);
close(output);
end.
