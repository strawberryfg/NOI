const inf=100000000;
      maxs=600;
      maxn=1020;
var test,u,i,n,l,j,k,ans,p,max:longint;
    f:array[0..maxn,0..maxs,-8..7]of longint;
    a,b:array[-1..maxn]of longint;
function calc(x,y:longint):longint;
begin
exit((x or y)-(x and y));
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'dining.in');
reset(input);
assign(output,'dining.out');
rewrite(output);
readln(test);
for u:=1 to test do
    begin
    readln(n);
    for i:=1 to n do
        begin
        readln(a[i],b[i]);
        end;
    l:=8;
    for i:=1 to n+1 do
        for j:=0 to 1 shl l-1 do
            for k:=-8 to l-1 do
                f[i][j][k]:=inf;
    f[1][0][-1]:=0;
    for i:=1 to n do
        begin
        for j:=0 to 1 shl l-1 do
            begin
            for k:=-8 to 7 do
                begin
                if i+k>n then continue;
                if f[i][j][k]=inf then continue;
                if i+k<-1 then continue;
                if j and 1<>0 then  f[i+1][j div 2][k-1]:=min(f[i+1][j div 2][k-1],f[i][j][k])
                   else begin
                        max:=inf;
                        for p:=0 to b[i] do
                            begin
                            if j and (1 shl p)=0 then
                               begin
                               if i+p>max then
                                  continue;
                               if i+p+b[i+p]<max then
                                  max:=i+p+b[i+p];
                               if j and (1 shl p)=0 then
                                  begin
                                  if f[i][j][k]<>inf then
                                     begin
                                     if (i=1)and(j=0)and(k=-1) then
                                        f[i][j+(1 shl p)][p]:=0
                                     else
                                        f[i][j+(1 shl p)][p]:=min(f[i][j+(1 shl p)][p],f[i][j][k]+calc(a[i+k],a[i+p]));
                                     end;
                                  end;
                               end;
                            end;
                        end;
                end;
            end;
        end;
    ans:=inf;
    for i:=-8 to -1 do
        begin
        if f[n+1][0][i]<ans then
           ans:=f[n+1][0][i];
        end;
    writeln(ans);
    end;
close(input);
close(output);
end.