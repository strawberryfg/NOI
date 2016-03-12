const maxn=700200; maxv=maxlongint;
var n,m,i,j,up,x,y,t1,t2,oritop,ans,top,tot,opt:longint;
    left,right,size,key,num,root,ori,rank,fa,stack,a:array[0..maxn]of longint;
    ch,c:char;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
size[y]:=size[x];
size[x]:=size[left[x]]+size[right[x]]+1;
exit(y);
end;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
size[y]:=size[x];
size[x]:=size[left[x]]+size[right[x]]+1;
exit(y);
end;
function insert(x,v,f:longint):longint;
var now:longint;
begin
if x=0 then
   begin
   if top>0 then begin now:=stack[top]; dec(top); end
      else begin inc(tot); now:=tot; end;
   key[now]:=v;
   num[now]:=random(maxv)+1;
   ori[now]:=f;
   left[now]:=0; right[now]:=0; size[now]:=1;
   exit(now);
   end
else
   begin
   inc(size[x]);
   if v<key[x] then
      begin
      left[x]:=insert(left[x],v,f);
      if num[left[x]]>num[x] then x:=rightrotate(x);
      end
   else
      begin
      right[x]:=insert(right[x],v,f);
      if num[right[x]]>num[x] then x:=leftrotate(x);
      end;
   exit(x);
   end;
end;
procedure dfs(x:longint);
begin
if x=0 then exit;
dfs(left[x]);
inc(top); stack[top]:=x;
dfs(right[x]);
end;
function find(x,k:longint):longint;
begin
if size[left[x]]>=k then exit(find(left[x],k))
   else if size[left[x]]+1=k then exit(ori[x])
           else exit(find(right[x],k-1-size[left[x]]));
end;
begin
assign(input,'neverland.in');
reset(input);
assign(output,'neverland.out');
rewrite(output);
readln(n,m);
for i:=1 to n do read(a[i]);
top:=0;
for i:=1 to n do
    begin
    fa[i]:=i;
    rank[i]:=1;
    root[i]:=insert(root[i],a[i],i);
    end;
for i:=1 to m do
    begin
    readln(x,y);
    t1:=getfa(x); t2:=getfa(y);
    if rank[t1]>rank[t2] then
       begin
       fa[t2]:=t1;
       rank[t1]:=rank[t1]+rank[t2];
       oritop:=top;
       dfs(root[t2]);
       up:=top-oritop;
       for j:=1 to up do
           root[t1]:=insert(root[t1],key[stack[j]],ori[stack[j]]);
       end
    else
       begin
       fa[t1]:=t2;
       rank[t2]:=rank[t2]+rank[t1];
       oritop:=top;
       dfs(root[t1]);
       up:=top-oritop;
       for j:=1 to up do
           root[t2]:=insert(root[t2],key[stack[j]],ori[stack[j]]);
       end;
    end;
readln(opt);
for i:=1 to opt do
    begin
    read(ch); read(c);
    if ch='B' then
       begin
       read(x,y);
       t1:=getfa(x); t2:=getfa(y);
       if t1<>t2 then
          begin
          if rank[t1]>rank[t2] then
             begin
             fa[t2]:=t1;
             rank[t1]:=rank[t1]+rank[t2];
             oritop:=top;
             dfs(root[t2]);
             up:=top-oritop;
             for j:=1 to up do
                 root[t1]:=insert(root[t1],key[stack[j]],ori[stack[j]]);
             end
          else
             begin
             fa[t1]:=t2;
             rank[t2]:=rank[t2]+rank[t1];
             oritop:=top;
             dfs(root[t1]);
             up:=top-oritop;
             for j:=1 to up do
                 root[t2]:=insert(root[t2],key[stack[j]],ori[stack[j]]);
             end;
          end;
       end
    else
       begin
       read(x,y);
       t1:=getfa(x);
       if y>size[root[t1]] then writeln(-1)
          else begin
               ans:=find(root[t1],y);
               writeln(ans);
               end;
       end;
    readln;
    end;
close(input);
close(output);
end.
