//19:15;
uses math;
const eps=1e-10; maxn=1200;
type rec=record l,r:extended; end;
var n,i,num,top:longint;
    le,ri,mid,ans,ansx,ansy,zero:extended;
    x,y:array[0..maxn]of extended;
    stack:array[0..maxn]of rec;
procedure sort1(l,r: longint);
var i,j: longint;
    t,tmp:extended;
begin
i:=l; j:=r; t:=stack[(l+r) div 2].l;
repeat
while t-stack[i].l>eps do inc(i);
while stack[j].l-t>eps do dec(j);
if not(i>j) then begin tmp:=stack[i].l; stack[i].l:=stack[j].l; stack[j].l:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort1(l,j);
if i<r then sort1(i,r);
end;
procedure sort2(l,r: longint);
var i,j: longint;
    t,tmp:extended;
begin
i:=l; j:=r; t:=stack[(l+r) div 2].r;
repeat
while t-stack[i].r>eps do inc(i);
while stack[j].r-t>eps do dec(j);
if not(i>j) then begin tmp:=stack[i].r; stack[i].r:=stack[j].r; stack[j].r:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
function work(x:extended):extended;
begin
while x<-eps do x:=x+2*pi;
while x-2*pi>eps do x:=x-2*pi;
exit(x);
end;
function check(rnd:extended):boolean;
var i,j,k,common:longint;
    alp,bel,alp1,alp2,tmp:extended;
begin
//writeln('mid: ',rnd:0:10);
for i:=1 to n do
    begin
    top:=0;
    for j:=1 to n do
        begin
        if i=j then continue;
        tmp:=(x[i]-x[j])*(x[i]-x[j])+(y[i]-y[j])*(y[i]-y[j]);
        if (abs(tmp-4*rnd*rnd)<eps)or(4*rnd*rnd-tmp>eps) then
           begin
{           if abs(y[i]-y[j])<eps then
              writeln(x[i]:0:10,' ',x[j]:0:10);}
           alp:=arctan2(y[j]-y[i],x[j]-x[i]);
           bel:=arccos(1/2*sqrt(tmp)/rnd);
           alp1:=alp-bel;
           alp2:=alp+bel;
           alp1:=work(alp1);
           alp2:=work(alp2);
           if alp2-alp1>eps then
              begin
              inc(top);
              stack[top].l:=alp1;  stack[top].r:=alp2;
              end
           else
              begin
              inc(top);
              stack[top].l:=zero; stack[top].r:=alp2;
              inc(top);
              stack[top].l:=alp1; stack[top].r:=2*pi;
              end;
           end;
        end;
//    writeln('now i is :',i);
//    for j:=1 to top do writeln(stack[j].l:0:10,' ',stack[j].r:0:10);
    sort1(1,top);
    sort2(1,top);
    k:=1; common:=1;
    for j:=1 to top do
        begin
        inc(common);
        while (k<=top)and(stack[j].l-stack[k].r>eps) do
          begin
          dec(common); inc(k);
          end;
        if common>=num then
           begin
           ans:=rnd;
           ansx:=x[i]+rnd*cos(stack[j].l);
           ansy:=y[i]+rnd*sin(stack[j].l);
           exit(true);
           end;
        end;
    end;
exit(false);
end;
begin
assign(input,'cake.in');
reset(input);
assign(output,'cake.out');
rewrite(output);
readln(n,num);
for i:=1 to n do readln(x[i],y[i]);
zero:=0;
if num=1 then
   begin
   writeln(0);
   writeln(x[n],' ',y[n]);
   end
else
   begin
   le:=0; ri:=100000;
   while ri-le>eps do
     begin
     mid:=(le+ri)/2;
     if check(mid) then ri:=mid
        else le:=mid+eps;
     end;
   writeln(ans:0:10);
   writeln(ansx:0:10,' ',ansy:0:10);
   end;
close(input);
close(output);
end.
