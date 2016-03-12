const max=100000; maxm=10; base=9973;
type arr=array[0..maxm,0..maxm]of longint;
var test,now,i,j,cnt,n,m,kind,x,y:longint;
    check:array[0..max]of boolean;
    prime:array[0..max]of longint;
    phi:array[0..max]of longint;
    ans:longint;
    c,mat,g,std:arr;
function pow2(x:longint; y:longint):longint;
begin
pow2:=1;
while y>0 do
  begin
  if y and 1=1 then pow2:=pow2*x mod base;
  x:=x*x mod base;
  y:=y shr 1;
  end;
end;
function calc(x:longint):longint;
var i,j,k:longint;
begin
g:=mat; dec(x); std:=mat;
while x>0 do
  begin
  if x and 1=1 then
     begin
     fillchar(c,sizeof(c),0);
     for k:=1 to m do
         for i:=1 to m do
             begin
             if g[i][k]=0 then continue;
             for j:=1 to m do
                 begin
                 if std[k][j]=0 then continue;
                 c[i][j]:=(c[i][j]+g[i][k]*std[k][j] mod base) mod base;
                 end;
             end;
     g:=c;
     end;
  fillchar(c,sizeof(c),0);
  for k:=1 to m do
    for i:=1 to m do
        begin
        if std[i][k]=0 then continue;
        for j:=1 to m do
            begin
            if std[k][j]=0 then continue;
            c[i][j]:=(c[i][j]+std[i][k]*std[k][j] mod base) mod base;
            end;
        end;
  std:=c;
  x:=x shr 1;
  end;
calc:=0;
for i:=1 to m do calc:=(calc+g[i][i]) mod base;
end;
function calcphi(x:longint):longint;
var i,pd:longint;
begin
if (x<=max)and(phi[x]<>0) then exit(phi[x] mod base);
calcphi:=x;
i:=1;
while x>1 do
  begin
  pd:=0;
  while x mod prime[i]=0 do begin pd:=1; x:=x div prime[i]; end;
  if pd=1 then calcphi:=calcphi*(prime[i]-1) div prime[i];
  inc(i);
  end;
if x<>1 then calcphi:=calcphi*(x-1) div longint(x);
calcphi:=calcphi mod base;
end;
begin
assign(input,'bracelet.in');
reset(input);
assign(output,'bracelet.out');
rewrite(output);
readln(test);
fillchar(check,sizeof(check),false);
cnt:=0;
phi[1]:=1;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; phi[i]:=i-1; end;
    for j:=1 to cnt do
        begin
        if qword(i)*qword(prime[j])>qword(max) then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then begin phi[i*prime[j]]:=longint(phi[i])*longint(prime[j]); break; end
           else phi[i*prime[j]]:=longint(phi[i])*longint(prime[j]-1);
        end;
    end;
for now:=1 to test do
    begin
    readln(n,m,kind);
    for i:=1 to m do for j:=1 to m do mat[i][j]:=1;
    for i:=1 to kind do begin readln(x,y); mat[x][y]:=0; mat[y][x]:=0; end;
    ans:=0;
    for i:=1 to trunc(sqrt(n)) do
        begin
        if n mod i=0 then
           begin
           ans:=(ans+calcphi(n div i)*calc(i) mod base) mod base;
           if i*i<>n then ans:=(ans+calcphi(i)*calc(n div i) mod base) mod base;
           end;
        end;
    ans:=ans*pow2(n mod base,base-2) mod base;
    writeln(ans);
    end;
close(input);
close(output);
end.