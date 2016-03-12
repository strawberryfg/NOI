const maxn=1111111;
type rec=record ll,rr:longint; end;
     qtype=record ll,rr,id:longint; end;
var n,i,j,top:longint;
    stack,from:array[0..maxn]of longint;
    a,savea:array[0..maxn]of rec;
    f:array[0..maxn]of int64;
    q:array[0..maxn]of qtype;
    ans:int64;
function cmax(x,y:int64):int64;
begin
if x>y then exit(x) else exit(y);
end;
procedure sort(l,r:longint);
var i,j,cmpl,cmpr:longint; swap:rec;
begin
i:=l; j:=r; cmpl:=a[(l+r) div 2].ll; cmpr:=a[(l+r) div 2].rr;
repeat
while (a[i].ll<cmpl)or((a[i].ll=cmpl)and(a[i].rr>cmpr)) do inc(i);
while (cmpl<a[j].ll)or((cmpl=a[j].ll)and(cmpr>a[j].rr)) do dec(j);
if not(i>j) then begin swap:=a[i]; a[i]:=a[j]; a[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function work(x,y:longint):int64;
begin
work:=(int64(a[x].rr)-int64(a[y].ll))*(int64(a[y].rr)-int64(a[x].ll));
end;
procedure solve;
var i,head,tail,le,ri,l,mid:longint;
begin
for i:=1 to n do begin from[i]:=0; f[i]:=0; end;
f[0]:=0;
head:=1; tail:=1; q[1].id:=0; q[1].ll:=1; q[1].rr:=n;
for i:=1 to n do
    begin
    while (head<=tail)and(q[head].rr<i) do inc(head);
    f[i]:=work(i,q[head].id);
    from[i]:=q[head].id;
    q[head].ll:=i+1;
    if q[head].ll>q[head].rr then inc(head);
    l:=-1;
    while (head<=tail)and(work(q[tail].ll,q[tail].id)-work(q[tail].ll,i)<0) do
       begin
       l:=q[tail].ll;
       dec(tail);
       end;
    inc(tail); q[tail].id:=i;
    if head=tail then begin q[tail].ll:=i+1; q[tail].rr:=n; end
       else begin
            le:=q[tail-1].ll+1; ri:=q[tail-1].rr;
            while le<=ri do
              begin
              mid:=(le+ri) div 2;
              if work(mid,i)-work(mid,q[tail-1].id)<0 then le:=mid+1
                 else begin l:=mid; ri:=mid-1; end;
              end;
            if l=-1 then dec(tail)
               else begin
                    q[tail].ll:=l; q[tail].rr:=n;
                    q[tail-1].rr:=l-1;
                    end;
            end;
    end;
end;
begin
assign(input,'tttriplekill.in');
reset(input);
assign(output,'tttriplekill.out');
rewrite(output);
read(n);
for i:=1 to n do read(a[i].ll,a[i].rr);
sort(1,n);
i:=1; ans:=0;
while i<=n do
  begin
  j:=i;
  while (j+1<=n)and(a[j+1].ll=a[i].ll) do inc(j);
  if j>i then ans:=cmax(ans,(int64(a[i].rr)-int64(a[i].ll))*(int64(a[i+1].rr)-int64(a[i+1].ll)));
  i:=j+1;
  end;
top:=0; stack[0]:=0;
for i:=1 to n do
    begin
    if (top>0)and(a[i].rr<=a[stack[top]].rr) then continue;
    inc(top); stack[top]:=i;
    end;
savea:=a;
for i:=1 to top do a[i]:=savea[stack[i]];
n:=top; f[0]:=0;
if n<=10000 then
   begin
   for i:=1 to n do
       begin
       f[i]:=0;
       for j:=i-2 downto 0 do
           begin
           if a[j+1].rr<a[i].ll then break;
           if (int64(a[i].rr)-int64(a[j+1].ll))*(int64(a[j+1].rr)-int64(a[i].ll))>f[i] then
              begin
              f[i]:=(int64(a[i].rr)-int64(a[j+1].ll))*(int64(a[j+1].rr)-int64(a[i].ll));
              from[i]:=j;
              end;
           end;
       end;
   end
else
   solve;
for i:=1 to n do ans:=cmax(ans,f[i]);
writeln(ans);
close(input);
close(output);
end.