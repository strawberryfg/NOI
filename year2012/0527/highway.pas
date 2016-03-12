const maxn=100200;
type treetype=record del,sa,sb,sf:int64; end;
var n,opt,i:longint;
    d:int64;
    ll,rr:longint;
    suma,sumb,sumc:array[0..maxn]of int64;
    tree:array[0..4*maxn]of treetype;
    ch,c:char;
    res,ansx,ansy,ret1,ret2,ret3,zero:int64;
procedure pushdown(x,l,mid,r:longint);
begin
if tree[x].del<>0 then
   begin
   tree[x*2].del:=tree[x*2].del+tree[x].del;
   tree[x*2].sa:=tree[x*2].sa+tree[x].del*(suma[mid]-suma[l-1]);
   tree[x*2].sb:=tree[x*2].sb+tree[x].del*(sumb[mid]-sumb[l-1]);
   tree[x*2].sf:=tree[x*2].sf+tree[x].del*int64(mid-l+1);
   tree[x*2+1].del:=tree[x*2+1].del+tree[x].del;
   tree[x*2+1].sa:=tree[x*2+1].sa+tree[x].del*(suma[r]-suma[mid]);
   tree[x*2+1].sb:=tree[x*2+1].sb+tree[x].del*(sumb[r]-sumb[mid]);
   tree[x*2+1].sf:=tree[x*2+1].sf+tree[x].del*int64(r-mid);
   tree[x].del:=0;
   end;
end;
procedure modify(l,r,f,t,x:longint;d:int64);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   tree[x].del:=tree[x].del+d;
   tree[x].sa:=tree[x].sa+d*(suma[r]-suma[l-1]);
   tree[x].sb:=tree[x].sb+d*(sumb[r]-sumb[l-1]);
   tree[x].sf:=tree[x].sf+d*int64(r-l+1);
   exit;
   end;
mid:=(l+r) div 2;
pushdown(x,l,mid,r);
if f<=mid then modify(l,mid,f,t,x*2,d);
if t>mid then modify(mid+1,r,f,t,x*2+1,d);
tree[x].sa:=tree[x*2].sa+tree[x*2+1].sa;
tree[x].sb:=tree[x*2].sb+tree[x*2+1].sb;
tree[x].sf:=tree[x*2].sf+tree[x*2+1].sf;
end;
procedure query(l,r,f,t,x:longint);
var mid:longint;
begin
if (f<=l)and(r<=t) then
   begin
   ret1:=ret1+tree[x].sa;
   ret2:=ret2+tree[x].sb;
   ret3:=ret3+tree[x].sf;
   exit;
   end;
mid:=(l+r) div 2;
pushdown(x,l,mid,r);
if f<=mid then query(l,mid,f,t,x*2);
if t>mid then query(mid+1,r,f,t,x*2+1);
end;
function gcd(x,y:int64):int64;
var tmp,t:int64;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
begin
assign(input,'highway.in');
reset(input);
assign(output,'highway.out');
rewrite(output);
readln(n,opt);
suma[0]:=0;
for i:=1 to n do suma[i]:=suma[i-1]+int64(i);
sumb[0]:=0;
for i:=1 to n do sumb[i]:=sumb[i-1]-int64(i)*int64(i);
for i:=1 to opt do
    begin
    read(ch); read(c);
    if ch='C' then
       begin
       read(ll,rr,d);
       modify(1,n,ll,rr-1,1,d);
       end
    else
       begin
       read(ll,rr);
       ansx:=0;
       ret1:=0; ret2:=0;  ret3:=0;
       query(1,n,ll,rr-1,1);
       ret1:=int64(ret1)*int64(ll+rr-1);
       ret3:=int64(ret3)*int64(rr)*int64(1-ll);
       ansx:=ret1+ret2+ret3;
       ansy:=int64(rr-ll+1)*int64(rr-ll) div 2;
       res:=gcd(ansx,ansy);
       ansx:=ansx div res;
       ansy:=ansy div res;
       writeln(ansx,'/',ansy);
       end;
    readln;
    end;
close(input);
close(output);
end.