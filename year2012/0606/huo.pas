const maxn=200; maxv=200; maxs=200; inf=maxlongint;
var now,n,a,b,i,j,k,p,t,tmp,ans:longint;
    f,flag:array[0..maxn,0..maxv,-1..maxs]of longint;
    h:array[0..maxn]of longint;
begin
assign(input,'huo.in');
reset(input);
{assign(output,'huo.out');
rewrite(output);}
now:=0;
while not eof do
    begin
    inc(now);
    readln(n,a,b);
    for i:=1 to n do read(h[i]);
    readln;
    flag[1][0][h[1]]:=now; f[1][0][h[1]]:=0;
    for i:=2 to n do
        begin
        for j:=0 to 52 do
            begin
            for k:=-1 to h[i-1] do
                begin
                if flag[i-1][j][k]=now then
                   begin
                   for p:=0 to 52 do
                       begin
                       if (i=n)and(p>0) then break;
                       t:=k-p*b;
                       if t<0 then t:=-1;
                       if t>=0 then continue;
                       tmp:=h[i]-a*p-b*j;
                       if tmp<0 then tmp:=-1;
                       if (flag[i][p][tmp]<>now)or(f[i-1][j][k]+p<f[i][p][tmp]) then
                          begin
                          flag[i][p][tmp]:=now;
                          f[i][p][tmp]:=f[i-1][j][k]+p;
                          end;
                       end;
                   end;
                end;
            end;
        end;
    ans:=inf;
    if (flag[n][0][-1]=now)and(f[n][0][-1]<ans) then
       ans:=f[n][0][-1];
    writeln(ans);
    end;
{close(input);
close(output);}
end.