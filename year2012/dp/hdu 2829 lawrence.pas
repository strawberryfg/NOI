const maxn=1020; inf=5555555555555555555; inf2=maxlongint;
var n,m,i,j,len,k,l,r:longint;
    x,ans,res:int64;
    sum,pow:array[0..maxn]of int64;
    f:array[0..maxn,0..maxn]of int64;
    s:array[0..maxn,0..maxn]of longint;
function min(x,y:longint):longint;
begin
if x<y then min:=x else min:=y;
end;
function calc(ll,rr:longint):int64;
begin
calc:=((sum[rr]-sum[ll-1])*(sum[rr]-sum[ll-1])-(pow[rr]-pow[ll-1])) div 2;
end;
begin
{assign(input,'lawrence.in');
reset(input);
assign(output,'lawrence.out');
rewrite(output);}
readln(n,m);
while (n<>0)and(m<>0) do
  begin
  sum[0]:=0; pow[0]:=0;
  for i:=1 to n do begin read(x); sum[i]:=sum[i-1]+x; pow[i]:=pow[i-1]+x*x; end;
  if m=0 then begin ans:=(sum[n]*sum[n]-pow[n]) div 2; writeln(ans); end
     else begin
          for i:=1 to m do for j:=1 to n do f[i][j]:=inf;
          for i:=1 to m+1 do for j:=1 to n do s[i][j]:=inf2;
          for i:=1 to n do s[i][i]:=i;
          for i:=1 to n do f[0][i]:=calc(1,i);
          for len:=1 to n do
              begin
              for i:=1 to min(m,n-len) do
                  begin
                  l:=s[i][i+len-1]; if l=inf2 then l:=i;
                  r:=s[i+1][i+len]; if r=inf2 then r:=i+len-1;
                  for k:=l to r do
                      begin
                      if k+1>i+len then break;
                      if f[i-1][k]=inf then continue;
                      res:=f[i-1][k]+calc(k+1,i+len);
                      if res<=f[i][i+len] then
                         begin
                         f[i][i+len]:=res;
                         s[i][i+len]:=k;
                         end;
                      end;
                  end;
              end;
          writeln(f[m][n]);
          end;
  readln(n,m);
  end;
{close(input);
close(output);}
end.