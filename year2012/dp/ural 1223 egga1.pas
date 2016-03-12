const maxn=1020; maxm=1020; inf=maxlongint;
var n,m,t:longint;
    f:array[0..maxn,0..maxm]of longint;
procedure work;
var i,j,le,ri,mid,ans,ansl,ansr:longint;
begin
for i:=0 to m do f[1][i]:=i;
for i:=1 to n do f[i][0]:=0;
for i:=2 to n do
    begin
    for j:=1 to m do
        begin
        f[i][j]:=inf;
        le:=1; ri:=j; ansr:=0; ansl:=0; ans:=0;
        while le<=ri do
          begin
          mid:=(le+ri) div 2;
          if f[i-1][mid-1]=f[i][j-mid] then begin ans:=mid; break; end
             else if f[i-1][mid-1]<f[i][j-mid] then begin ansr:=mid; le:=mid+1 end
                     else begin ansl:=mid; ri:=mid-1; end;
          end;
        if ans<>0 then f[i][j]:=f[i-1][ans-1]+1
           else begin
                if ansr<>0 then if f[i][j-ansr]+1<f[i][j] then f[i][j]:=f[i][j-ansr]+1;
                if ansl<>0 then if f[i-1][ansl-1]+1<f[i][j] then f[i][j]:=f[i-1][ansl-1]+1;
                end;
        end;
    end;
writeln(f[n][m]);
end;
begin
{assign(input,'egga1.in');
reset(input);
assign(output,'e:\cmp\1.out');
rewrite(output);}
readln(n,m);
while (n<>0)and(m<>0) do
  begin
  t:=trunc(ln(m)/ln(2))+1;
  if n>=t then writeln(t)
     else begin
          if f[n][m]<>0 then writeln(f[n][m])
             else work;
          end;
  readln(n,m);
  end;
{close(input);
close(output);}
end.