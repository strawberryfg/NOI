type tlist=array[0..200001]of longint;
var n,i,j,k:longint;
    a,b,tip,r,lx,rx,ld,rd:tlist;
    c,cc:array[0..200001]of int64;
    ans:array[0..10]of int64;
    sum,total,tsum:int64;
    num:array[0..200001]of int64;

function calc(a:int64):int64;
  begin
  calc:=int64(a)*int64(a-1) div 2;
  end;

procedure qsort(var a,b : tlist);
    procedure sort(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=a[(l+r) div 2];
         repeat
           while a[i]<x do
            inc(i);
           while x<a[j] do
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

procedure add(x,delta:longint);
  begin
  while x<=n do
        begin
        c[x]:=c[x]+delta;
        x:=x+(x and (-x));
        end;
  end;

function ques(x:longint):longint;
  var sum:longint;
  begin
  sum:=0;
  while x>0 do
        begin
        sum:=sum+c[x];
        x:=x-(x and (-x));
        end;
  exit(sum);
  end;

procedure print(a,b:int64);
  var i:longint;
  begin
  write(a div b,'.');a:=a mod b;
  for i:=1 to 20 do
      begin
      a:=a*10;
      write(a div b);a:=a mod b;
      end;
  writeln;
  end;

procedure add2(x,delta:longint);
  begin
  while x<=n do
        begin
        cc[x]:=cc[x]+delta;
        x:=x+(x and (-x));
        end;
  end;

function ques2(x:longint):longint;
  var sum:longint;
  begin
  sum:=0;
  while x>0 do
        begin
        sum:=sum+cc[x];
        x:=x-(x and (-x));
        end;
  exit(sum);
  end;

begin
assign(input,'shape.in');reset(input);
assign(output,'shape.out');rewrite(output);
readln(n);
for i:=1 to n do
    begin
    read(a[i]);tip[i]:=i;
    end;
b:=a;
qsort(b,tip);
k:=0;
for i:=1 to n do
    begin
    if b[i]<>b[i-1] then inc(k);
    r[tip[i]]:=k;
    end;
fillchar(c,sizeof(c),0);
for i:=1 to n do
    begin
    lx[i]:=ques(r[i]-1);
    ld[i]:=i-1-ques(r[i]);
    add(r[i],1);
    end;
fillchar(c,sizeof(c),0);
for i:=n downto 1 do
    begin
    rx[i]:=ques(r[i]-1);
    rd[i]:=n-i-ques(r[i]);
    add(r[i],1);
    end;
//for i:=1 to n do writeln(lx[i],' ',ld[i],' ',rx[i],' ',rd[i]);
for i:=1 to n do
    begin
    ans[1]:=ans[1]+int64(lx[i])*rd[i];ans[6]:=ans[6]+int64(ld[i])*rx[i];
    end;
fillchar(c,sizeof(c),0);
fillchar(cc,sizeof(cc),0);
fillchar(num,sizeof(num),0);
sum:=0;tsum:=0;
for i:=n downto 1 do
    begin
    sum:=sum+calc(n-i-ques(r[i]))-(tsum-ques2(r[i]));
    add(r[i],1);
    inc(num[r[i]]);tsum:=tsum+num[r[i]]-1;add2(r[i],num[r[i]]-1);
    end;
ans[2]:=sum-ans[1];
sum:=0;
fillchar(c,sizeof(c),0);
fillchar(cc,sizeof(cc),0);
fillchar(num,sizeof(num),0);
tsum:=0;
for i:=1 to n do
    begin
    sum:=sum+calc(ques(r[i]-1))-ques2(r[i]-1);
    //if num[r[i]] then begin add(r[i],1);num[r[i]]:=false; end;
    add(r[i],1);
    inc(num[r[i]]);tsum:=tsum+num[r[i]]-1;add2(r[i],num[r[i]]-1)
    end;
ans[3]:=sum-ans[1];

sum:=0;
fillchar(c,sizeof(c),0);
fillchar(cc,sizeof(cc),0);
fillchar(num,sizeof(num),0);
tsum:=0;
for i:=1 to n do
    begin
    sum:=sum+calc(i-1-ques(r[i]))-(tsum-ques2(r[i]));
    //if num[r[i]] then begin add(r[i],1);num[r[i]]:=false; end;
    add(r[i],1);
    inc(num[r[i]]);tsum:=tsum+num[r[i]]-1;add2(r[i],num[r[i]]-1);
    end;
ans[4]:=sum-ans[6];
sum:=0;
fillchar(c,sizeof(c),0);
fillchar(cc,sizeof(cc),0);
fillchar(num,sizeof(num),0);
tsum:=0;
for i:=n downto 1 do
    begin
    sum:=sum+calc(ques(r[i]-1))-ques2(r[i]-1);
    //if num[r[i]] then begin add(r[i],1);num[r[i]]:=false; end;
    add(r[i],1);
    inc(num[r[i]]);tsum:=tsum+num[r[i]]-1;add2(r[i],num[r[i]]-1);
    end;
ans[5]:=sum-ans[6];
//for i:=1 to 6 do writeln(ans[i]);
total:=0;
for i:=1 to 6 do total:=total+ans[i];
for i:=1 to 6 do
    print(ans[i],total);
close(input);close(output);
end.
