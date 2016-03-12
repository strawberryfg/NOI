const maxn=400000;
type rec=record l,r:longint; del,mul,sum:int64; end;
var n,i,ch,opt,ll,rr,v:longint;
    ans,p:int64;
    a:array[0..maxn]of int64;
    tree:array[0..4*maxn]of rec;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].mul:=1;
if f=t then
   begin
   tree[x].sum:=a[f] mod p;
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
end;
procedure lazy(x:longint);
begin
if (tree[x].del<>0)or(tree[x].mul<>1) then
   begin
   if tree[x].l=tree[x].r then
      begin
      tree[x].del:=0; tree[x].mul:=1;
      exit;
      end;
   tree[x*2].mul:=tree[x*2].mul*tree[x].mul mod p;
   tree[x*2].del:=((tree[x*2].del*tree[x].mul)mod p+tree[x].del)mod p;
   tree[x*2].sum:=((tree[x*2].sum*tree[x].mul)mod p+tree[x].del*(tree[x*2].r-tree[x*2].l+1)mod p)mod p;
   tree[x*2+1].mul:=tree[x*2+1].mul*tree[x].mul mod p;
   tree[x*2+1].del:=((tree[x*2+1].del*tree[x].mul)mod p+tree[x].del)mod p;
   tree[x*2+1].sum:=((tree[x*2+1].sum*tree[x].mul)mod p+tree[x].del*(tree[x*2+1].r-tree[x*2+1].l+1)mod p)mod p;
   tree[x].del:=0;
   tree[x].mul:=1;
   end;
end;
procedure plus(f,t,x:longint;v:int64);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].del:=(tree[x].del+v)mod p;
   tree[x].sum:=(tree[x].sum+v*(tree[x].r-tree[x].l+1)mod p) mod p;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then plus(f,t,x*2,v);
if t>mid then plus(f,t,x*2+1,v);
//lazy(x*2); lazy(x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
end;
procedure multiply(f,t,x:longint;v:int64);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].del:=(tree[x].del*v)mod p;
   tree[x].mul:=(tree[x].mul*v)mod p;
   tree[x].sum:=tree[x].sum*v mod p;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then multiply(f,t,x*2,v);
if t>mid then multiply(f,t,x*2+1,v);
//lazy(x*2); lazy(x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
end;
function query(f,t,x:longint):int64;
var mid:longint;
    res:int64;
begin
lazy(x);
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   exit(tree[x].sum mod p);
   end;
mid:=(tree[x].l+tree[x].r)div 2;
res:=0;
if f<=mid then res:=(res+query(f,t,x*2))mod p;
if t>mid then res:=(res+query(f,t,x*2+1))mod p;
//lazy(x*2); lazy(x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
exit(res mod p);
end;
begin
assign(input,'seq.in');
reset(input);
assign(output,'seq.out');
rewrite(output);
readln(n,p);
for i:=1 to n do read(a[i]);
init(1,n,1);
readln(opt);
for i:=1 to opt do
    begin
    read(ch);
    if ch=1 then
       begin
       read(ll,rr,v);
       multiply(ll,rr,1,v);
       end
    else if ch=2 then
            begin
            read(ll,rr,v);
            plus(ll,rr,1,v);
            end
         else begin
              read(ll,rr);
              ans:=query(ll,rr,1)mod p;
              writeln(ans);
              end;
    readln;
    end;
close(input);
close(output);
end.