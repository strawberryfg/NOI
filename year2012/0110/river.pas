const maxn=80020;
type rec=record l,r:longint; sum:int64; end;
var n,i,q,x,y:longint;
    res,d,td:int64;
    v,sum:array[0..maxn]of int64;
    tree:array[0..4*maxn]of rec;
    c,ch:char;
function max(x,y:int64):int64;
begin
if x>y then exit(x) else exit(y);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then
   begin
   tree[x].sum:=sum[f];
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
tree[x].sum:=max(tree[2*x].sum,tree[2*x+1].sum);
tree[x].sum:=max(tree[x].sum,tree[2*x].sum+tree[2*x+1].sum);
end;
procedure work(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].sum:=max(sum[f]-d,0);
   sum[f]:=sum[f]-d;
   exit;
   end
else
  begin
  mid:=(tree[x].l+tree[x].r)div 2;
  if f<=mid then work(f,t,x*2);
  if t>mid then work(f,t,x*2+1);
  tree[x].sum:=max(tree[2*x].sum,tree[2*x+1].sum);
  tree[x].sum:=max(tree[x].sum,tree[2*x].sum+tree[2*x+1].sum);
  end;
end;
function ask(f,t,x:longint):int64;
var mid:longint;
    t1,t2,res:int64;
begin
mid:=(tree[x].l+tree[x].r)div 2;
if (f<=tree[x].l)and(tree[x].r<=t) then exit(max(0,tree[x].sum));
if (t<=mid) then
   begin
   if (f<=tree[x].l)and(tree[x].r<=t) then exit(tree[x].sum)
      else exit(ask(f,t,x*2));
   end;
if (f>mid) then
   begin
   if (f<=tree[x].l)and(tree[x].r<=t) then exit(tree[x].sum)
      else exit(ask(f,t,x*2+1));
   end;
t1:=ask(f,t,x*2);
t2:=ask(f,t,x*2+1);
res:=max(t1,t2);
res:=max(res,t1+t2);
exit(res);
end;
begin
assign(input,'river.in');
reset(input);
assign(output,'river.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(v[i]);
    sum[i-1]:=v[i]-v[i-1];
    end;
init(1,n-1,1);
readln(q);
for i:=1 to q do
    begin
    read(ch); read(c);
    if ch='C' then
       begin
       read(x,y,d);
       td:=d;
       if x-1>0 then
          begin
          d:=-d;
          work(x-1,x-1,1);
          end;
       d:=td;
       if y<n then
          begin
          work(y,y,1);
          end;
       end
    else
       begin
       read(x,y);
       if x=y then
          begin
          writeln(0);
          end
       else
          begin
          res:=ask(x,y-1,1);
          writeln(res);
          end;
       end;
    readln;
    end;
close(input);
close(output);
end.