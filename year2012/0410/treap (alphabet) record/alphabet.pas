const maxn=20020; maxm=2020; maxm2=1000020; maxv=maxlongint;
type rec=record ch:char; nxt:longint; end;
     treetype=record key:char; left,right,son,num:longint; end;
var test,u,n,cnt,m,i,j,now,tot,tmp,root:longint;
    s:array[0..maxn]of char;
    g:array[0..maxn+maxm]of rec;
    tree:array[0..maxn+maxm2]of treetype;
function find(x,remain:longint):longint;
begin
if tree[tree[x].left].son>=remain then exit(find(tree[x].left,remain))
   else begin
        if tree[tree[x].left].son+1=remain then exit(x)
           else exit(find(tree[x].right,remain-1-tree[tree[x].left].son));
        end;
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].right;
tree[x].right:=tree[y].left;
tree[y].left:=x;
tree[y].son:=tree[x].son;
tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
exit(y);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=tree[x].left;
tree[x].left:=tree[y].right;
tree[y].right:=x;
tree[y].son:=tree[x].son;
tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
exit(y);
end;
function insert(x,f:longint; ch:char):longint;
begin
if x=0 then
   begin
   inc(tot);
   tree[tot].key:=ch;
   tree[tot].son:=1;
   tree[tot].num:=random(maxv)+1;
   tree[tot].left:=0; tree[tot].right:=0;
   exit(tot);
   end;
if f>tree[tree[x].left].son+1 then
   begin
   tree[x].right:=insert(tree[x].right,f-tree[tree[x].left].son-1,ch);
   if tree[tree[x].right].num>tree[x].num then
      x:=leftrotate(x);
   tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
   exit(x);
   end
else
   begin
   tree[x].left:=insert(tree[x].left,f,ch);
   if tree[tree[x].left].num>tree[x].num then
      x:=rightrotate(x);
   tree[x].son:=tree[tree[x].left].son+tree[tree[x].right].son+1;
   exit(x);
   end;
end;
procedure work1;
var len,now,i,p,tmp:longint;
    ss:char;
begin
for i:=0 to n+m+2 do begin tree[i].left:=0; tree[i].right:=0; tree[i].son:=0; tree[i].num:=0; tree[i].key:=' '; end;
tot:=0; root:=0;
for i:=1 to n do
    root:=insert(root,i,s[i]);
len:=n;
now:=1;
for i:=1 to m do
    begin
    if now+cnt<=len then
       begin
       p:=find(root,now+cnt);
       if tree[p].key='Z' then ss:='A' else ss:=char(ord(tree[p].key)+1);
       root:=insert(root,now+cnt+1,ss);
       now:=now+cnt+1;
       inc(len);
       end
    else
       begin
       tmp:=cnt-(len-now);
       tmp:=tmp mod len;
       if tmp=0 then tmp:=len;
       p:=find(root,tmp);
       if tree[p].key='Z' then ss:='A' else ss:=char(ord(tree[p].key)+1);
       root:=insert(root,tmp+1,ss);
       now:=tmp+1;
       inc(len);
       end;
    end;
writeln(ss);
end;
begin
assign(input,'alphabet.in');
reset(input);
assign(output,'alphabet.out');
rewrite(output);
readln(test);
randomize;
for u:=1 to test do
    begin
    readln(n,cnt,m);
    for i:=1 to n do
        begin
        read(s[i]);
        end;
    if m<=1000 then
       begin
       for i:=1 to n do
           begin
           g[i].ch:=s[i];
           g[i].nxt:=i+1;
           end;
       g[n].nxt:=1;
       now:=1;
       tot:=n;
       for i:=1 to m do
           begin
           for j:=1 to cnt do
               begin
               now:=g[now].nxt;
               end;
           inc(tot);
           if ord(g[now].ch)=90 then g[tot].ch:='A'
              else g[tot].ch:=char(ord(g[now].ch)+1);
           tmp:=g[now].nxt;
           g[now].nxt:=tot;
           g[tot].nxt:=tmp;
           now:=tot;
           end;
       writeln(g[now].ch);
       end
    else
       work1;
    end;
close(input);
close(output);
end.

