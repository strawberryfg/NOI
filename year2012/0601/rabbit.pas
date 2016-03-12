const base=100000;
type arr=array[-1..400]of longint;
var n,k,p,i,ans:longint;
    lasta,lastb,now:int64;
    one,tmp,la,lb,res,c,stdk,stdp:arr;
function add(x,y:arr):arr;
var i,max:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]+y[i];
    c[i+1]:=c[i+1]+c[i] div base;
    c[i]:=c[i] mod base;
    end;
if c[max+1]<>0 then inc(max);
c[-1]:=max;
add:=c;
end;
function decline(x,y:arr):arr;
var i,max,k:longint;
begin
fillchar(c,sizeof(c),0);
if x[-1]>y[-1] then max:=x[-1] else max:=y[-1];
for i:=0 to max do
    begin
    c[i]:=c[i]+x[i]-y[i];
    if c[i]<0 then begin c[i+1]:=c[i+1]-1; c[i]:=c[i]+base; end;
    end;
k:=max; while c[k]=0 do dec(k); max:=k;
c[-1]:=max;
decline:=c;
end;
function module(x,y:arr;opt:longint):boolean;
var flag,i:longint; remain:int64;
begin
fillchar(c,sizeof(c),0);
remain:=0; flag:=0;
for i:=x[-1] downto 0 do
    begin
    remain:=int64(remain)*int64(base)+int64(x[i]);
    if remain>=y[0] then
       begin
       if flag=0 then begin flag:=1; c[-1]:=i; end;
       c[i]:=remain div y[0];
       remain:=(remain mod y[0]+y[0]) mod y[0];
       end;
    end;
if opt=1 then ans:=remain;
if remain=0 then exit(true) else exit(false);
end;
procedure work;
var i:longint; pd:boolean;
begin
la[-1]:=0; la[0]:=1; lb[-1]:=0; lb[0]:=1; one[-1]:=0; one[0]:=1;
stdk[-1]:=0; stdk[0]:=k;
for i:=3 to n do
    begin
    tmp:=add(la,lb);
    res:=decline(tmp,one);
    if module(res,stdk,0) then
       begin
       la:=lb; lb:=res;
       end
    else
       begin
       la:=lb; lb:=tmp;
       end;
    end;
stdp[-1]:=0; stdp[0]:=p;
pd:=module(lb,stdp,1);
writeln(ans);
end;
procedure work2;
var xa,xb,res,mo:int64;
    i:longint;
begin
xa:=1; xb:=1; mo:=int64(k)*int64(p);
for i:=3 to n do
    begin
    if (xa+xb) mod k=1 then res:=((xa+xb-1) mod mo+mo) mod mo
       else res:=((xa+xb) mod mo+mo) mod mo;
    xa:=xb; xb:=res;
    end;
writeln(xb mod p);
end;
begin
assign(input,'rabbit.in');
reset(input);
assign(output,'rabbit.out');
rewrite(output);
readln(n,k,p);
if n=1 then writeln(1)
   else if n=2 then writeln(1)
           else begin
                if n<=80 then
                   begin
                   lasta:=1; lastb:=1;
                   for i:=3 to n do
                       begin
                       if (lasta+lastb) mod k=1 then now:=((lasta+lastb-1))
                          else now:=((lasta+lastb));
                       lasta:=lastb; lastb:=now;
                       end;
                   writeln(now mod p);
                   end
                else if n<=1000 then
                        work
                     else
                        work2;
                end;
close(input);
close(output);
end.
