const maxn=100020; inf=5555555555555555555;
var n,len,i,j,ret,fmax,t,le,ri,mid:longint;
    sw:array[0..maxn]of qword;
    cmax:array[0..maxn,0..20]of longint;
    two:array[0..20]of longint;
    g,left,h,w:array[0..maxn]of longint;
    f:array[0..maxn]of qword;
function check(x:longint):longint;
var i:longint;
begin
for i:=0 to 20 do if (x>=two[i])and(x<two[i+1]) then exit(i);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function rmq(x,y:longint):longint;
var tmp:longint;
begin
tmp:=g[y-x+1];
rmq:=max(cmax[y][tmp],cmax[x+two[tmp]-1][tmp]);
end;
begin
assign(input,'bookshelf.in');
reset(input);
assign(output,'bookshelf.out');
rewrite(output);
readln(n,len);
two[0]:=1; for i:=1 to 20 do two[i]:=two[i-1]*2;
for i:=1 to n do readln(h[i],w[i]);
sw[0]:=0;
for i:=1 to n do sw[i]:=sw[i-1]+w[i];
for i:=1 to n do cmax[i][0]:=h[i];
t:=check(n);
for i:=1 to n do g[i]:=check(i);
for j:=1 to t do
    begin
    for i:=two[j] to n do
        cmax[i][j]:=max(cmax[i-two[j-1]][j-1],cmax[i][j-1]);
    end;
for i:=1 to n do
    begin
    le:=1; ri:=i;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      ret:=rmq(mid,i);
      if ret>h[i] then le:=mid+1
         else begin left[i]:=mid; ri:=mid-1; end;
      end;
    end;
for i:=1 to n do f[i]:=inf;
f[0]:=0;
for i:=1 to n do
    begin
    j:=i; fmax:=0;
    writeln(i);
    while j>=1 do
      begin
      if h[j]>fmax then fmax:=h[j];
      if sw[i]-sw[left[j]-1]<=len then
         begin
         if f[left[j]-1]+fmax<f[i] then
            f[i]:=f[left[j]-1]+fmax;
         j:=left[j]-1;
         end
      else
         begin
         le:=left[j]; ri:=j;
         ret:=-1;
         while le<=ri do
           begin
           mid:=(le+ri)div 2;
           if (sw[i]-sw[mid-1]<=len) then begin ret:=mid; ri:=mid-1; end
              else le:=mid+1;
           end;
         if ret<>-1 then
            begin
            if f[ret-1]+fmax<f[i] then
               f[i]:=f[ret-1]+fmax;
            end;
         break;
         end;
      end;
    end;
//for i:=1 to n do writeln(i,' : ',f[i]);
writeln(f[n]);
close(input);
close(output);
end.