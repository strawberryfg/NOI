const maxlen=10020;
type rec=record l,r:longint; v1,v2:int64; end;
var test,u,i,n:longint;
    p,mo,ans1,ans2:int64;
    pow:array[0..maxlen]of int64;
    tree:array[0..4*maxlen]of rec;
    a:array[0..maxlen]of longint;
    flag:boolean;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].v1:=0; tree[x].v2:=0;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure doit1(f,t,x:longint);
var mid,len:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   len:=tree[x].r-tree[x].l+1;
   ans1:=(ans1*pow[len]+tree[x].v1)mod mo;
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then doit1(f,t,x*2);
if t>mid then doit1(f,t,x*2+1);
end;
procedure doit2(f,t,x:longint);
var mid,len:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   len:=tree[x].r-tree[x].l+1;
   ans2:=(ans2*pow[len]+tree[x].v2)mod mo;
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if t>mid then doit2(f,t,x*2+1);
if f<=mid then doit2(f,t,x*2);
end;
procedure work(v,x:longint);
var mid,len:longint;
begin
if (tree[x].l<>tree[x].r) then
   begin
   if v<=(tree[x].l+tree[x].r)div 2 then work(v,x*2)
      else work(v,x*2+1);
   len:=tree[x*2+1].r-tree[x*2+1].l+1;
   tree[x].v1:=(tree[x*2].v1*pow[len]+tree[x*2+1].v1)mod mo;
   len:=tree[x*2].r-tree[x*2].l+1;
   tree[x].v2:=(tree[x*2+1].v2*pow[len]+tree[x*2].v2)mod mo;
   end
else
   begin
   tree[x].v1:=1;
   tree[x].v2:=1;
   end;
end;
begin
assign(input,'sequence.in');
reset(input);
assign(output,'sequence.out');
rewrite(output);
readln(test);
pow[0]:=1;
p:=2317; mo:=999983;
for i:=1 to maxlen do pow[i]:=pow[i-1]*p mod mo;
for u:=1 to test do
    begin
    readln(n);
    init(1,n,1);
    for i:=1 to n do read(a[i]);
    flag:=false;
    for i:=1 to n do
        begin
        ans1:=0;
        ans2:=0;
        if (a[i]<>1)and(a[i]<>n) then
           begin
           if n-a[i]>a[i]-1 then
              begin
              doit1(1,a[i]-1,1);
              doit2(a[i]+1,2*a[i]-1,1);
              if ans1<>ans2 then
                 begin
                 flag:=true;
                 break;
                 end;
              end
           else
              begin
              doit1(a[i]-(n-a[i]),a[i]-1,1);
              doit2(a[i]+1,n,1);
              if ans1<>ans2 then
                 begin
                 flag:=true;
                 break;
                 end;
              end;
           end;
        work(a[i],1);
        end;
    if flag then writeln('Y') else writeln('N');
    end;
close(input);
close(output);
end.
