const maxn=300000; inf=5555555555555555555; eps=1e-16;
type rec=record id:longint; x,y:int64; end;
var now,test,n,len,p,i,head,tail:longint;
    s:array[0..maxn]of string[55];
    sum,from,ans:array[0..maxn]of longint;
    f:array[0..maxn]of int64;
    stack:array[0..maxn*2]of rec;
    xxj,xk,xl,yyj,yk,yl:extended;
    xj,yj:int64;
    maxx:int64;
procedure print;
var i,j,x:longint;
begin
if f[n]<=maxx then
   begin
   writeln(f[n]);
   ans[0]:=0;
   x:=n;
   while x>0 do
     begin
     inc(ans[0]); ans[ans[0]]:=x;
     x:=from[x];
     end;
   ans[ans[0]+1]:=0;
   for i:=ans[0] downto 1 do
       begin
       for j:=ans[i+1]+1 to ans[i] do
           begin
           if j<>ans[i+1]+1 then write(' ');
           write(s[j]);
           end;
       writeln;
       end;
   end
else
   writeln('Too hard to arrange');
for i:=1 to 20 do write(char(45));
writeln;
end;
function pow(x:int64; y:longint):int64;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x;
  y:=y div 2;
  if y=0 then break;
  x:=x*x;
  end;
end;
procedure bruteforce;
var i,j,tmp,res:longint; ret:int64;
begin
for i:=1 to n do begin f[i]:=inf; from[i]:=0; end;
f[0]:=0; from[0]:=0;
for i:=1 to n do
    for j:=0 to i-1 do
        begin
        if (f[j]=inf)or(f[j]>maxx) then continue;
        tmp:=abs(i-j-1+sum[i]-sum[j]-len);
        if (f[j]=maxx)and(tmp<>0) then continue;
        if (tmp<>1)and(tmp<>0) then
           begin
           res:=trunc(ln(maxx-f[j])/ln(tmp));
           if p>res then continue;
           end;
        ret:=f[j]+pow(int64(tmp),p);
        if ret<f[i] then begin f[i]:=ret; from[i]:=j; end;
        end;
print;
end;
function calc(j:longint):int64;
var s:int64;
begin
s:=int64(sum[j]);
calc:=pow(int64(j),2)+2*int64(j)+2*int64(j)*int64(len)+2*int64(j)*s+2*s+s*s+2*s*int64(len)+f[j];
end;
function check(u,v,i:longint):boolean;
var ret:int64;
begin
ret:=2*(int64(i)+int64(sum[i]))*(stack[v].x-stack[u].x);
ret:=ret-(stack[v].y-stack[u].y);
if ret<=0 then exit(true) else exit(false);
end;
function pop(l,k,j:longint):boolean;
var ll,rr:extended;
begin
yl:=stack[l].y; yk:=stack[k].y; xl:=stack[l].x; xk:=stack[k].x; xxj:=xj; yyj:=yj;
ll:=(yk-yj)/(xk-xj); rr:=(yl-yk)/(xl-xk);
if (rr-ll>eps)or(abs(rr-ll)<eps) then exit(true) else exit(false);
end;
procedure workone;
var i,j,tmp,res:longint;
begin
for i:=1 to n do begin f[i]:=inf; from[i]:=0; end;
f[0]:=0; from[0]:=0;
head:=1; tail:=1;
stack[1].id:=0; stack[1].x:=sum[0]+0; stack[1].y:=calc(0);
for i:=1 to n do
    begin
    while (head<tail)and(check(head+1,head,i)) do inc(head);
    j:=stack[head].id;
    from[i]:=j;
    if (f[j]=inf)or(f[j]>maxx) then continue;
    tmp:=abs(i-j-1+sum[i]-sum[j]-len);
    if (f[j]=maxx)and(tmp<>0) then continue;
    if (tmp<>1)and(tmp<>0) then
       begin
       if (maxx=f[j])and(tmp<>0) then continue;
       res:=trunc(ln(maxx-f[j])/ln(tmp));
       if p>res then continue;
       end;
    f[i]:=f[j]+pow(int64(tmp),p);
    xj:=int64(sum[i])+int64(i); yj:=calc(i);
    while (head<tail)and(pop(tail-1,tail,i)) do dec(tail);
    inc(tail); stack[tail].id:=i; stack[tail].x:=xj; stack[tail].y:=yj;
    end;
for i:=1 to n do writeln(from[i]);
print;
end;
function pow2(x:extended; y:longint):extended;
begin
pow2:=1;
while y>0 do
  begin
  if y mod 2=1 then pow2:=pow2*extended(x);
  y:=y div 2;
  if y=0 then break;
  x:=x*x;
  end;
end;
function work(i,j:longint):extended;
begin
work:=g[j]+pow2(extended(i-j-1+sum[i]-sum[j]-len),p);
end;
procedure workbinary;
begin
for i:=1 to n do from[i]:=0;
g[0]:=0.0; from[0]:=0;
top:=1; q[1].ll:=1; q[1].rr:=n; q[1].id:=0;
for i:=1 to n do
    begin
    le:=1; ri:=top;
    while le<=ri do
      begin
      mid:=(le+ri) div 2;
      if q[mid].rr<i then le:=mid+1
         else if q[mid].ll>i then ri:=mid-1
                 else begin num:=q[mid].id; break; end;
      end;
    g[i]:=work(i,num);
    while (top>0) do
      begin
      cmp1:=work(q[top].ll,q[top].id);
      cmp2:=work(q[top].ll,i);  //cmp2<cmp1
      if cmp1-cmp2>eps then
         begin
         l:=q[top].ll;
         dec(top);
         end;
      end;
    end;
end;
begin
assign(input,'poet.in');
reset(input);
assign(output,'poet.out');
rewrite(output);
readln(test);
maxx:=1000000000000000000;
for now:=1 to test do
    begin
    readln(n,len,p);
    sum[0]:=0;
    for i:=1 to n do
        begin
        readln(s[i]);
        sum[i]:=sum[i-1]+length(s[i]);
        end;
    if (n<=2000)and(len<=60000)and(p<=10) then bruteforce
       else begin
            if p=2 then
               workone
            else
               workbinary;
            end;
    end;
close(input);
close(output);
end.
