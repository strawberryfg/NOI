const maxn=400020;
type rec=record l,r:longint; sum,mul,del:int64; end;
var ll,rr,n,i,ch,opt:longint;
    p,c,ans:int64;
    v:array[0..maxn]of longint;
    tree:array[0..4*maxn]of rec;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].mul:=-1; tree[x].del:=-1;
if f=t then
   begin
   tree[x].sum:=v[f] mod p;
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
end;
procedure lazy(x:longint);
begin
if tree[x].mul<>-1 then
   tree[x].sum:=(tree[x].sum*tree[x].mul)mod p;
if tree[x].del<>-1 then
   tree[x].sum:=(tree[x].sum+tree[x].del mod p*(tree[x].r-tree[x].l+1)mod p)mod p;
if tree[x].l=tree[x].r then
   begin
   tree[x].mul:=-1;
   tree[x].del:=-1;
   exit;
   end;
if tree[x].mul<>-1 then
   begin
   if tree[x*2].mul<>-1 then tree[x*2].mul:=(tree[x*2].mul*tree[x].mul)mod p
      else tree[x*2].mul:=tree[x].mul mod p;
   if tree[x*2].del<>-1 then tree[x*2].del:=(tree[x*2].del*tree[x].mul)mod p;
   if tree[x*2+1].mul<>-1 then tree[x*2+1].mul:=(tree[x*2+1].mul*tree[x].mul)mod p
      else tree[x*2+1].mul:=tree[x].mul mod p;
   if tree[x*2+1].del<>-1 then tree[x*2+1].del:=(tree[x*2+1].del*tree[x].mul)mod p;
   tree[x].mul:=-1;
   end;
if tree[x].del<>-1 then
   begin
   if tree[x*2].del<>-1 then tree[x*2].del:=(tree[x*2].del+tree[x].del)mod p
      else tree[x*2].del:=tree[x].del;
   if tree[x*2+1].del<>-1 then tree[x*2+1].del:=(tree[x*2+1].del+tree[x].del)mod p
      else tree[x*2+1].del:=tree[x].del;
   tree[x].del:=-1;
   end;
end;
procedure add(f,t,x:longint;d:int64);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   if tree[x].del=-1 then
      tree[x].del:=d mod p
   else
      tree[x].del:=(tree[x].del+d)mod p;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then add(f,t,x*2,d);
if t>mid then add(f,t,x*2+1,d);
lazy(x*2);
lazy(x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
end;
procedure multiply(f,t,x:longint;d:int64);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   if tree[x].del<>-1 then tree[x].del:=(tree[x].del*d) mod p;
   if tree[x].mul<>-1 then tree[x].mul:=(tree[x].mul*d) mod p
      else tree[x].mul:=d mod p;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then multiply(f,t,x*2,d);
if t>mid then multiply(f,t,x*2+1,d);
lazy(x*2);
lazy(x*2+1);
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
lazy(x*2);
lazy(x*2+1);
tree[x].sum:=(tree[x*2].sum+tree[x*2+1].sum)mod p;
exit(res);
end;
begin
assign(input,'seq.in');
reset(input);
assign(output,'seq.out');
rewrite(output);
readln(n,p);
for i:=1 to n do read(v[i]);
init(1,n,1);
readln(opt);
for i:=1 to opt do
    begin
    read(ch);
    if ch=1 then
       begin
       read(ll,rr,c);
       multiply(ll,rr,1,c);
       end
    else if ch=2 then
            begin
            read(ll,rr,c);
            add(ll,rr,1,c);
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
