//14:57;
const maxdivisor=200200;
var n,m,cnt,i,j,x,p,l:longint;
    a,f,tf,num,bel:array[0..maxdivisor]of qword;
    k,base,t:qword;
function gcd(x,y:qword):qword;
begin
if y=0 then exit(x) else exit(gcd(y,x mod y));
end;
procedure pre;
var i:longint;
begin
for i:=1 to k div 2 do
    begin
    if k mod i=0 then
       begin
       inc(cnt);
       num[cnt]:=i;
       bel[i]:=cnt;     //num[bel[i]]=i;
       end;
    end;
inc(cnt); num[cnt]:=k; bel[k]:=cnt;
end;
begin
assign(input,'dream.in');
reset(input);
assign(output,'dream.out');
rewrite(output);
readln(n,m);
readln(k,base);
pre;
f[bel[1]]:=1;           //f[bel[1]]:=1;
for i:=1 to n do
    begin
    tf:=f;
    fillchar(f,sizeof(f),0);
    fillchar(a,sizeof(a),0);
    for j:=1 to m do
        begin
        read(x);
        x:=x mod k;
        t:=gcd(k,x);
        a[bel[t]]:=(a[bel[t]]+1)mod base;
        end;
    for j:=1 to cnt do
        begin
        if tf[j]=0 then continue;
        for l:=1 to cnt do
            begin
            if a[l]=0 then continue;
            t:=gcd(k,num[j]*num[l] mod k);    // up: j; down: l;
            f[bel[t]]:=(f[bel[t]]+tf[j]*a[l] mod base)mod base;
            if (i>1)and(i<n) then
               begin
               t:=gcd(k,num[j]*num[l] mod k*num[l] mod k);
               f[bel[t]]:=(f[bel[t]]+tf[j]mod base*(a[l]-1)mod base*a[l] mod base)mod base;
               for p:=l+1 to cnt do
                   begin
                   if a[p]=0 then continue;
                   t:=gcd(k,num[j]*num[l] mod k*num[p] mod k);
                   f[bel[t]]:=(f[bel[t]]+tf[j]mod base*a[l]mod base*a[p]*2 mod base)mod base;
                   end;
               end;
            end;
        end;
    end;
writeln(f[cnt]);
close(input);
close(output);
end.