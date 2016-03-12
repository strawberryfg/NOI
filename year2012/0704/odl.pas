const max=1000020; maxn=1000020; inf=maxlongint;
var cnt,i,j,mmin,num,n:longint;
    check:array[0..max]of boolean;
    prime:array[0..max]of longint;
    a:array[0..maxn]of longint;
    f:array[0..max]of longint;
    from,g:array[0..max,1..2]of longint;
function calc(x:longint):longint;
var i,xx:longint;
begin
if f[x]<>0 then exit(f[x]);
i:=1;
xx:=x;
while i<=cnt do
  begin
  if qword(prime[i])*qword(prime[i])>qword(xx) then break;
  while xx mod prime[i]=0 do begin inc(f[x]); xx:=xx div prime[i]; end;
  inc(i);
  end;
if xx<>1 then inc(f[x]);
exit(f[x]);
end;
procedure update(fr,opt:longint);
begin
if g[fr][1]=inf then exit;
if from[fr][1]<>opt then
   begin
   if (g[fr][1]+f[a[opt]]<mmin)or((g[fr][1]+f[a[opt]]=mmin)and(from[fr][1]<num)) then begin mmin:=g[fr][1]+f[a[opt]]; num:=from[fr][1]; end
   end
else if g[fr][2]<>inf then
        begin
        if (g[fr][2]+f[a[opt]]<mmin)or((g[fr][2]+f[a[opt]]=mmin)and(from[fr][2]<num)) then begin mmin:=g[fr][2]+f[a[opt]]; num:=from[fr][2]; end;
        end;
end;
procedure work(fr,opt:longint);
var res:longint;
begin
res:=f[a[opt]]-2*calc(fr);
//minimize num  i increasing order
if res<g[fr][1] then begin g[fr][2]:=g[fr][1]; from[fr][2]:=from[fr][1]; g[fr][1]:=res; from[fr][1]:=opt; end
   else if res<g[fr][2] then begin g[fr][2]:=res; from[fr][2]:=opt; end;
end;
procedure solve;
var i,j:longint;
begin
for i:=1 to max do begin g[i][1]:=inf; g[i][2]:=inf; from[i][1]:=-1; from[i][2]:=-1; end;
for i:=1 to n do
    begin
    for j:=1 to trunc(sqrt(a[i])) do
        begin
        if a[i] mod j=0 then
           begin
           work(j,i); if a[i]=1 then break;
           work(a[i] div j,i);
           end;
        end;
    end;
for i:=1 to n do
    begin
    mmin:=inf; num:=inf;
    for j:=1 to trunc(sqrt(a[i])) do
        begin
        if a[i] mod j=0 then
           begin
           update(j,i); if a[i]=1 then break;
           update(a[i] div j,i);
           end;
        end;
    writeln(num);
    end;
end;
begin
assign(input,'odl.in');
reset(input);
assign(output,'odl.out');
rewrite(output);
read(n);
fillchar(check,sizeof(check),false);
cnt:=0;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; end;
    for j:=1 to cnt do
        begin
        if qword(i)*qword(prime[j])>qword(max) then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then break;
        end;
    end;
for i:=1 to n do
    begin
    read(a[i]);
    f[a[i]]:=calc(a[i]);
    end;
solve;
close(input);
close(output);
end.