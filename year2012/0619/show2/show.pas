const maxn=222; inf=maxlongint div 2;
type segtype=record ll,rr:longint; end;
var n,i,cnt,j,k,ans,l,fmax:longint;
    a,b,aa,bb,sta,lll,rrr:array[0..2*maxn]of longint;
    seg:array[0..2*maxn]of segtype;
    f,g,mf,mg:array[0..maxn,0..maxn,0..2*maxn]of longint;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure sort(l,r:longint);
var i,j,x,y:longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i);
while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sortseg(l,r:longint);
var i,j,cmpl,cmpr:longint; swap:segtype;
begin
i:=l; j:=r; cmpl:=seg[(l+r) div 2].ll; cmpr:=seg[(l+r) div 2].rr;
repeat
while (seg[i].ll<cmpl)or((seg[i].ll=cmpl)and(seg[i].rr<cmpr)) do inc(i);
while (cmpl<seg[j].ll)or((cmpl=seg[j].ll)and(cmpr<seg[j].rr)) do dec(j);
if not(i>j) then begin swap:=seg[i]; seg[i]:=seg[j]; seg[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sortseg(l,j);
if i<r then sortseg(i,r);
end;
function find(x:longint):longint;
var le,ri,mid:longint;
begin
le:=1; ri:=cnt;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if a[mid]<x then le:=mid+1
     else if a[mid]>x then ri:=mid-1
             else exit(mid);
  end;
end;
procedure dfs(x,now:longint);
var i,j:longint;
begin
if x>n then
   begin
   aa[0]:=0; bb[0]:=0;
   for i:=1 to n do
       begin
       if sta[i]=1 then begin inc(aa[0]); aa[aa[0]]:=i; end
          else if sta[i]=2 then begin inc(bb[0]); bb[bb[0]]:=i; end;
       end;
   for i:=1 to aa[0] do
       begin
       for j:=1 to bb[0] do
           begin
           if rrr[bb[j]]<=lll[aa[i]] then continue;
           if lll[bb[j]]>=rrr[aa[i]] then continue;
           exit;
           end;
       end;
   if aa[0]<bb[0] then begin if aa[0]>ans then begin ans:=aa[0]; end; end
      else if bb[0]>ans then begin ans:=bb[0]; end;
   exit;
   end;
if (x=now) then begin dfs(x+1,now); exit; end;
for i:=0 to 2 do
    begin
    sta[x]:=i;
    dfs(x+1,now);
    end;
end;
begin
assign(input,'show.in');
reset(input);
assign(output,'show.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(seg[i].ll,seg[i].rr);
    seg[i].rr:=seg[i].rr+seg[i].ll;
    lll[i]:=seg[i].ll; rrr[i]:=seg[i].rr;
    a[2*i-1]:=seg[i].ll; a[2*i]:=seg[i].rr;
    end;
if n<=10 then
   begin
   dfs(1,0);
   writeln(ans);
   for i:=1 to n do
       begin
       ans:=0;
       sta[i]:=1;
       dfs(1,i);
       sta[i]:=2;
       dfs(1,i);
       writeln(ans);
       end;
   end
else
   begin
   sort(1,2*n);
   i:=1; cnt:=0;
   while i<=2*n do
     begin
     j:=i;
     while (j+1<=2*n)and(a[j+1]=a[i]) do inc(j);
     inc(cnt); b[cnt]:=a[i];
     i:=j+1;
     end;
   a:=b;
   for i:=1 to n do begin seg[i].ll:=find(seg[i].ll); seg[i].rr:=find(seg[i].rr); end;
   sortseg(1,n);
   for i:=0 to n do
       for j:=0 to n do
           for k:=0 to cnt do
               begin
               f[i][j][k]:=-inf;
               g[i][j][k]:=-inf;
               mf[i][j][k]:=-inf;
               mg[i][j][k]:=-inf;
               end;
   f[0][0][0]:=0; g[0][0][0]:=0;
   for k:=0 to cnt do begin mf[0][0][k]:=0; mg[0][0][k]:=0; end;
   for i:=1 to n do
       for j:=0 to i do
           begin
           if j>=1 then f[i][j][seg[i].rr]:=max(f[i][j][seg[i].rr],mg[i-1][j-1][seg[i].ll]);
           g[i][j][seg[i].rr]:=max(g[i][j][seg[i].rr],mf[i-1][j][seg[i].ll]+1);
           for k:=0 to cnt do
               begin
               if mg[i-1][j][k]=-inf then continue;
               fmax:=seg[i].rr; if a[k]>a[seg[i].rr] then fmax:=k;
               if mg[i-1][j][k]+1>g[i][j][fmax] then g[i][j][fmax]:=mg[i-1][j][k]+1;
               end;
           if j>=1 then
              begin
              for k:=0 to cnt do
                  begin
                  if mf[i-1][j-1][k]=-inf then continue;
                  fmax:=seg[i].rr; if a[k]>a[seg[i].rr] then fmax:=k;
                  if mf[i-1][j-1][k]>f[i][j][fmax] then f[i][j][fmax]:=mf[i-1][j-1][k];
                  end;
              end;
           for k:=0 to cnt do
               begin
               mf[i][j][k]:=max(mf[i-1][j][k],f[i][j][k]);
               if k<>0 then mf[i][j][k]:=max(mf[i][j][k],mf[i][j][k-1]);
               mg[i][j][k]:=max(mg[i-1][j][k],g[i][j][k]);
               if k<>0 then mg[i][j][k]:=max(mg[i][j][k],mg[i][j][k-1]);
               end;
           end;
   ans:=0;
   for i:=1 to n do
       for j:=0 to i do
           for k:=0 to cnt do
               begin
               if f[i][j][k]<>-inf then
                  begin
                  if min(j,f[i][j][k])>ans then
                     ans:=min(j,f[i][j][k]);
                  end;
               if g[i][j][k]<>-inf then
                  begin
                  if min(j,g[i][j][k])>ans then
                     ans:=min(j,g[i][j][k]);
                  end;
               end;
   writeln(ans);
   for i:=1 to n do writeln(ans);
   end;
close(input);
close(output);
end.