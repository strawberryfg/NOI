//19:39;
const maxn=10000020; maxm=200020; maxnumber=10000000;
type rec=record next:array[1..4]of longint; flag,dep,fall:longint; end;
var n,m,root,tot,i,x,t,head,tail,p,tx,ans:longint;
    fa,mark:array[0..maxnumber]of longint;
    tree:array[0..maxnumber]of rec;
    q:array[0..maxnumber]of longint;
    fin:array[0..maxm]of longint;
    s:array[0..maxn]of char;
    convert:array['A'..'Z']of longint;
    ch:char;
begin
assign(input,'symbol.in');
reset(input);
assign(output,'symbol.out');
rewrite(output);
readln(n,m);
convert['E']:=1; convert['S']:=2; convert['W']:=3; convert['N']:=4;
for i:=1 to n do read(s[i]);
readln;
root:=1; tot:=1;
tree[1].dep:=0; fa[1]:=0; tree[1].fall:=0;
for i:=1 to m do
    begin
    x:=root;
    while not eoln do
      begin
      read(ch);
      t:=convert[ch];
      if tree[x].next[t]=0 then
         begin
         inc(tot);
         tree[x].next[t]:=tot;
         fa[tot]:=x;
         tree[tot].dep:=tree[x].dep+1;
         end;
      x:=tree[x].next[t];
      end;
    inc(tree[x].flag);
    fin[i]:=x;
    readln;
    end;
head:=1; tail:=1; q[1]:=root;
while head<=tail do
   begin
   x:=q[head];
   for i:=1 to 4 do
       begin
       if tree[x].next[i]<>0 then
          begin
          if x=root then tree[tree[x].next[i]].fall:=root
             else begin
                  p:=tree[x].fall;
                  while (p<>0) do
                     begin
                     if (tree[p].next[i]<>0) then
                        begin
                        tree[tree[x].next[i]].fall:=tree[p].next[i];
                        break;
                        end;
                     p:=tree[p].fall;
                     end;
                  if p=0 then tree[tree[x].next[i]].fall:=root;
                  end;
          inc(tail); q[tail]:=tree[x].next[i];
          end;
       end;
   inc(head);
   end;
x:=root;
for i:=1 to n do
    begin
    t:=convert[s[i]];
    while (x<>root)and(tree[x].next[t]=0) do x:=tree[x].fall;
    x:=tree[x].next[t];
    if x=0 then x:=root;
    tx:=x;
    while (tx<>root)and(tree[tx].flag<>-1) do
      begin
      mark[tx]:=1;
      tree[tx].flag:=-1;
      tx:=tree[tx].fall;
      end;
    end;
for i:=1 to m do
    begin
    ans:=0;
    x:=fin[i];
    while (x<>root) do
      begin
      if mark[x]=1 then begin ans:=tree[x].dep; break; end;
      x:=fa[x];
      end;
    writeln(ans);
    end;
close(input);
close(output);
end.