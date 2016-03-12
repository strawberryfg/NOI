const maxn=300000; eps=1e-16;
type qtype=record ll,rr,id:longint; end;
var now,test,n,len,p,i,head,tail:longint;
    s:array[0..maxn]of string[55];
    sum,from,ans:array[0..maxn]of longint;
    g:array[0..maxn]of extended;
    q:array[0..maxn]of qtype;
    maxx:extended;
procedure print;
var i,j,x:longint;
begin
if not(abs(g[n]-1e22)<eps) then
   begin
   writeln(int64(trunc(g[n])));
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
function cmp(x:extended):boolean;
begin
if x>eps then exit(true);
//if abs(x)<eps then exit(true);
exit(false);
end;
function work(i,j:longint):extended;
begin
work:=g[j]+pow2(extended(abs(i-j-1+sum[i]-sum[j]-len)),p);
end;
procedure workbinary;
var i,le,ri,mid,l:longint;
begin
for i:=1 to n do begin from[i]:=0; g[i]:=1e22; end;
g[0]:=0;
head:=1; tail:=1; q[1].id:=0; q[1].ll:=1; q[1].rr:=n;
for i:=1 to n do
    begin
    while (head<=tail)and(q[head].rr<i) do inc(head);
    g[i]:=work(i,q[head].id);
    from[i]:=q[head].id;
    if g[i]-maxx>eps then g[i]:=1e22;
    q[head].ll:=i+1;
    if q[head].ll>q[head].rr then inc(head);
    l:=-1;
    while (head<=tail)and(cmp(work(q[tail].ll,q[tail].id)-work(q[tail].ll,i))) do
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
              if work(mid,i)-work(mid,q[tail-1].id)>eps then le:=mid+1
                 else begin l:=mid; ri:=mid-1; end;
              end;
            if l=-1 then dec(tail)
               else begin
                    q[tail].ll:=l; q[tail].rr:=n;
                    q[tail-1].rr:=l-1;
                    end;
            end;
    end;
print;
end;
begin
assign(input,'poet.in');
reset(input);
assign(output,'poet.out');
rewrite(output);
readln(test);
maxx:=1e18;
for now:=1 to test do
    begin
    readln(n,len,p);
    sum[0]:=0;
    for i:=1 to n do
        begin
        readln(s[i]);
        sum[i]:=sum[i-1]+length(s[i]);
        end;
    workbinary;
    end;
close(input);
close(output);
end.