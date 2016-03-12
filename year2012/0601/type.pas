const maxnode=100020; maxlen=500020; maxopt=500020;
type treetype=record next:array[1..26]of longint; fall,fa:longint; end;
     quetype=record u,v:longint; end;
     rec=record v,num,nxt:longint; end;
var i,len,root,tot,total,cnt,x,head,tail,id,opt,p,tme,n:longint;
    tree:array[0..maxnode]of treetype;
    s:array[0..maxlen]of char;
    ans:array[0..maxopt]of longint;
    que:array[0..maxopt]of quetype;
    edge,sta,dfn,ll,rr,bit,flag,q:array[0..maxnode]of longint;
    g,h:array[0..maxnode]of rec;
procedure addedge(x,y:longint);
begin
inc(total); g[total].v:=y; g[total].nxt:=edge[x]; edge[x]:=total;
end;
procedure addedge2(x,y,id:longint);
begin
inc(cnt); h[cnt].v:=y; h[cnt].num:=id; h[cnt].nxt:=sta[x]; sta[x]:=cnt;
end;
procedure solve(x,y:longint);
begin
tree[x].fall:=y;
addedge(y,x);
end;
procedure dfs2(x:longint);
var p:longint;
begin
inc(tme); dfn[x]:=tme; ll[x]:=tme;
p:=edge[x];
while p<>0 do
  begin
  dfs2(g[p].v);
  p:=g[p].nxt;
  end;
rr[x]:=tme;
end;
procedure modify(x,d:longint);
begin
while x<=tot do begin bit[x]:=bit[x]+d; x:=x+x and -x; end;
end;
function query(x:longint):longint;
begin
query:=0;
while x>0 do begin query:=query+bit[x]; x:=x-x and -x; end;
end;
begin
assign(input,'type.in');
reset(input);
assign(output,'type.out');
rewrite(output);
len:=0; root:=1; tot:=1; x:=root;
n:=0;
while not eoln do
  begin
  inc(len); read(s[len]);
  if s[len]='B' then x:=tree[x].fa
     else if s[len]='P' then begin inc(n); flag[n]:=x; end
             else begin
                  id:=ord(s[len])-ord('a')+1;
                  if tree[x].next[id]=0 then
                     begin
                     inc(tot);
                     tree[x].next[id]:=tot;
                     tree[tot].fa:=x;
                     end;
                  x:=tree[x].next[id];
                  end;
  end;
head:=1; tail:=1; q[1]:=root;
while head<=tail do
  begin
  for i:=1 to 26 do
      begin
      if tree[q[head]].next[i]<>0 then
         begin
         if q[head]=root then solve(tree[q[head]].next[i],root)
            else begin
                 p:=tree[q[head]].fall;
                 while p<>0 do
                   begin
                   if tree[p].next[i]<>0 then begin solve(tree[q[head]].next[i],tree[p].next[i]); break; end;
                   p:=tree[p].fall;
                   end;
                 if p=0 then solve(tree[q[head]].next[i],root);
                 end;
         inc(tail); q[tail]:=tree[q[head]].next[i];
         end;
      end;
  inc(head);
  end;
readln(opt);
for i:=1 to opt do
    begin
    readln(que[i].u,que[i].v);
    addedge2(flag[que[i].v],flag[que[i].u],i);
    end;
dfs2(root);
x:=root;
for i:=1 to len do
    begin
    if s[i]='B' then begin modify(dfn[x],-1); x:=tree[x].fa; end
       else if s[i]='P' then
               begin
               p:=sta[x];
               while p<>0 do
                 begin
                 ans[h[p].num]:=query(rr[h[p].v])-query(ll[h[p].v]-1);
                 p:=h[p].nxt;
                 end;
               end
            else begin
                 x:=tree[x].next[ord(s[i])-ord('a')+1];
                 modify(dfn[x],1);
                 end;
    end;
for i:=1 to opt do writeln(ans[i]);
close(input);
close(output);
end.