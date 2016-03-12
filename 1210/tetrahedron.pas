const maxn=80000;
      con:array[1..3,1..4]of longint=
      ((4,2,1,3),(1,4,2,3),(2,1,4,3));
type rec=record l,r:longint; end;
var n,m,i,t,x,y,ans:longint;
    ch:char;
    tree:array[0..4*maxn]of rec;
    c,s:array[0..4*maxn,1..4]of longint;
    opt:array[0..maxn]of longint;
procedure init(f,t,x,p:longint);
var i:longint;
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then
   begin
   for i:=1 to 4 do c[x][i]:=con[opt[f]][i];
   for i:=1 to 4 do
       begin
       s[x][i]:=0;
       if con[opt[f]][i]=4 then s[x][i]:=1;
       end;
   exit;
   end;
init(f,(f+t)div 2,x*2,p);
init((f+t)div 2+1,t,x*2+1,c[x*2][p]);
for i:=1 to 4 do
    begin
    s[x][i]:=s[2*x][i]+s[2*x+1][c[2*x][i]];
    c[x][i]:=c[2*x+1][c[2*x][i]];
    end;
end;
function query(f,t,x,p:longint):longint;
var res,mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
    exit(s[x][p]);
mid:=(tree[x].l+tree[x].r)div 2;
res:=0;
if f<=mid then res:=res+query(f,t,x*2,p);
if t>mid then res:=res+query(f,t,x*2+1,c[x*2][p]);
exit(res);
end;
procedure modify(f,t,x,p:longint);
var mid,i:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   for i:=1 to 4 do c[x][i]:=con[opt[f]][i];
   for i:=1 to 4 do
       begin
       s[x][i]:=0;
       if con[opt[f]][i]=4 then s[x][i]:=1;
       end;
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then modify(f,t,x*2,p);
if t>mid then modify(f,t,x*2+1,c[x*2][p]);
for i:=1 to 4 do
    begin
    s[x][i]:=s[2*x][i]+s[2*x+1][c[2*x][i]];
    c[x][i]:=c[2*x+1][c[2*x][i]];
    end;
end;
begin
assign(input,'tetrahedron.in');
reset(input);
assign(output,'tetrahedron.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    read(ch);
    if ch='L' then opt[i]:=1
       else if ch='R' then opt[i]:=2
               else opt[i]:=3;
    end;
readln;
readln(m);
init(1,n,1,4);
for i:=1 to m do
    begin
    read(t);
    if t=1 then
       begin
       read(x,y);
       if x=1 then begin  ans:=1; end else begin dec(x); ans:=0; end;
       ans:=ans+query(x,y-1,1,4);
       writeln(ans);
       end
    else
       begin
       read(x);
       read(ch);
       read(ch);
       if ch='L' then t:=1 else if ch='R' then t:=2 else t:=3;
       opt[x]:=t;
       modify(x,x,1,4);
       end;
    end;
close(input);
close(output);
end.
