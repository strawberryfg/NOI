const maxn=111; eps=1e-16;
type rec=record l,r:extended; end;
var n,i,cnt:longint;
    sx,ex,locy,llx,rrx,proy,ll,rr,yy,l1,r1,lastl,lastr,ans:extended;
    seg:array[0..maxn]of rec;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
function calc(fst,nxt,del1,del2:extended):extended;
begin
exit(del2*(nxt-fst)/del1+nxt);
end;
procedure cmax(var x:extended; y:extended);
begin
if y>x then x:=y;
end;
procedure cmin(var x:extended; y:extended);
begin
if y<x then x:=y;
end;
procedure sort(left,right:longint);
var i,j:longint; cmpl,cmpr:extended; swap:rec;
begin
i:=left; j:=right; cmpl:=seg[(left+right) div 2].l; cmpr:=seg[(left+right) div 2].r;
repeat
while (cmp(seg[i].l-cmpl)<0)or((cmp(seg[i].l-cmpl)=0)and(cmp(seg[i].r-cmpr)<0)) do inc(i);
while (cmp(cmpl-seg[j].l)<0)or((cmp(cmpl-seg[j].l)=0)and(cmp(cmpr-seg[j].r)<0)) do dec(j);
if not(i>j) then begin swap:=seg[i]; seg[i]:=seg[j]; seg[j]:=swap; inc(i); dec(j); end;
until i>j;
if left<j then sort(left,j);
if i<right then sort(i,right);
end;
begin
{assign(input,'sight.in');
reset(input);
assign(output,'sight.out');
rewrite(output);}
read(sx,ex,locy);
while (cmp(sx)<>0)or(cmp(ex)<>0)or(cmp(locy)<>0) do
  begin
  read(llx,rrx,proy);
  read(n); cnt:=0;
  for i:=1 to n do
      begin
      read(ll,rr,yy);
      if (cmp(yy-locy)>=0)or(cmp(proy-yy)>=0) then continue;
      if (cmp(sx-rr)=0) then r1:=sx
         else r1:=calc(sx,rr,locy-yy,yy-proy);
      if (cmp(ex-ll)=0) then l1:=ex
         else l1:=calc(ex,ll,locy-yy,yy-proy);
      if (cmp(llx-r1)>=0)or(cmp(l1-rrx)>=0) then continue;
      cmax(l1,llx); cmin(r1,rrx);
      inc(cnt); seg[cnt].l:=l1; seg[cnt].r:=r1;
      end;
  if cnt=0 then begin writeln(round((rrx-llx)*100)/100:0:2); read(sx,ex,locy); continue; end;
  sort(1,cnt);
  ans:=0.0;
  cmax(ans,seg[1].l-llx);
  lastl:=seg[1].l; lastr:=seg[1].r;
  for i:=2 to cnt do
      begin
      if cmp(seg[i].l-lastr)>0 then
         begin
         cmax(ans,seg[i].l-lastr);
         lastl:=seg[i].l; lastr:=seg[i].r;
         end
      else cmax(lastr,seg[i].r);
      end;
  cmax(ans,rrx-lastr);
  if cmp(ans)=0 then writeln('No View') else writeln(round(ans*100)/100:0:2);
  read(sx,ex,locy);
  end;
{close(input);
close(output);}
end.