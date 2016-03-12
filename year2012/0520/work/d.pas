const maxn=220;
type rec=record ll,rr:longint; end;
var n,i,j,k,flag,le,ri,mid,ans:longint;
    a:array[0..maxn]of rec;
    f,cnt:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,cmpll,cmprr:longint; swap:rec;
begin
i:=l; j:=r; cmpll:=a[(l+r) div 2].ll; cmprr:=a[(l+r)div 2].rr;
repeat
while (a[i].ll<cmpll)or((a[i].ll=cmpll)and(a[i].rr<cmprr)) do inc(i);
while (cmpll<a[j].ll)or((cmpll=a[j].ll)and(cmprr<a[j].rr)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
begin
{assign(input,'d.in');
reset(input);
assign(output,'d.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    read(a[i].ll,a[i].rr);
    inc(a[i].ll);
    inc(a[i].rr);
    end;
sort(1,n);
f[1]:=1; f[0]:=1;
for i:=2 to n do
    begin
    for j:=i-1 downto 0 do
        begin
        if a[j].rr<a[i].ll then
           begin
           flag:=0;
           for k:=j+1 to i-1 do
               if (a[k].ll>a[j].rr)and(a[k].rr<a[i].ll) then
                  begin
                  flag:=1;
                  break;
                  end;
           if flag=0 then f[i]:=f[i]+f[j];
           end;
        end;
    end;
ans:=0;
for i:=1 to n do
    begin
    flag:=0;
    for j:=i+1 to n do
        if a[j].ll>a[i].rr then begin flag:=1; break; end;
    if flag=0 then ans:=ans+f[i];
    end;
writeln(ans);
{close(input);
close(output);}
end.