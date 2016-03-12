const maxn=100000000000;
type tlist=array[0..1000001]of extended;
var n,i,tot,t,en:longint;
    tx,len,tmp,xiao1,xiao2,da:extended;
    x,y:tlist;
    suc,pre:array[0..1000001]of longint;
    a:array[0..1000001]of extended;
    p:boolean;
    
procedure qsort(var a,b : tlist);

    procedure sort(l,r: longint);
      var
         i,j: longint;
         x,y,xx:extended;
      begin
         i:=l;
         j:=r;
         x:=a[(l+r) div 2];xx:=b[(l+r) div 2];
         repeat
           while (a[i]<x)or((a[i]=x)and(b[i]<xx)) do
            inc(i);
           while (x<a[j])or((a[j]=x)and(b[j]>xx)) do
            dec(j);
           if not(i>j) then
             begin
                y:=a[i];a[i]:=a[j];a[j]:=y;
                y:=b[i];b[i]:=b[j];b[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;

    begin
       sort(1,n);
    end;

function calc(x1,y1,x2,y2:extended):extended;
  begin
  calc:=(x1+x2)/2+(y1*y1-y2*y2)/(2*(x1-x2));
  end;
  
function ju(i:longint;tx:extended):extended;
  begin
  ju:=sqrt(sqr(x[i]-tx)+sqr(y[i]));
  end;

begin
assign(input,'mobile.in');reset(input);
assign(output,'mobile.out');rewrite(output);
readln(n,len);
for i:=1 to n do
    begin
    readln(x[i],y[i]);
    y[i]:=abs(y[i]);
    end;
qsort(x,y);
tot:=1;
en:=2;while x[en]=x[1] do inc(en);
tx:=calc(x[1],y[1],x[en],y[en]);
a[tot]:=tx;pre[tot]:=1;suc[tot]:=en;
for i:=en+1 to n do
    begin
    p:=true;
    while (tot>0) do
          begin
          t:=suc[tot];if x[i]=x[t] then begin p:=false;break; end;
          tx:=calc(x[t],y[t],x[i],y[i]);
          if tx<=a[tot] then
             begin
             if tot=1 then
                begin
                tx:=calc(x[pre[tot]],y[pre[tot]],x[i],y[i]);
                end;
             dec(tot);
             end
             else break;
          end;
    if not p then continue;
    inc(tot);a[tot]:=tx;
    suc[tot]:=i;
    if tot>1 then pre[tot]:=suc[tot-1]
       else pre[tot]:=pre[tot];
    end;
da:=0;
for i:=1 to tot do
if (a[i]>=0)and(a[i]<=len) then
    begin
    tmp:=ju(suc[i],a[i]);
    if tmp>da then da:=tmp;
    tmp:=ju(pre[i],a[i]);
    if tmp>da then da:=tmp;
    end;
xiao1:=maxn;xiao2:=maxn;
for i:=1 to n do
    begin
    tmp:=sqrt(sqr(x[i])+sqr(y[i]));
    if tmp<xiao1 then xiao1:=tmp;
    tmp:=sqrt(sqr(x[i]-len)+sqr(y[i]));
    if tmp<xiao2 then xiao2:=tmp;
    end;
if xiao1<>maxn then if xiao1>da then da:=xiao1;
if xiao2<>maxn then if xiao2>da then da:=xiao2;
writeln(da:0:4);
//while true do i:=i;
close(input);close(output);
end.
