type tree=^re;re=record l,r:longint;min,max:int64;lc,rc:tree end;
var a,q1:array[1..100000] of int64;root:tree;
t1,n:longint;s,s123,s132,s213,s231,s312,s321:int64;
function min(a,b:int64):int64;begin if a<b then exit(a);exit(b) end;
function max(a,b:int64):int64;begin if a>b then exit(a);exit(b) end;
procedure build(var p:tree;l,r:longint);
begin
  new(p);p^.l:=l;p^.r:=r;p^.lc:=nil;p^.rc:=nil;
  if l=r then begin p^.min:=a[l];p^.max:=a[l]; exit; end;
  build(p^.lc,l,(l+r)>>1);build(p^.rc,(l+r)>>1+1,r);
  p^.min:=min(p^.lc^.min,p^.rc^.min);p^.max:=max(p^.lc^.max,p^.rc^.max)
end;
function askmin(p:tree;x,y:longint;z:int64):longint;
begin
  if y<x then exit(0);if (p^.l>y)or(p^.r<x) then exit(0);if p^.min>=z then exit(0);
  if (p^.l>=x)and(p^.r<=y) then if p^.max<z then exit(p^.r-p^.l+1);
  exit(askmin(p^.lc,x,y,z)+askmin(p^.rc,x,y,z))
end;
function askmax(p:tree;x,y:longint;z:int64):longint;
begin
  if y<x then exit(0);if (p^.l>y)or(p^.r<x) then exit(0);if p^.max<=z then exit(0);
  if (p^.l>=x)and(p^.r<=y) then if p^.min>z then exit(p^.r-p^.l+1);
  exit(askmax(p^.lc,x,y,z)+askmax(p^.rc,x,y,z))
end;
procedure addmin(l,r:longint);var i:longint;
begin for i:=l to r do begin inc(t1);q1[t1]:=i;end end;
procedure findmin(p:tree;x,y:longint;z:int64);
begin
  if y<x then exit;if (p^.l>y)or(p^.r<x) then exit;if p^.min>=z then exit;
  if (p^.l>=x)and(p^.r<=y) then if p^.max<z then begin addmin(p^.l,p^.r);exit end;
  findmin(p^.lc,x,y,z);findmin(p^.rc,x,y,z)
end;
procedure init;var i:longint;
begin
  readln(n);for i:=1 to n do read(a[i]);readln;
  s123:=0;s132:=0;s213:=0;s231:=0;s321:=0;s312:=0;s:=0
end;
procedure pri(a,b:int64);var i:longint;z:array[0..20] of longint;
begin
  fillchar(z,sizeof(z),0);z[0]:=a div b;a:=a mod b;
  for i:=1 to 20 do begin a:=a*10;z[i]:=a div b;a:=a mod b end;
  write(z[0],'.'); for i:=1 to 20 do write(z[i]); writeln
end;
procedure work1;var i,j,k:longint;
begin
  for j:=2 to n-1 do for i:=1 to j-1 do for k:=j+1 to n do
    begin
      if (a[i]<a[j])and(a[j]<a[k]) then begin inc(s123);inc(s) end;
      if (a[i]<a[k])and(a[k]<a[j]) then begin inc(s132);inc(s) end;
      if (a[j]<a[i])and(a[i]<a[k]) then begin inc(s213);inc(s) end;
      if (a[k]<a[i])and(a[i]<a[j]) then begin inc(s231);inc(s) end;
      if (a[j]<a[k])and(a[k]<a[i]) then begin inc(s312);inc(s) end;
      if (a[k]<a[j])and(a[j]<a[i]) then begin inc(s321);inc(s) end
    end;
  pri(s123,s);pri(s132,s);pri(s213,s);pri(s231,s);pri(s312,s);pri(s321,s)
end;
procedure work2;var i,i1,i2:longint;
begin
  build(root,1,n);
  for i:=1 to n do
    begin
      s123:=s123+askmin(root,1,i-1,a[i])*askmax(root,i+1,n,a[i]);
      s321:=s321+askmax(root,1,i-1,a[i])*askmin(root,i+1,n,a[i]);
      t1:=0;findmin(root,1,i-1,a[i]);
      for i1:=1 to t1 do
         begin
           s312:=s312+askmax(root,1,q1[i1]-1,a[i]);
           s132:=s132+askmax(root,q1[i1]+1,i-1,a[i]);
         end;
      t1:=0;findmin(root,i+1,n,a[i]);
      for i1:=1 to t1 do
        begin
          s213:=s213+askmax(root,q1[i1]+1,n,a[i]);
          s231:=s231+askmax(root,i+1,q1[i1]-1,a[i]);
        end;
    end;
  s:=s123+s132+s213+s231+s312+s321;
  pri(s123,s);pri(s132,s);pri(s213,s);pri(s231,s);pri(s312,s);pri(s321,s);
end;
begin
  assign(input,'shape.in');reset(input);assign(output,'shape.out');rewrite(output);
  init; if n<=200 then work1 else work2; close(input);close(output)
end.
