const maxn=200;
type rec=record v,k,c:longint; end;
     rectype=record x,y1,y2,flag:longint; end;
     treetype=record l,r,cover:longint; end;
var xx,yy,zz,rr,tot,sum,ans,i,j,k,l,p,n,lower,higher:longint;
    f,tf:array[1..3,0..2*maxn]of rec;
    st,en,g:array[1..3,0..2*maxn]of longint;
    cnt:array[1..3]of longint;
    a:array[0..maxn,0..maxn,0..maxn]of longint;
    h:array[0..2*maxn]of rectype;
    tree,ttree:array[0..4*maxn]of treetype;
procedure sort(opt,l,r: longint);
      var i,j,x: longint; y:rec;
      begin
         i:=l; j:=r; x:=f[opt][(l+r) div 2].v;
         repeat
           while f[opt][i].v<x do inc(i);
           while x<f[opt][j].v do dec(j);
           if not(i>j) then begin y:=f[opt][i]; f[opt][i]:=f[opt][j]; f[opt][j]:=y; inc(i); j:=j-1; end;
         until i>j;
         if l<j then sort(opt,l,j);
         if i<r then sort(opt,i,r);
      end;
procedure sort2(l,r: longint);
      var
         i,j,x,t: longint;
         y:rectype;
      begin
         i:=l; j:=r; t:=h[(l+r)div 2].x;
          repeat
           while h[i].x<t do inc(i);
           while t<h[j].x do dec(j);
           if not(i>j) then begin y:=h[i]; h[i]:=h[j]; h[j]:=y; inc(i); dec(j); end;
         until i>j;
         if l<j then  sort2(l,j);
         if i<r then  sort2(i,r);
      end;
procedure init(f,t,x:longint);
var mid:longint;
begin
tree[x].l:=f; tree[x].r:=t; tree[x].cover:=0;
if f=t then exit;
mid:=(f+t)div 2;
init(f,mid,x*2);
init(mid+1,t,x*2+1);
end;
procedure insert(f,t,d,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].cover:=tree[x].cover+d;
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then insert(f,t,d,x*2);
if t>mid then insert(f,t,d,x*2+1);
end;
function query(x:longint):longint;
var res:longint;
begin
if tree[x].cover>0 then
   begin
   exit(g[2][tree[x].r+1]-g[2][tree[x].l]);
   end;
if tree[x].l=tree[x].r then exit(0);
res:=0;
res:=res+query(2*x);
res:=res+query(2*x+1);
exit(res);
end;
begin
assign(input,'cover.in');
reset(input);
assign(output,'cover.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(xx,yy,zz,rr);
    inc(tot); f[1][tot].v:=xx-rr; f[2][tot].v:=yy-rr; f[3][tot].v:=zz-rr;
    for j:=1 to 3 do begin f[j][tot].k:=i; f[j][tot].c:=1; end;
    inc(tot); f[1][tot].v:=xx+rr; f[2][tot].v:=yy+rr; f[3][tot].v:=zz+rr;
    for j:=1 to 3 do begin f[j][tot].k:=i; f[j][tot].c:=-1; end;
    end;
tf:=f;
for i:=1 to 3 do
    begin
    f:=tf;
    sort(i,1,2*n);
    j:=1;
    sum:=0;
    while j<=2*n do
      begin
      p:=j;
      inc(sum);
      g[i][sum]:=f[i][j].v;
      if f[i][j].c=1 then st[i][f[i][j].k]:=sum
         else en[i][f[i][j].k]:=sum;
      while (p+1<=2*n)and(f[i][p+1].v=f[i][j].v) do
        begin
        inc(p);
        if f[i][p].c=1 then st[i][f[i][p].k]:=sum
           else en[i][f[i][p].k]:=sum;
        end;
      j:=p+1;
      end;
    cnt[i]:=sum;
    end;
init(1,cnt[2]-1,1);
ttree:=tree;
for i:=1 to cnt[3]-1 do
    begin
    sum:=0; lower:=g[3][i]; higher:=g[3][i+1];
    tree:=ttree;
    for j:=1 to n do
        begin
        if (g[3][st[3][j]]<=lower)and(g[3][en[3][j]]>=higher) then
           begin
           inc(sum);
           h[sum].x:=st[1][j]; h[sum].y1:=st[2][j]; h[sum].y2:=en[2][j]; h[sum].flag:=1;
           inc(sum);
           h[sum].x:=en[1][j]; h[sum].y1:=st[2][j]; h[sum].y2:=en[2][j]; h[sum].flag:=-1;
           end;
        end;
    sort2(1,sum);
    for j:=1 to sum-1 do
        begin
        insert(h[j].y1,h[j].y2-1,h[j].flag,1);
        ans:=ans+(g[1][h[j+1].x]-g[1][h[j].x])*query(1)*(higher-lower);
        end;
    end;
writeln(ans);
close(input);
close(output);
end.