const maxn=52000;
type rec=record l,r,sum,max,lmax,rmax,delta:longint; end;
var tree:array[0..4*maxn+20]of rec;
    a:array[0..4*maxn]of longint;
    i,n,x,y,t,q:longint;
    tmp:rec;
function fmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function update(a,b,c:rec):rec;
var res:rec;
begin
res.sum:=a.sum+b.sum;
res.lmax:=fmax(a.lmax,a.sum+b.lmax);
res.rmax:=fmax(b.rmax,b.sum+a.rmax);
res.max:=fmax(a.max,b.max);
res.max:=fmax(res.max,a.rmax+b.lmax);
res.l:=c.l;
res.r:=c.r;
res.delta:=c.delta;
exit(res);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then
   begin
   tree[x].max:=a[f];
   tree[x].lmax:=a[f];
   tree[x].rmax:=a[f];
   tree[x].sum:=a[f];
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
tree[x]:=update(tree[x*2],tree[x*2+1],tree[x]);
end;
procedure lazydown(x:longint);
begin
if tree[x].delta<>0 then
   begin
   tree[x*2].delta:=tree[x*2].delta+tree[x].delta;
   tree[x*2+1].delta:=tree[x*2+1].delta+tree[x].delta;
   tree[x*2].max:=tree[x*2].max+tree[x].delta;
   tree[x*2].lmax:=tree[x*2].lmax+tree[x].delta;
   tree[x*2].rmax:=tree[x*2].rmax+tree[x].delta;
   tree[x*2].sum:=tree[x*2].sum+tree[x].delta*(tree[x*2].r-tree[x*2].l+1);
   tree[x*2+1].max:=tree[x*2+1].max+tree[x].delta;;
   tree[x*2+1].lmax:=tree[x*2+1].lmax+tree[x].delta;;
   tree[x*2+1].rmax:=tree[x*2+1].rmax+tree[x].delta;;
   tree[x*2+1].sum:=tree[x*2+1].sum+tree[x].delta*(tree[x*2+1].r-tree[x*2+1].l+1);
   tree[x].delta:=0;
   end;
end;
procedure modify(f,t,x,d:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(t>=tree[x].r) then
   begin
   tree[x].delta:=tree[x].delta+d-tree[x].sum;
   tree[x].max:=tree[x].max+d-tree[x].sum;
   tree[x].lmax:=tree[x].lmax+d-tree[x].sum;
   tree[x].rmax:=tree[x].rmax+d-tree[x].sum;
   tree[x].sum:=tree[x].sum+(d-tree[x].sum)*(tree[x].r-tree[x].l+1);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
lazydown(x);
if f<=mid then modify(f,t,x*2,d);
if t>mid then modify(f,t,x*2+1,d);
tree[x]:=update(tree[x*2],tree[x*2+1],tree[x]);
end;
function query(f,t,x:longint):rec;
var t1,t2,res:rec;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then exit(tree[x])
   else if t<=(tree[x].l+tree[x].r)div 2 then exit(query(f,t,x*2))
           else if f>(tree[x].l+tree[x].r)div 2 then exit(query(f,t,x*2+1))
                   else begin
                        t1:=query(f,t,x*2);
                        t2:=query(f,t,x*2+1);
                        res:=update(t1,t2,res);
                        exit(res);
                        end;
end;
begin
{assign(input,'gss3.in');
reset(input);}
readln(n);
for i:=1 to n do read(a[i]);
init(1,n,1);
readln(q);
for i:=1 to q do
    begin
    readln(t,x,y);
    if t=0 then modify(x,x,1,y)
       else begin
            tmp:=query(x,y,1);
            writeln(tmp.max);
            end;
    end;
//close(input);
end.
