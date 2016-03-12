const max=4020; maxn=520; inf=maxlongint;
var n,m,i,j,k,res,num,tmp:longint;
    a,c,d:array[0..maxn,0..maxn]of longint;
    b,tb,sum,tsum:array[0..maxn]of longint;
    f,g,from:array[0..maxn,0..max]of longint;
function check:boolean;
var i:longint;
begin
for i:=2 to m do
    if a[1][i]-a[1][i-1]<=0 then exit(false);
exit(true);
end;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=tb[(l+r) div 2];
repeat
while tb[i]<x do inc(i);
while x<tb[j] do dec(j);
if not(i>j) then begin y:=tb[i]; tb[i]:=tb[j]; tb[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function calc(x:longint):longint;
var le,ri,mid,ans:longint;
begin
le:=1; ri:=n; ans:=0;
while le<=ri do
   begin
   mid:=(le+ri)div 2;
   if x>=tb[mid+1] then le:=mid+1
      else if x<tb[mid] then ri:=mid-1
              else begin
                   ans:=mid;
                   break;
                   end;
   end;
exit(ans);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure work;
var i,j,t,tt:longint;
begin
d:=a;
for i:=1 to n do tb[i]:=a[i][2]-a[i][1];
tb[n+1]:=inf;
sort(1,n); sum[0]:=0; for i:=1 to n do sum[i]:=sum[i-1]+tb[i];
for i:=1 to max do
    begin
    t:=calc(i);
    f[2][i]:=i*t-sum[t]+(sum[n]-sum[t])-i*(n-t);
    if i=1 then begin g[2][i]:=f[2][i]; from[2][i]:=i; end
       else begin
            if g[2][i-1]<f[2][i] then begin g[2][i]:=g[2][i-1]; from[2][i]:=from[2][i-1]; end
               else begin g[2][i]:=f[2][i]; from[2][i]:=i; end;
            end;
    end;
for i:=3 to m do
    begin
    for j:=1 to n do tb[j]:=a[j][i]-a[j][1];
    tb[n+1]:=inf;
    sort(1,n);
    sum[0]:=0; for j:=1 to n do sum[j]:=sum[j-1]+tb[j];
    for j:=i-1 to max do
        begin
        t:=calc(j);
        f[i][j]:=j*t-sum[t]+(sum[n]-sum[t])-j*(n-t)+g[i-1][j-1];
        if j=i-1 then begin g[i][j]:=f[i][j]; from[i][j]:=j; end
           else begin
                if g[i][j-1]<f[i][j] then begin g[i][j]:=g[i][j-1]; from[i][j]:=from[i][j-1]; end
                   else begin g[i][j]:=f[i][j]; from[i][j]:=j; end;
                end;
        end;
    end;
i:=m; t:=from[m][max];
while i>=2 do
  begin
  for j:=1 to n do
      begin
      d[j][i]:=t+a[j][1];
      end;
  dec(i);
  t:=from[i][t-1];
  end;
end;
begin
assign(input,'equal.in');
reset(input);
assign(output,'equal.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        read(a[i][j]);
    readln;
    end;
c:=a;
if not check then begin writeln(-1); writeln; end
   else begin
        for i:=2 to n do
            begin
            for j:=1 to m do
                begin
                b[j]:=a[1][j]-a[i][j];
                end;
            res:=inf; num:=-1;
            tb:=b;
            sort(1,m);
            sum[0]:=0;
            for j:=1 to m-1 do
                sum[j]:=sum[j-1]+tb[j+1]-tb[j];
            tsum:=sum;
            for j:=2 to m-1 do
                sum[j]:=sum[j-1]+sum[j];
            for j:=1 to m do
                begin
                tmp:=0;
                tmp:=sum[m-1]-sum[j-1]-(m-j)*tsum[j-1];
                if j>1 then tmp:=tmp+tsum[j-1]*(j-1)-sum[j-2];
                if tmp<res then
                   begin
                   res:=tmp;
                   num:=tb[j];
                   end;
                end;
            for j:=1 to m do
                begin
                tmp:=num;
                c[i][j]:=a[1][j]-tmp;
                end;
            end;
        for i:=1 to n do
            begin
            for j:=1 to m-1 do
                write(c[i][j],' ');
            write(c[i][m]);
            writeln;
            end;
        writeln;
        end;
work;
close(input);
close(output);
end.