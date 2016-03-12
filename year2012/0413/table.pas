const maxq=7000000; maxn=7000000; inf=maxlongint;
type rec=array[1..20]of integer;
     re=record x:rec; v:qword; dfn:longint; end;
     treetype=record d:array[0..1]of integer; v:qword; l,r:longint; end;
var n,i,j,f1,f2,root,tot,ans,t,tt:longint;
    st,en,tmp:rec;
    head,tail,hou,qian:array[0..1]of longint; //pointer;
    q:array[0..1,0..maxq]of re;
    fac:array[0..20]of qword;
    st1,en1:qword;
    tree:array[0..maxn]of treetype;
    b:array[0..1]of longint;
    convert:array[1..3,0..20]of longint;
procedure pre;
var i:longint;
begin
for i:=2 to n do
    convert[1][i-1]:=i;
convert[1][n]:=1;
for i:=1 to n-1 do
    convert[2][i+1]:=i;
convert[2][1]:=n;
for i:=3 to n do convert[3][i]:=i;
convert[3][1]:=2; convert[3][2]:=1;
end;
function cantor(x:rec):qword;
var res:qword;
    i,j,cnt:longint;
begin
res:=0;
for i:=1 to n-1 do
    begin
    cnt:=0;
    for j:=i+1 to n do begin if x[i]>x[j] then inc(cnt); end;
    res:=res+fac[n-i]*cnt;
    end;
res:=res+1;
cantor:=res;
end;
function cmp:longint;
var t1,t2:longint;
begin
t1:=(qian[0]-1)*maxq+tail[0]-((hou[0]-1)*maxq+head[0]);
t2:=(qian[1]-1)*maxq+tail[1]-((hou[1]-1)*maxq+head[1]);
if t1<t2 then exit(0) else exit(1);
end;
procedure insert(opt,step:longint; key:qword);
var x,lx:longint;
begin
if root=0 then
   begin
   tot:=1;;
   root:=1;
   tree[1].d[opt]:=step; tree[1].v:=key;
   exit;
   end;
x:=root;
while x<>0 do
  begin
  lx:=x;
  if key>tree[x].v then x:=tree[x].r
     else x:=tree[x].l;
  end;
if key>tree[lx].v then begin inc(tot); tree[lx].r:=tot; tree[tot].v:=key; tree[tot].d[opt]:=step; end
   else begin inc(tot); tree[lx].l:=tot; tree[tot].v:=key; tree[tot].d[opt]:=step; end;
end;
function check(opt:longint; key:qword):boolean;
var x:longint;
begin
x:=root;
while x<>0 do
  begin
  if key>tree[x].v then x:=tree[x].r
     else if key<tree[x].v then x:=tree[x].l
             else begin
                  if tree[x].d[opt]<>0 then exit(false);
                  if (opt=0)and(key=st1) then exit(false);
                  if (opt=1)and(key=en1) then exit(false);
                  break;
                  end;
  end;
exit(true);
end;
function find(opt:longint; key:qword):longint;
var x:longint;
begin
x:=root;
while x<>0 do
  begin
  if key>tree[x].v then x:=tree[x].r
     else if key<tree[x].v then x:=tree[x].l
             else begin
                  if tree[x].d[opt]<>0 then exit(tree[x].d[opt]);
                  if (opt=0)and(key=st1) then exit(0);
                  if (opt=1)and(key=en1) then exit(0);
                  exit(-1);
                  end;
  end;
exit(-1);
end;
procedure expand(opt:longint);
var i,res,u:longint;
    t:qword;
    flag:boolean;
begin
for u:=1 to 3 do
    begin
    for i:=1 to n do tmp[i]:=q[opt][head[opt]].x[convert[u][i]];
    t:=cantor(tmp);
    flag:=check(opt,t);
    if not flag then continue;
    res:=find(1-opt,t);
    if res<>-1 then
       begin
       if res+q[opt][head[opt]].dfn+1<ans then
          ans:=res+q[opt][head[opt]].dfn+1
       else
          exit;
       if (q[opt][head[opt]].dfn+1>=ans)or(q[opt][head[opt]].dfn+1>=30) then exit;
       end;
    inc(tail[opt]); if tail[opt]>maxq then begin inc(qian[opt]); tail[opt]:=1; end;
    q[opt][tail[opt]].x:=tmp;
    q[opt][tail[opt]].v:=t;
    q[opt][tail[opt]].dfn:=q[opt][head[opt]].dfn+1;
    insert(opt,q[opt][tail[opt]].dfn,t);
    end;
end;
begin
assign(input,'table.in');
reset(input);
assign(output,'table.out');
rewrite(output);
readln(n);
pre;
fac[0]:=1;
for i:=1 to n do fac[i]:=fac[i-1]*i;
for i:=1 to n do read(en[i]);
for i:=1 to n do st[i]:=i;
head[0]:=1; tail[0]:=1;
head[1]:=1; tail[1]:=1;
q[0][1].x:=st; q[1][1].x:=en;
q[0][1].v:=cantor(st); q[1][1].v:=cantor(en);
st1:=q[0][1].v; en1:=q[1][1].v;
root:=0; tot:=0;
insert(0,0,q[0][1].v);
insert(1,0,q[1][1].v);
hou[0]:=1; qian[0]:=1; hou[1]:=1; qian[1]:=1;
q[0][1].dfn:=0; q[1][1].dfn:=0;
f1:=0;
if (hou[0]<qian[0])or((hou[0]=qian[0])and(head[0]<=tail[0])) then f1:=1;
f2:=0;
if (hou[1]<qian[1])or((hou[1]=qian[1])and(head[1]<=tail[1])) then f2:=1;
ans:=inf;
while (f1=1)or(f2=1) do
  begin
  t:=cmp; b[0]:=t; b[1]:=1-t;
  for i:=0 to 1 do
      begin
      if (hou[b[i]]<qian[b[i]])or((hou[b[i]]=qian[b[i]])and(head[b[i]]<=tail[b[i]]))and(q[b[i]][head[b[i]]].dfn<=15) then
         expand(b[i]);
      inc(head[b[i]]); if head[b[i]]>maxq then begin inc(hou[b[i]]); head[b[i]]:=1; end;
      end;
  f1:=0;
  if (hou[0]<qian[0])or((hou[0]=qian[0])and(head[0]<=tail[0])) then f1:=1;
  f2:=0;
  if (hou[1]<qian[1])or((hou[1]=qian[1])and(head[1]<=tail[1])) then f2:=1;
  end;
if ans=inf then writeln(-1) else writeln(ans);
close(input);
close(output);
end.