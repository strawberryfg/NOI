const f:array[1..9,1..9]of int64=
((0,0,0,0,1,0,0,0,1),
 (0,0,0,0,0,1,0,1,1),
 (0,0,0,0,0,0,1,0,1),
 (0,0,0,0,0,1,0,1,1),
 (1,1,0,0,0,0,0,0,1),
 (1,1,0,0,0,0,0,0,1),
 (0,0,1,1,0,0,0,0,1),
 (0,0,1,1,0,0,0,0,1),
 (0,0,0,0,0,0,0,0,1));
mo=2000000014;
md=1000000007;
type rec=array[1..9,1..9]of int64;
var g,spe:rec;
    l,r,i,j:longint;
    ans:int64;
    tt:rec;
function mul(a,b:rec):rec;
var c:rec;
    i,j,k:longint;
begin
c:=spe;
for i:=1 to 9 do
    for j:=1 to 9 do
        begin
        for k:=1 to 9 do
            begin
            c[i][j]:=(c[i][j]+a[i][k]*b[k][j])mod mo;
            end;
        end;
exit(c);
end;
function calc(x:longint):rec;
var tmp:rec;
begin
if x=1 then exit(f)
   else begin
        tmp:=spe;
        tmp:=calc(x div 2);
        tmp:=mul(tmp,tmp);
        if x mod 2=1 then tmp:=mul(tmp,f);
        exit(tmp);
        end;
end;
function doit(x:longint):int64;
var ass:rec;
    i:longint;
    res:int64;
begin
if x=1 then exit(4)
   else if x=2 then exit(12);
ass:=calc(x-2);
ass:=mul(g,ass);
res:=0;
for i:=1 to 9 do
    res:=(res+ass[1][i])mod mo;
exit(res);
end;
function work(x:longint):int64;
var res:longint;
begin
if x=0 then exit(0);
if x=1 then exit(4)
   else if x=2 then exit(8)
           else if x=3 then exit(19)
                   else begin
                        res:=(doit(x)+doit((x+1)div 2)) mod mo;
                        res:=res div 2;
                        exit(res);
                        end;
end;
begin
assign(input,'color.in');
reset(input);
assign(output,'color.out');
rewrite(output);
readln(l,r);
for i:=1 to 8 do g[1][i]:=1;
g[1][9]:=4;
ans:=work(r)-work(l-1);
if ans<0 then ans:=ans+md;
writeln(ans);
tt:=mul(g,f);
close(input);
close(output);
end.
