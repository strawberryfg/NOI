const max=4720; maxn=520; inf=maxlongint;
type rec=record st,en,v:longint; end;
var n,m,i,j,k,res,num,tmp,top:longint;
    a,c,d,e:array[0..maxn,0..maxn]of longint;
    b,tb,sum,tsum:array[0..maxn]of longint;
    hash:array[-max..max]of longint;
    spe:array[0..2*max]of longint;
    stack:array[0..maxn]of rec;
function check:boolean;
var i:longint;
begin
for i:=2 to m do
    if a[1][i]-a[1][i-1]<=0 then exit(false);
exit(true);
end;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=tb[(l+r) div 2];
repeat
while tb[i]<x do inc(i);
while x<tb[j] do dec(j);
if not(i>j) then begin y:=tb[i]; tb[i]:=tb[j]; tb[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure work;
var i,j,k,le,ri,ans,cnt,mid,ans1,ans2,res1,res2,ll,rr,xmid:longint;
begin
top:=0;
d:=a;
e:=a;
for j:=2 to m do
    for i:=1 to n do
        begin
        tmp:=a[i][j]-(j-1)-a[i][1];
        if hash[tmp]=0 then
           begin
           hash[tmp]:=1;
           end;
        end;
for i:=-max to max do
    if hash[i]<>0 then
       begin
       inc(spe[0]);
       spe[spe[0]]:=i;
       end;
for j:=2 to m do
    begin
    for i:=1 to n do
        tb[i]:=a[i][j]-(j-1)-a[i][1];
    sort(1,n);
    for i:=1 to n do
        d[i][j]:=tb[i];
    inc(top);
    stack[top].st:=j; stack[top].en:=j; stack[top].v:=tb[(n+1)div 2];
    while (top>1)and(stack[top].v<stack[top-1].v) do
      begin
      dec(top);
      le:=1; ri:=spe[0];
      ans:=0;
      cnt:=(j-stack[top].st+1)*n;
      stack[top].en:=j;
      while le<=ri do
        begin
        mid:=(le+ri)div 2;
        ans1:=0; ans2:=0;
        for k:=stack[top].st to j do
            begin
            ll:=1; rr:=n;
            res1:=0; res2:=0; //res1 same
            while ll<=rr do
              begin
              xmid:=(ll+rr) div 2;
              if d[xmid][k]>=spe[mid] then begin res1:=n-xmid+1; rr:=xmid-1; end
                 else ll:=xmid+1;
              end;
            ll:=1; rr:=n;
            while ll<=rr do
              begin
              xmid:=(ll+rr)div 2;
              if d[xmid][k]>spe[mid] then begin res2:=n-xmid+1; rr:=xmid-1; end
                 else if d[xmid][k]<=spe[mid] then ll:=xmid+1
              end;
            ans1:=ans1+res1;
            ans2:=ans2+res2;
            end;
        if ans1<(cnt+1)div 2 then
           begin
           ri:=mid-1;
           end
        else begin
             if ans2>(cnt+1)div 2 then le:=mid+1
                else begin ans:=mid; ri:=mid-1; end;
             end;
        end;
      stack[top].v:=spe[ans];
      end;
    end;
for i:=1 to top do if stack[i].v<0 then stack[i].v:=0;
for i:=1 to top do
    begin
    for j:=stack[i].st to stack[i].en do
        begin
        for k:=1 to n do
            begin
            e[k][j]:=(j-1)+stack[i].v+a[k][1];
            end;
        end;
    end;
for i:=1 to n do
    begin
    for j:=1 to m-1 do write(e[i][j],' ');
    write(e[i][m]);
    writeln;
    end;
end;
begin
assign(input,'equal.in');
reset(input);
assign(output,'equal.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(a[i][j]);
        end;
    readln;
    end;
c:=a;
if not check then begin writeln(-1); writeln; end
   else begin
        for i:=2 to n do
            begin
            for j:=1 to m do
                begin
                b[j]:=a[1][j]-a[i][j];
                end;
            res:=inf; num:=-1;
            tb:=b;
            sort(1,m);
            sum[0]:=0;
            for j:=1 to m-1 do
                sum[j]:=sum[j-1]+tb[j+1]-tb[j];
            tsum:=sum;
            for j:=2 to m-1 do
                sum[j]:=sum[j-1]+sum[j];
            for j:=1 to m do
                begin
                tmp:=0;
                tmp:=sum[m-1]-sum[j-1]-(m-j)*tsum[j-1];
                if j>1 then tmp:=tmp+tsum[j-1]*(j-1)-sum[j-2];
                if tmp<res then
                   begin
                   res:=tmp;
                   num:=tb[j];
                   end;
                end;
            for j:=1 to m do
                begin
                tmp:=num;
                c[i][j]:=a[1][j]-tmp;
                end;
            end;
        for i:=1 to n do
            begin
            for j:=1 to m-1 do
                write(c[i][j],' ');
            write(c[i][m]);
            writeln;
            end;
        writeln;
        end;
work;
close(input);
close(output);
end.