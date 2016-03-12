const maxn=100200; maxv=maxlongint; inf=5555555555555555555;
type treetype=record left,right,son,ran:longint; key,min:qword; end;
var n,now,head,tail,i,tot,root,pd:longint;
    a,f:array[0..maxn]of qword;
    tree:array[0..8*maxn]of treetype;
    q:array[0..maxn]of longint;
    sum,w:qword;
function cmin(x,y:qword):qword;
begin
if x<y then cmin:=x else cmin:=y;
end;
procedure update(x:longint);
begin
tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
tree[x].min:=cmin(cmin(tree[tree[x].left].min,tree[tree[x].right].min),tree[x].key);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].left;
tree[x].left:=tree[y].right;
tree[y].right:=x;
update(x);
//update(y);
exit(y);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].right;
tree[x].right:=tree[y].left;
tree[y].left:=x;
update(x);
//update(y);
exit(y);
end;
function delete(x:longint; v:qword):longint;
begin
dec(tree[x].son);
if v<tree[x].key then tree[x].left:=delete(tree[x].left,v)
   else if v>tree[x].key then tree[x].right:=delete(tree[x].right,v)
           else begin
                if (tree[x].left=0)and(tree[x].right=0) then
                   exit(0);
                if tree[tree[x].left].ran>tree[tree[x].right].ran then
                   begin
                   x:=rightrotate(x);
                   tree[x].right:=delete(tree[x].right,v);
                   end
                else
                   begin
                   x:=leftrotate(x);
                   tree[x].left:=delete(tree[x].left,v);
                   end;
                end;
update(x);
exit(x);
end;
function insert(x:longint; v:qword):longint;
begin
if x=0 then
   begin
   inc(tot);
   tree[tot].left:=0; tree[tot].right:=0; tree[tot].ran:=random(maxv)+1; tree[tot].son:=0; tree[tot].key:=v;
   tree[tot].son:=1;  tree[tot].min:=v;
   exit(tot);
   end
else
   begin
   inc(tree[x].son);
   if v<tree[x].key then
      begin
      tree[x].left:=insert(tree[x].left,v);
      if tree[tree[x].left].ran>tree[x].ran then x:=rightrotate(x);
      end
   else
      begin
      tree[x].right:=insert(tree[x].right,v);
      if tree[tree[x].right].ran>tree[x].ran then x:=leftrotate(x);
      end;
   update(x);
   exit(x);
   end;
end;
begin
{assign(input,'cutseq.in');
reset(input);
assign(output,'cutseq.out');
rewrite(output);}
randomize;
readln(n,w);
sum:=0; now:=1; head:=1;tail:=0;
tree[0].min:=inf;
for i:=1 to n do read(a[i]);
pd:=0;
for i:=1 to n do
    begin
    sum:=sum+a[i];
    if a[i]>w then begin pd:=1; break; end;
    while (sum>w) do begin sum:=sum-a[now]; inc(now); end;
    if now>i then begin pd:=1; break; end;
    while (head<=tail)and(q[head]<now) do
      begin
      if head<tail then root:=delete(root,f[q[head]]+a[q[head+1]]);
      inc(head);
      end;
    while (head<=tail)and(a[q[tail]]<a[i]) do
      begin
      if head<tail then root:=delete(root,f[q[tail-1]]+a[q[tail]]);
      dec(tail);
      end;
    inc(tail); q[tail]:=i;
    if head<tail then root:=insert(root,f[q[tail-1]]+a[q[tail]]);
    f[i]:=f[now-1]+a[q[head]];
    f[i]:=cmin(tree[root].min,f[i]);
    end;
if pd=1 then writeln(-1) else writeln(f[n]);
{close(input);
close(output);}
end.