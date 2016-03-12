const inf=100000000;
      maxn=300020;
type rec=record lmax,rmax,max,v,sum:longint; end;
var n,i,q,tot,root,x,y:longint;
    tree:array[0..maxn]of rec;
    son,num,left,right,a:array[0..maxn]of longint;
    res,p:rec;
    c,ch:char;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure update(x:longint);
begin
if x=0 then exit;
son[x]:=son[left[x]]+son[right[x]]+1;
tree[x].sum:=tree[left[x]].sum+tree[right[x]].sum+tree[x].v;
if (left[x]=0)and(right[x]=0) then
    begin
    tree[x].lmax:=tree[x].v;
    tree[x].rmax:=tree[x].v;
    tree[x].max:=tree[x].v;
    exit;
    end;
if (right[x]=0) then
   begin
   tree[x].lmax:=max(tree[left[x]].lmax,tree[left[x]].sum+tree[x].v);
   tree[x].rmax:=max(tree[x].v,tree[x].v+tree[left[x]].rmax);
   tree[x].max:=max(tree[x].lmax,tree[x].rmax);
   tree[x].max:=max(tree[x].max,tree[left[x]].max);
   exit;
   end;
if (left[x]=0) then
   begin
   tree[x].lmax:=max(tree[x].v,tree[x].v+tree[right[x]].lmax);
   tree[x].rmax:=max(tree[right[x]].rmax,tree[right[x]].sum+tree[x].v);
   tree[x].max:=max(tree[x].lmax,tree[x].rmax);
   tree[x].max:=max(tree[x].max,tree[right[x]].max);
   exit;
   end;
tree[x].lmax:=max(tree[left[x]].lmax,tree[left[x]].sum+tree[x].v+tree[right[x]].lmax);
tree[x].lmax:=max(tree[x].lmax,tree[left[x]].sum+tree[x].v);
tree[x].rmax:=max(tree[right[x]].rmax,tree[right[x]].sum+tree[x].v+tree[left[x]].rmax);
tree[x].rmax:=max(tree[x].rmax,tree[right[x]].sum+tree[x].v);
tree[x].max:=max(tree[x].v,max(tree[x].v+tree[left[x]].rmax,tree[x].v+tree[right[x]].lmax));
tree[x].max:=max(tree[x].max,tree[left[x]].rmax+tree[x].v+tree[right[x]].lmax);
tree[x].max:=max(tree[x].max,max(tree[left[x]].max,tree[right[x]].max));
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
update(x);
update(y);
exit(y);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
update(x);
update(y);
exit(y);
end;
function insert(var root:longint;v,k:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   tree[tot].v:=v; son[tot]:=1; tree[tot].sum:=v; tree[tot].lmax:=v; tree[tot].rmax:=v; tree[tot].max:=v;
   num[tot]:=random(inf)+1;
   root:=tot;
   exit(root);
   end;
if son[left[root]]+1>=k then
   begin
   left[root]:=insert(left[root],v,k);
//   update(root);
   if num[left[root]]>num[root] then root:=rightrotate(root);
   update(root);
   end
else
   if son[left[root]]+1<k then
      begin
      right[root]:=insert(right[root],v,k-1-son[left[root]]);
//      update(root);
      if num[right[root]]>num[root] then root:=leftrotate(root);
      update(root);
      end;

exit(root);
end;
function delete(var root:longint; k:longint):longint;
begin
if (left[root]=0)and(right[root]=0) then
   begin
   exit(0);
   end;
if son[left[root]]+1>k then
   begin
   left[root]:=delete(left[root],k);
   end
else if son[left[root]]+1<k then
        begin
        right[root]:=delete(right[root],k-1-son[left[root]]);
        end
     else
        begin
        if num[left[root]]>num[right[root]] then
           begin
           root:=rightrotate(root);
           right[root]:=delete(right[root],k-1-son[left[root]]);
           end
        else
           begin
           root:=leftrotate(root);
           left[root]:=delete(left[root],k);
           end;
        end;
update(root);
exit(root);
end;
procedure modify(root,v,k:longint);
begin
if son[left[root]]>=k then
   begin
   modify(left[root],v,k);
   end
else if son[left[root]]+1<k then
        begin
        modify(right[root],v,k-son[left[root]]-1);
        end
     else
        begin
        tree[root].v:=v;
        if (left[root]=0)and(right[root]=0) then
           begin
           tree[root].lmax:=v;
           tree[root].rmax:=v;
           tree[root].max:=v;
           tree[root].sum:=v;
           end;
        end;
update(root);
end;
function query(x,l,r:longint):rec;
var m,a,b:rec;
begin

if x=0 then
   exit(p);
if (1=l)and(r=son[x]) then exit(tree[x]);
if r<=son[left[x]] then exit(query(left[x],l,r))
   else if son[left[x]]+1<l then exit(query(right[x],l-son[left[x]]-1,r-son[left[x]]-1))
           else
                begin
                   a:=p; b:=p;
                   m:=p;
                   if (l<=son[left[x]]) then a:=query(left[x],l,son[left[x]]);
                   if (r>son[left[x]]+1) then b:=query(right[x],1,r-son[left[x]]-1);
                   if (l=r)and(l=son[left[x]]+1) then
                      begin
                      m.lmax:=tree[x].v;
                      m.rmax:=tree[x].v;
                      m.max:=tree[x].v;
                      m.sum:=tree[x].v;
                      exit(m);
                      end;
                   m.lmax:=max(a.lmax,a.sum+tree[x].v+max(0,b.lmax));
                   m.rmax:=max(b.rmax,b.sum+tree[x].v+max(0,a.rmax));
                   m.max:=max(a.rmax+b.lmax+tree[x].v,a.rmax+tree[x].v);
                   m.max:=max(m.max,b.lmax+tree[x].v);
                   m.max:=max(m.max,tree[x].v);
                   m.max:=max(m.max,a.max);
                   m.max:=max(m.max,b.max);
                   m.sum:=a.sum+b.sum+tree[x].v;
                   exit(m);
                end;
end;
begin
{assign(input,'gss6.in');
reset(input);
assign(output,'e:\gss6.out');
rewrite(output);}
readln(n);
//randomize;
for i:=1 to n do read(a[i]);
readln(q);
{tot:=2;
right[1]:=2;  son[1]:=2; son[2]:=1;
root:=1;}
for i:=1 to n do
    begin
    root:=insert(root,a[i],i);
    end;
p.lmax:=-inf; p.rmax:=-inf; p.max:=-inf;
for i:=1 to q do
    begin
    read(ch);
    read(c);
    if ch='I' then
       begin
       read(x,y);
       root:=insert(root,y,x);
       end
    else if ch='D' then
            begin
            read(x);
            root:=delete(root,x);
            end
         else if ch='R' then
                 begin
                 read(x); read(y);
                 modify(root,y,x);
                 end
              else begin
                   read(x,y);
//                   inc(x); inc(y);
                   res:=query(root,x,y);
                   writeln(res.max);
                   end;
    readln;
    end;
{close(input);
close(output);}
end.