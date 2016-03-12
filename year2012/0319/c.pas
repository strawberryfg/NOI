const maxn=200020;
type rec=record  l,r:longint; va,vb,sum,del:extended; end;
var n,opt,i,j:longint;
    x,y:longint;
    d,ti,xx,yy:extended;
    ch,c:char;
    sa,sb:array[0..maxn]of extended;
    tree:array[0..4*maxn]of rec;
    value,tmp:extended;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure lazy(x:longint);
begin
if tree[x].del<>0 then
   begin
   tree[x*2].del:=tree[x*2].del+tree[x].del;
   tree[x*2].sum:=tree[x*2].sum+tree[x].del*(tree[x*2].r-tree[x*2].l+1);
   tree[x*2].va:=tree[x*2].va+tree[x].del*(sa[tree[x*2].r]-sa[tree[x*2].l-1]);
   tree[x*2].vb:=tree[x*2].vb+tree[x].del*(sb[tree[x*2].r]-sb[tree[x*2].l-1]);
   tree[x*2+1].del:=tree[x*2+1].del+tree[x].del;
   tree[x*2+1].sum:=tree[x*2+1].sum+tree[x].del*(tree[x*2+1].r-tree[x*2+1].l+1);
   tree[x*2+1].va:=tree[x*2+1].va+tree[x].del*(sa[tree[x*2+1].r]-sa[tree[x*2+1].l-1]);
   tree[x*2+1].vb:=tree[x*2+1].vb+tree[x].del*(sb[tree[x*2+1].r]-sb[tree[x*2+1].l-1]);
   tree[x].del:=0;
   end;
end;
procedure update(x:longint);
begin
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
tree[x].va:=tree[x*2].va+tree[x*2+1].va;
tree[x].vb:=tree[x*2].vb+tree[x*2+1].vb;
end;
procedure modify(f,t,x:longint);
var mid:longint;
    tl,tr:extended;
begin
tr:=tree[x].r; tl:=tree[x].l;
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].del:=tree[x].del+d;
   tree[x].sum:=tree[x].sum+d*(tr-tl+1);
   tree[x].va:=tree[x].va+d*(sa[tree[x].r]-sa[tree[x].l-1]);
   tree[x].vb:=tree[x].vb+d*(sb[tree[x].r]-sb[tree[x].l-1]);
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r) div 2;
if f<=mid then modify(f,t,x*2);
if t>mid then modify(f,t,x*2+1);
update(x);
end;
function query(f,t,x:longint):extended;
var mid:longint;
    res,tf,tt:extended;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tf:=f; tt:=t;
   exit(tree[x].va+tree[x].vb*(tf+tt+1)+(tt+1)*(1-tf)*tree[x].sum);
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r) div 2;
res:=0;
if f<=mid then res:=res+query(f,t,x*2);
if t>mid then res:=res+query(f,t,x*2+1);
update(x);
exit(res);
end;
begin
assign(input,'c.in');
reset(input);
assign(output,'c.out');
rewrite(output);
readln(n,opt);
for i:=1 to n do
    begin
    ti:=i;
    sa[i]:=sa[i-1]-ti*(ti+1);
    end;
for i:=1 to n do
    sb[i]:=sb[i-1]+i;
init(1,n-1,1);
for i:=1 to opt do
    begin
    read(ch);
    if ch='c' then
       begin
       for j:=1 to 6 do read(c);
       read(x,y,d);
       readln;
       modify(x,y-1,1);
       end
    else
       begin
       for j:=1 to 9 do read(c);
       read(x,y);
       value:=query(x,y-1,1);
       xx:=x; yy:=y;
       tmp:=(yy-xx+1)*(yy-xx)/2;
       value:=value/tmp;
       writeln(round(value*100)/100:0:2);
       readln;
       end;
    end;
close(input);
close(output);
end.
