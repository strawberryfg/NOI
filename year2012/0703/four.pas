const four:array[1..9]of qword=(44,444,4444,44444,444444,4444444,44444444,444444444,4444444444);
      mat1:array[0..4,0..4]of qword=((9,1,0,0,1),
                                     (9,0,1,0,1),
                                     (9,0,0,1,1),
                                     (9,0,0,0,1),
                                     (0,0,0,0,1));
      mat2:array[0..4,0..4]of qword=((9,1,0,0,0),
                                     (9,0,1,0,0),
                                     (9,0,0,1,0),
                                     (9,0,0,0,0),
                                     (0,0,0,0,1));
      eps=1e-16; base=1000000007;
type mattype=array[0..4,0..4]of qword;
var test,now,cnt,i:longint;
    ori,b,c,d,pow,ans:mattype;
    fans,n:qword;
    sta:array[0..66]of longint;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
function gcd(x,y:extended):extended;
var ret:extended;
begin
if cmp(y)=0 then exit(x)
   else begin
        ret:=trunc(x/y); ret:=x-ret*y;
        exit(gcd(y,ret));
        end;
end;
function matrix(x,y:mattype):mattype;
var i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for k:=0 to 4 do
    for i:=0 to 4 do
        begin
        if x[i][k]<>0 then
           for j:=0 to 4 do
               c[i][j]:=(c[i][j]+x[i][k]*y[k][j] mod base) mod base;
        end;
exit(c);
end;
function mul(std:mattype;step:qword):mattype;
begin
pow:=std; mul:=std; dec(step);
while step>0 do
  begin
  if step mod 2=1 then mul:=matrix(mul,pow);
  step:=step div 2;
  if step=0 then break;
  pow:=matrix(pow,pow);
  end;
end;
procedure calcall;
var i:longint;
begin
ori[0][0]:=8; ori[0][1]:=1; ori[0][2]:=0; ori[0][3]:=0; ori[0][4]:=0; //sum[0]:=0;
b:=mul(mat1,n-1);
ans:=matrix(ori,b);
fans:=0;
for i:=0 to 4 do fans:=(fans+ans[0][i]) mod base;
end;
procedure calcpartial(lcm:qword; opt:longint);
var i:longint; tmp:qword;
begin
if n=lcm then d:=ori
   else begin
        d:=mul(mat2,lcm-1);
        d:=matrix(d,mat1);
        if (n-1) div lcm<>0 then d:=mul(d,(n-1) div lcm);
        d:=matrix(ori,d);
        end;
if n mod lcm=0 then d:=matrix(d,mul(mat2,lcm-1));
tmp:=d[0][4];
if n mod lcm=0 then for i:=0 to 3 do tmp:=(tmp+d[0][i]) mod base;
if opt=0 then fans:=(fans+tmp) mod base
   else fans:=(fans+qword(base)+qword(base)-tmp) mod base;
end;
procedure work(opt:longint);
var i:longint; com:extended;
begin
com:=-1;
for i:=1 to cnt do
    begin
    if sta[i]=0 then continue;
    if cmp(com-(-1))=0 then com:=extended(four[i])
       else com:=extended(four[i])*com/gcd(extended(four[i]),com);
    if cmp(com-n)>0 then exit;
    end;
if cmp(com-(-1))=0 then exit;
calcpartial(qword(trunc(com)),opt);
end;
procedure dfs(x,opt:longint);
begin
if x>cnt then begin work(opt); exit; end;
sta[x]:=1;
dfs(x+1,(opt+1) mod 2);
sta[x]:=0;
dfs(x+1,opt);
end;
begin
assign(input,'four.in');
reset(input);
assign(output,'four.out');
rewrite(output);
read(test);
for now:=1 to test do
    begin
    read(n);
    if n=1 then begin writeln(9); continue; end;
    cnt:=0;
    for i:=1 to 9 do if n>=four[i] then inc(cnt);
    calcall;
    dfs(1,0);
    writeln(fans);
    end;
close(input);
close(output);
end.