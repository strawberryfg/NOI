const maxn=511111; eps=1e-16;
type qtype=record ll,rr,id:longint; end;
var n,i,head,tail,l,le,ri,mid,p:longint;
    h:array[0..maxn]of longint;
    ans:array[1..2,0..maxn]of extended;
    res:extended;
    q:array[0..maxn]of qtype;
    ret:boolean;
function sgn(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
procedure cmax(var x:extended; y:extended);
begin
if sgn(y-x)>0 then x:=y;
end;
function calc(opt,now:longint):extended;
begin
exit(h[opt]+sqrt(abs(opt-now))-h[now]);
end;
function cmp(opt1,opt2,x:longint):boolean;
var t:longint;
begin
t:=sgn(calc(opt1,x)-calc(opt2,x));
if t>0 then exit(true) else exit(false);
end;
begin
assign(input,'energy.in');
reset(input);
assign(output,'energy.out');
rewrite(output);
read(n);
for i:=1 to n do read(h[i]);
head:=1; tail:=1;
q[1].id:=1; q[1].ll:=1; q[1].rr:=n;
for i:=1 to n do
    begin
    while (head<=tail)and(q[head].rr<i) do inc(head);
    ans[1][i]:=calc(q[head].id,i);
    q[head].ll:=i+1;
    if q[head].ll>q[head].rr then inc(head);
    l:=-1;
    while (head<=tail)and(cmp(i,q[tail].id,q[tail].ll)) do
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
              ret:=cmp(i,q[tail-1].id,mid);
              if ret then begin l:=mid; ri:=mid-1; end
                 else le:=mid+1;
              end;
            if l=-1 then dec(tail)
               else begin
                    q[tail].ll:=l; q[tail].rr:=n;
                    q[tail-1].rr:=l-1;
                    end;
            end;
    end;
for i:=1 to n div 2 do begin h[i]:=h[i]+h[n+1-i]; h[n+1-i]:=h[i]-h[n+1-i]; h[i]:=h[i]-h[n+1-i]; end;
head:=1; tail:=1;
q[1].id:=1; q[1].ll:=1; q[1].rr:=n;
for i:=1 to n do
    begin
    while (head<=tail)and(q[head].rr<i) do inc(head);
    ans[2][n+1-i]:=calc(q[head].id,i);
    q[head].ll:=i+1;
    if q[head].ll>q[head].rr then inc(head);
    l:=-1;
    while (head<=tail)and(cmp(i,q[tail].id,q[tail].ll)) do
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
              ret:=cmp(i,q[tail-1].id,mid);
              if ret then begin l:=mid; ri:=mid-1; end
                 else le:=mid+1;
              end;
            if l=-1 then dec(tail)
               else begin
                    q[tail].ll:=l; q[tail].rr:=n;
                    q[tail-1].rr:=l-1;
                    end;
            end;
    end;
for i:=1 to n do
    begin
    res:=ans[1][i]; cmax(res,ans[2][i]); cmax(res,0);
    p:=trunc(res); if res-p>eps then inc(p);
    writeln(p);
    end;
close(input);
close(output);
end.