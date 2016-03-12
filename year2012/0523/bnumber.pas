const maxn=200200; maxlen=20020; inf=maxlongint;
var n,p,q,r,s:longint;
    xx,yy:int64;
    pow:array[0..maxlen]of longint;
    g:array[0..10,0..maxn]of longint;
function gcd(x,y:longint):longint;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
procedure euclid(a,b:longint);
var tx,ty:int64;
begin
if b=0 then begin xx:=1; yy:=0; exit; end;
euclid(b,a mod b);
tx:=yy mod n; ty:=((xx-a div b*yy) mod n+n) mod n;
xx:=tx; yy:=ty;
end;
procedure modify(alen,a,blen,b:longint); //p q r s
begin
if a=b then exit;
if (p=-1) then begin p:=alen; q:=a; r:=blen; s:=b; exit; end;
if alen+blen<p+r then
   begin
   p:=alen; q:=a; r:=blen; s:=b; exit;
   end;
if alen+blen>p+r then exit;
if alen<=p then
   begin
   if a>q then exit;
   if a<q then begin p:=alen; q:=a; r:=blen; s:=b; exit; end;
   if alen<p then
      begin
      if b>q then exit;
      if b<q then begin p:=alen; q:=a; r:=blen; s:=b; exit; end;
      end;
   if b>=s then exit;
   p:=alen; q:=a; r:=blen; s:=b; exit;
   end;
if a>q then exit;
if a<q then begin p:=alen; q:=a; r:=blen; s:=b; exit; end;
if a>s then exit;
if a<s then begin p:=alen; q:=a; r:=blen; s:=b; exit; end;
if b>=s then exit;
p:=alen; q:=a; r:=blen; s:=b; exit;
end;
procedure extended_euclid(d,num,lastlen,last:longint);
var tx,ty,i,j,right,tmp:longint;
begin
right:=gcd(d,n);
if num mod right<>0 then exit;
euclid(d,n);
xx:=(xx*(int64(num) div right) mod n+n) mod n;
tx:=xx;
tmp:=n div right;
for i:=0 to right-1 do
    begin
//    tx:=((xx+i*(int64(n) div right)) mod n+n) mod n;
//    ty:=((yy-i*(int64(d) div right)) mod n+n) mod n;
    if (tx>=0)and(tx<n) then
       begin
       for j:=1 to 9 do
           begin
           if (g[j][tx]<>inf) then
              begin
              modify(g[j][tx],j,lastlen,last);
              end;
           end;
       end;
    tx:=(tx+tmp) mod n;
    end;
end;
procedure work;
var i,j,x,last:longint;
begin
for i:=0 to 9 do
    for j:=0 to n-1 do
        g[i][j]:=inf;
for i:=0 to 9 do
    begin
    x:=0;
    for j:=1 to maxlen do
        begin
        x:=(x*10+i) mod n;
        if j<g[i][x] then g[i][x]:=j;
        end;
    end;
pow[0]:=1;
for i:=1 to maxlen do pow[i]:=pow[i-1]*10 mod n;
p:=-1; q:=-1; r:=-1; s:=-1;
for i:=0 to 9 do
    begin
    last:=0;
    for j:=1 to maxlen do   //pow[j]*x+y
        begin
        if (p<>-1)and(j>p+r) then break;
        last:=(last*10+i) mod n;
        if pow[j] mod n=0 then
           modify(1,1,j,0)
        else
           begin
           extended_euclid(pow[j] mod n,n-last,j,i);
           end;
        end;
    end;
writeln(p,' ',q,' ',r,' ',s);
end;
begin
assign(input,'bnumber.in');
reset(input);
assign(output,'bnumber.out');
rewrite(output);
readln(n);
while n<>0 do
  begin
  work;
  readln(n);
  end;
close(input);
close(output);
end.
