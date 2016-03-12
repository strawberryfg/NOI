const maxnumber=100; base=100000;
type rec=record next:array[1..4]of longint; flag,fall:longint; end;
     edgetype=record v,nxt:longint; end;
     arr=array[0..maxnumber,0..maxnumber]of qword;
var kind,n,root,tot,i,j,k,x,head,tail,p,total:longint;
    tree:array[0..maxnumber]of rec;
    edge,can,mark,q:array[0..maxnumber]of longint;
    h:array[0..10*maxnumber]of edgetype;
    con:array['A'..'Z']of longint;
    g,c,ans,std:arr;
    state:array[0..maxnumber,0..4]of longint;
    final:qword;
    ch:char;
procedure addedge(x,y:longint);
begin
inc(total); h[total].v:=y; h[total].nxt:=edge[x]; edge[x]:=total;
end;
procedure make(x,y:longint);
begin
tree[x].fall:=y;
addedge(y,x);
end;
function mul(x,y:arr):arr;
var i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for k:=1 to tot do
    for i:=1 to tot do
        begin
        if x[i][k]<>0 then
           for j:=1 to tot do
               c[i][j]:=(c[i][j]+x[i][k]*y[k][j]mod base)mod base;
        end;
mul:=c;
end;
procedure quick(x:longint);
begin
ans:=g;
std:=g;
dec(x);
while x>0 do
  begin
  if x mod 2=1 then ans:=mul(ans,std);
  std:=mul(std,std);
  x:=x div 2;
  end;
end;
begin
{assign(input,'dna.in');
reset(input);}
readln(kind,n);
root:=1; tot:=1;
for i:=1 to kind do
    begin
    x:=root;
    con['A']:=1; con['C']:=2; con['T']:=3; con['G']:=4;
    while not eoln do
      begin
      read(ch);
      if tree[x].next[con[ch]]=0 then
         begin
         inc(tot);
         tree[x].next[con[ch]]:=tot;
         end;
      x:=tree[x].next[con[ch]];
      end;
    readln;
    inc(tree[x].flag);
    mark[i]:=x;
    end;
head:=1; tail:=1; q[1]:=root;
while head<=tail do
  begin
  for i:=1 to 4 do
      begin
      if tree[q[head]].next[i]<>0 then
         begin
         if q[head]=root then make(tree[q[head]].next[i],root)
            else begin
                 p:=tree[q[head]].fall;
                 while p<>0 do
                   begin
                   if tree[p].next[i]<>0 then
                      begin
                      make(tree[q[head]].next[i],tree[p].next[i]);
                      break;
                      end;
                   p:=tree[p].fall;
                   end;
                 if p=0 then make(tree[q[head]].next[i],root);
                 end;
         inc(tail); q[tail]:=tree[q[head]].next[i];
         end;
      end;
  inc(head);
  end;
for i:=1 to tot do can[i]:=1;
for i:=1 to kind do
    begin
    if can[mark[i]]=0 then continue;
    can[mark[i]]:=0;
    head:=1; tail:=1; q[1]:=mark[i];
    while head<=tail do
      begin
      can[q[head]]:=0;
      p:=edge[q[head]];
      while p<>0 do
        begin
        inc(tail);
        q[tail]:=h[p].v;
        p:=h[p].nxt;
        end;
      inc(head);
      end;
    end;
for i:=1 to tot do
    begin
    if can[i]=0 then continue;
    for j:=1 to 4 do
        begin
        x:=i;
        while (x<>root)and(tree[x].next[j]=0) do x:=tree[x].fall;
        x:=tree[x].next[j];
        if x=0 then x:=root;
        state[i][j]:=x;          //state i +spe[j] to state x
        end;
    end;
for i:=1 to tot do
    begin
    if can[i]=0 then continue;
    for j:=1 to tot do
        begin
        for k:=1 to 4 do
            if state[j][k]=i then inc(g[i][j]);
        end;
    end;
quick(n);
final:=0;
for i:=1 to tot do final:=(final+ans[i][1])mod base;
writeln(final);
//close(input);
end.