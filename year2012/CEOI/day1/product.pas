const maxn=11111; maxheap=277777; maxmo=8470440;  base=100000000;
      mo:array[1..5]of qword=(8468723,2726221,7931771,8470439,4173577);
type arr=array[0..14]of longint;
     rec=array[-1..12]of qword;
     heaptype=record num:arr; key:rec; end;
var n,m,k,i,top,cnt,j:longint;
    a:array[0..maxn]of longint;
    b:arr;
    tmp:heaptype;
    heap:array[0..maxheap]of heaptype;
    hash:array[1..5,0..maxmo]of byte;
    c,d:rec;
procedure sort(l,r:longint);
var i,j,cmp,swapa:longint;
begin
i:=l; j:=r; cmp:=a[(l+r) div 2];
repeat
while a[i]>cmp do inc(i);
while cmp>a[j] do dec(j);
if not(i>j) then begin swapa:=a[i]; a[i]:=a[j]; a[j]:=swapa; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function cmpv(x,y:rec):boolean;
var i:longint;
begin
if x[-1]<y[-1] then exit(true);
if x[-1]>y[-1] then exit(false);
for i:=x[-1] downto 0 do
    begin
    if x[i]<y[i] then exit(true);
    if x[i]>y[i] then exit(false);
    end;
exit(false);
end;
procedure print(x:rec);
var i:longint;
begin
write(x[x[-1]]);
if x[-1]<>0 then
for i:=x[-1]-1 downto 0 do
    begin
    if x[i]>9999999 then write(x[i])
       else if x[i]>999999 then write('0',x[i])
               else if x[i]>99999 then write('00',x[i])
                       else if x[i]>9999 then write('000',x[i])
                               else if x[i]>999 then write('0000',x[i])
                                       else if x[i]>99 then write('00000',x[i])
                                               else if x[i]>9 then write('000000',x[i])
                                                       else write('0000000',x[i]);
    end;
writeln;
end;
function mul(x,y:rec):rec;
var i,j,k,max:longint;
begin
max:=x[-1]+y[-1];
fillchar(c,sizeof(c),0);
for i:=0 to x[-1] do
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+qword(x[i])*qword(y[j]);
        k:=i+j;
        while c[k]>=base do
          begin
          if k>max then max:=k;
          c[k+1]:=c[k+1]+c[k] div base;
          c[k]:=c[k] mod base;
          inc(k);
          end;
        end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
mul:=c;
end;
procedure makehash(b:arr);
var i,j:longint; now:qword;
begin
for i:=1 to 5 do
    begin
    now:=0;
    for j:=1 to m do
        now:=(now*qword(999983) mod mo[i]+qword(b[j])) mod mo[i];
    hash[i][now]:=1;
    end;
end;
function check(b:arr):boolean;
var i,j:longint; now:qword;
begin
for i:=1 to 5 do
    begin
    now:=0;
    for j:=1 to m do
        now:=(now*qword(999983) mod mo[i]+qword(b[j])) mod mo[i];
    if hash[i][now]=0 then exit(true);
    end;
exit(false);
end;
procedure up(x:longint);
var swap:heaptype;
begin
while x>1 do
  begin
  if cmpv(heap[x div 2].key,heap[x].key) then
     begin
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     x:=x div 2;
     end
  else break;
  end;
end;
procedure down(x:longint);
var swap:heaptype; opt:longint;
begin
while x*2<=top do
  begin
  if x*2+1>top then opt:=0
     else begin
          if cmpv(heap[x*2+1].key,heap[x*2].key) then opt:=0 else opt:=1;
          end;
  if cmpv(heap[x].key,heap[x*2+opt].key) then
     begin
     swap:=heap[x]; heap[x]:=heap[x*2+opt]; heap[x*2+opt]:=swap;
     x:=x*2+opt;
     end
  else break;
  end;
end;
begin
assign(input,'product.in');
reset(input);
assign(output,'product.out');
rewrite(output);
readln(n,m,k);
//init;
for i:=1 to n do read(a[i]);
sort(1,n);
top:=1;
heap[1].key[0]:=1; heap[1].key[-1]:=0;
for i:=1 to m do begin heap[1].num[i]:=i; d[-1]:=0; d[0]:=a[i]; heap[1].key:=mul(heap[1].key,d); end;
makehash(heap[1].num);
cnt:=0;
while cnt<k do
  begin
  tmp:=heap[1];
  inc(cnt); if cnt=k then begin print(tmp.key); break; end;
  heap[1]:=heap[top];
  dec(top);
  down(1);
  if tmp.num[m]+1<=n then
     begin
     for i:=1 to m do b[i]:=tmp.num[i];
     b[m]:=b[m]+1;
     if check(b) then
        begin
        inc(top); heap[top].num:=b;
        heap[top].key[0]:=1; heap[top].key[-1]:=0;
        for i:=1 to m do begin d[-1]:=0; d[0]:=a[b[i]]; heap[top].key:=mul(heap[top].key,d); end;
        makehash(b);
        up(top);
        end;
     end;
  for i:=m-1 downto 1 do
      begin
      if tmp.num[i]+1<tmp.num[i+1] then
         begin
         for j:=1 to m do b[j]:=tmp.num[j];
         b[i]:=b[i]+1;
         if check(b) then
            begin
            inc(top); heap[top].num:=b;
            heap[top].key[0]:=1; heap[top].key[-1]:=0;
            for j:=1 to m do begin d[-1]:=0; d[0]:=a[b[j]]; heap[top].key:=mul(heap[top].key,d); end;
            makehash(b);
            up(top);
            end;
         end;
      end;
  end;
close(input);
close(output);
end.
