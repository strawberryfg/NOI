uses math;
const maxn=60200; pai=3.141592653589793; eps=1e-12;
var n,i:longint;
    x,y,ceta:array[0..maxn]of extended;
    stack:array[0..maxn]of longint;
    xx,yy:array[0..4*maxn]of extended;
    a,b,r:extended;
procedure workone;
var ans:extended;
begin
ans:=(b-2*r)*2+(a-2*r)*2+2*pai*r;
writeln(ans:0:2);
end;
procedure sort(l,r: longint);
var i,j:longint;
    tx,ty,swap:extended;
begin
i:=l; j:=r; tx:=xx[(l+r) div 2]; ty:=yy[(l+r)div 2];
repeat
while (tx-xx[i]>eps)or((abs(tx-xx[i])<eps)and(ty-yy[i]>eps)) do inc(i);
while (xx[j]-tx>eps)or((abs(xx[j]-tx)<eps)and(yy[j]-ty>eps)) do dec(j);
if not(i>j) then begin swap:=xx[i]; xx[i]:=xx[j]; xx[j]:=swap; swap:=yy[i]; yy[i]:=yy[j]; yy[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function cross(u,v,w:longint):extended;
begin
exit((xx[v]-xx[u])*(yy[w]-yy[u])-(xx[w]-xx[u])*(yy[v]-yy[u]));
end;
function calc(u,v:longint):extended;
begin
exit(sqrt((xx[u]-xx[v])*(xx[u]-xx[v])+(yy[u]-yy[v])*(yy[u]-yy[v])));
end;
procedure workrzero;
var i,k,cnt,top:longint;
    alp,tsin,tcos,half,ans:extended;
begin
cnt:=0;
half:=sqrt((a/2)*(a/2)+(b/2)*(b/2))-sqrt(2)*r;
for i:=1 to n do
    begin
    alp:=arctan((a/2-r)/(-(b/2-r)));
    alp:=alp+pai;
    tsin:=sin(alp+ceta[i]); tcos:=cos(alp+ceta[i]);
    tsin:=tsin*half;
    tcos:=tcos*half;
    inc(cnt); yy[cnt]:=y[i]+tsin; xx[cnt]:=x[i]+tcos;

    alp:=arcsin((a/2-r)/half);
    alp:=alp-pai;
    tsin:=sin(alp+ceta[i]); tcos:=cos(alp+ceta[i]);
    tsin:=tsin*half;
    tcos:=tcos*half;
    inc(cnt); yy[cnt]:=y[i]+tsin; xx[cnt]:=x[i]+tcos;

    alp:=arctan((-(a/2-r))/(b/2-r));
    tsin:=sin(alp+ceta[i]); tcos:=cos(alp+ceta[i]);
    tsin:=tsin*half;
    tcos:=tcos*half;
    inc(cnt); yy[cnt]:=y[i]+tsin; xx[cnt]:=x[i]+tcos;

    alp:=arcsin((a/2-r)/half);
    tsin:=sin(alp+ceta[i]); tcos:=cos(alp+ceta[i]);
    tsin:=tsin*half;
    tcos:=tcos*half;
    inc(cnt); yy[cnt]:=y[i]+tsin; xx[cnt]:=x[i]+tcos;
    end;
sort(1,cnt);
top:=0;
for i:=1 to cnt do
    begin
    while (top>1)and(cross(stack[top-1],stack[top],i)<=0) do dec(top);
    inc(top); stack[top]:=i;
    end;
k:=top;
for i:=cnt-1 downto 1 do
    begin
    while (top>k)and(cross(stack[top-1],stack[top],i)<=0) do dec(top);
    inc(top); stack[top]:=i;
    end;
dec(top);
ans:=0;
for i:=2 to top do
    begin
    ans:=ans+calc(stack[i-1],stack[i]);
    end;
ans:=ans+calc(stack[top],stack[1]);
ans:=ans+2*pai*r;
writeln(ans:0:2);
end;
begin
assign(input,'card.in');
reset(input);
assign(output,'card.out');
rewrite(output);
readln(n);
readln(a,b,r);
for i:=1 to n do readln(x[i],y[i],ceta[i]);
if n=1 then workone
   else workrzero;
close(input);
close(output);
end.
