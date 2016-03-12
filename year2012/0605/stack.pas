const maxn=120000; maxv=maxlongint;
type treetype=record root,tot:longint; son,left,right,key,ran:array[0..maxn]of longint; end;
var n,m,i,num,id,x:longint;
    tree:array[1..27]of treetype;
    a:array[0..maxn]of char;
    ch,c:char;
procedure update(x,opt:longint);
begin
tree[opt].son[x]:=tree[opt].son[tree[opt].left[x]]+tree[opt].son[tree[opt].right[x]]+1;
end;
function leftrotate(x,opt:longint):longint;
var y:longint;
begin
y:=tree[opt].right[x];
tree[opt].right[x]:=tree[opt].left[y];
tree[opt].left[y]:=x;
update(x,opt);
update(y,opt);
exit(y);
end;
function rightrotate(x,opt:longint):longint;
var y:longint;
begin
y:=tree[opt].left[x];
tree[opt].left[x]:=tree[opt].right[y];
tree[opt].right[y]:=x;
update(x,opt);
update(y,opt);
exit(y);
end;
function insert(x,v,opt:longint):longint;
var cnt:longint;
begin
if x=0 then
   begin
   inc(tree[opt].tot);
   cnt:=tree[opt].tot;
   tree[opt].son[cnt]:=1; tree[opt].key[cnt]:=v; tree[opt].ran[cnt]:=random(maxv)+1;
   exit(tree[opt].tot);
   end
else
   begin
   inc(tree[opt].son[x]);
   if v<tree[opt].key[x] then
      begin
      tree[opt].left[x]:=insert(tree[opt].left[x],v,opt);
      if tree[opt].ran[tree[opt].left[x]]>tree[opt].ran[x] then
         x:=rightrotate(x,opt);
      end
   else
      begin
      tree[opt].right[x]:=insert(tree[opt].right[x],v,opt);
      if tree[opt].ran[tree[opt].right[x]]>tree[opt].ran[x] then
         x:=leftrotate(x,opt);
      end;
   update(x,opt);
   exit(x);
   end;
end;
function delete(x,v,opt:longint):longint;
begin
if v<tree[opt].key[x] then tree[opt].left[x]:=delete(tree[opt].left[x],v,opt)
   else if v>tree[opt].key[x] then tree[opt].right[x]:=delete(tree[opt].right[x],v,opt)
           else begin
                if (tree[opt].left[x]=0)and(tree[opt].right[x]=0) then exit(0);
                if tree[opt].ran[tree[opt].left[x]]>tree[opt].ran[tree[opt].right[x]] then
                   begin
                   x:=rightrotate(x,opt);
                   tree[opt].right[x]:=delete(tree[opt].right[x],v,opt);
                   end
                else
                   begin
                   x:=leftrotate(x,opt);
                   tree[opt].left[x]:=delete(tree[opt].left[x],v,opt);
                   end;
                end;
update(x,opt);
exit(x);
end;
function find(opt,x,v:longint):longint;
begin
if tree[opt].son[tree[opt].left[x]]+1=v then exit(x);
if tree[opt].son[tree[opt].left[x]]>=v then exit(find(opt,tree[opt].left[x],v))
   else exit(find(opt,tree[opt].right[x],v-1-tree[opt].son[tree[opt].left[x]]));
end;
function getk(x:longint):longint;
var le,ri,mid,xx1,xx2,tmp1,tmp2:longint;
begin
if tree[27].tot=0 then exit(x);
le:=1; ri:=tree[27].tot;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if mid=1 then
     begin
     xx1:=find(27,tree[27].root,1);
     xx1:=tree[27].key[xx1];
     if x<xx1 then exit(x) else le:=mid+1;
     end
  else
     begin
     xx1:=find(27,tree[27].root,mid-1);
     xx1:=tree[27].key[xx1];
     xx2:=find(27,tree[27].root,mid);
     xx2:=tree[27].key[xx2];
     tmp1:=xx1-(mid-1)+1;
     tmp2:=xx2-mid;
     if (tmp1<=x)and(x<=tmp2) then exit(xx1+1+x-tmp1);
     if x>tmp2 then le:=mid+1
        else ri:=mid-1;
     end;
  end;
xx1:=find(27,tree[27].root,tree[27].tot);
xx1:=tree[27].key[xx1];
tmp1:=xx1-tree[27].tot+1;
exit(xx1+1+x-tmp1);
end;
function get2(x:longint):longint;
var le,ri,mid,xx1,xx2,tmp1,tmp2:longint;
begin
le:=1; ri:=tree[27].tot;
if tree[27].tot=0 then exit(x);
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if mid=1 then
     begin
     xx1:=find(27,tree[27].root,1);
     xx1:=tree[27].key[xx1];
     if x<xx1 then exit(x) else le:=mid+1;
     end
  else
     begin
     xx1:=find(27,tree[27].root,mid-1);
     xx1:=tree[27].key[xx1];
     xx2:=find(27,tree[27].root,mid);
     xx2:=tree[27].key[xx2];
     tmp1:=xx1-(mid-1);
     tmp2:=xx2-mid;
     if (xx1<=x)and(x<=xx2) then exit(tmp1+x-xx1);
     if x>xx2 then le:=mid+1
        else ri:=mid-1;
     end;
  end;
xx1:=find(27,tree[27].root,tree[27].tot);
xx1:=tree[27].key[xx1];
tmp1:=xx1-tree[27].tot;
exit(tmp1+x-xx1);
end;
begin
assign(input,'stack.in');
reset(input);
assign(output,'stack.out');
rewrite(output);
readln(m);
n:=0;
for i:=1 to m do
    begin
    read(ch);
    if ch='p' then
       begin
       read(c); read(c);
       inc(n);
       a[n]:=c;
       id:=ord(c)-ord('a')+1;
       tree[id].root:=insert(tree[id].root,n,id);
       end
    else if ch='r' then
            begin
            read(c);
            num:=0;
            while not eoln do begin read(c); num:=num*10+ord(c)-48; end;
            x:=getk(num);
            id:=ord(a[x])-ord('a')+1;
            tree[id].root:=delete(tree[id].root,x,id);
            tree[27].root:=insert(tree[27].root,x,27);
            a[x]:='#';
            end
         else if ch='q' then
                 begin
                 read(c);
                 num:=0;
                 while not eoln do
                   begin
                   read(c);
                   if c=' ' then break;
                   num:=num*10+ord(c)-48;
                   end;
                 read(c);
                 id:=ord(c)-ord('a')+1;
                 x:=find(id,tree[id].root,num);
                 x:=tree[id].key[x];
                 x:=get2(x);
                 writeln(x);
                 end
              else begin
                   read(c);
                   num:=0;
                   while not eoln do begin read(c); num:=num*10+ord(c)-48; end;
                   x:=getk(num);
                   writeln(a[x]);
                   end;
    readln;
    end;
close(input);
close(output);
end.
