const maxn=300020; eps=1e-12;
type rec=record x,y:extended; end;
var n,i,j,num,top:longint;
    a,stack:array[0..2*maxn]of rec;
    s:array[0..2*maxn]of extended;
    ans:extended;
function max(x,y:extended):extended;
begin
if x-y>eps then exit(x) else exit(y);
end;
function cmp(c,d:rec):boolean;
begin
if (d.x-c.x>eps)or((abs(d.x-c.x)<eps)and(d.y-c.y>eps)) then cmp:=true else cmp:=false;
end;
procedure swap(var c,d:rec);
var tmp:rec;
begin
tmp:=c; c:=d; d:=tmp;
end;
function cross(u,v,w:rec):extended;
begin
cross:=((v.x-u.x)*(w.y-u.y)-(w.x-u.x)*(v.y-u.y));
end;
function calc(c,d:rec):extended;
begin
calc:=sqrt((c.x-d.x)*(c.x-d.x)+(c.y-d.y)*(c.y-d.y));
end;
procedure hull(l,r:longint; c,d:rec);
var num,i,j,k:longint; opt:rec; ret:extended;
begin
num:=l; opt:=a[l];
for k:=l+1 to r do
    if (s[k]-s[num]>eps)or((abs(s[k]-s[num])<eps)and(cmp(opt,a[k]))) then
       begin
       num:=k;
       opt:=a[k];
       end;
i:=l-1; j:=r+1;
for k:=l to r do
    begin
    inc(i); ret:=cross(c,opt,a[k]);
    if ret>eps then begin s[i]:=ret; swap(a[i],a[k]); end else dec(i);
    end;
for k:=r downto l do
    begin
    dec(j); ret:=cross(opt,d,a[k]);
    if ret>eps then begin s[j]:=ret; swap(a[j],a[k]); end else inc(j);
    end;
if l<=i then hull(l,i,c,opt);
inc(top); stack[top]:=opt;
if j<=r then hull(j,r,opt,d);
end;
begin
assign(input,'pointpair.in');
reset(input);
assign(output,'pointpair.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i].x,a[i].y);
num:=1;
for i:=2 to n do if cmp(a[i],a[num]) then num:=i;
swap(a[1],a[num]);
stack[1]:=a[1];
top:=1;
hull(2,n,a[1],a[1]);
stack[top+1]:=stack[1];
j:=2; ans:=0.0;
for i:=1 to top do
    begin
    while cross(stack[i+1],stack[i],stack[j+1])-cross(stack[i+1],stack[i],stack[j])>eps do
      begin
      inc(j); if j>top then j:=1;
      end;
    ans:=max(ans,calc(stack[i],stack[j]));
    end;
writeln(round(ans*100)/100:0:2,' ',round(ans*100)/100:0:2);
close(input);
close(output);
end.