const maxn=111;
var n,i,pd,now,test,j:longint;
    b,m,x,y,d:int64;
    h,a:array[0..maxn]of qword;
    ans:array[0..maxn]of int64;
    res:qword;
    tb:int64;
function gcd(p,q:qword):qword;
begin
if q=0 then exit(p) else exit(gcd(q,p mod q));
end;
procedure euclid(p,q:qword);
var tmp:int64;
begin
if q=0 then begin x:=1; y:=0; d:=p; exit; end;
euclid(q,p mod q);
tmp:=x;
x:=y;
y:=((tmp-p div q*y) mod m+m) mod m;
end;
begin
assign(input,'dpeqn.in');
reset(input);
assign(output,'dpeqn.out');
rewrite(output);
read(test);
for now:=1 to test do
    begin
    read(n);
    if n=0 then break;
    for i:=1 to n do read(a[i]);
    read(b,m);
    tb:=b;
    a[0]:=m;
    pd:=1;
    h[n]:=a[n];
    for i:=n-1 downto 1 do h[i]:=gcd(h[i+1],a[i]);
    for i:=0 to n-1 do
        begin
        if b=0 then begin for j:=i to n do ans[j]:=0; x:=0; break; end;
        x:=0; y:=0; d:=0;
        euclid(h[i+1],a[i]);
        if b mod d<>0 then begin pd:=0; break; end;
        x:=x*(b div d);
        y:=y*(b div d);
        ans[i]:=(y mod m+m) mod m;
        b:=b-ans[i]*a[i];
        b:=(b mod m+m) mod m;
        end;
    ans[n]:=(x mod m+m) mod m;
    if pd=0 then writeln('NO')
       else begin
            for i:=1 to n-1 do write(ans[i],' ');
            write(ans[n]);
            res:=0;
            for i:=1 to n do
                res:=(res+ans[i]*a[i]) mod m;
            if res mod m<>tb mod m then writeln('running in line',now,' -1 ');
            writeln;
            end;
    end;
close(input);
close(output);
end.