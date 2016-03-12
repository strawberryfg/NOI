const maxn=1020;
      eps=1e-10;
type rec=array[0..maxn]of extended;
var n,m,i,j,num,k,cnt,u:longint;
    b,tmp,f:rec;
    res,hash:array[0..maxn]of longint;
    g:array[0..maxn]of rec;
    nosolution,unique:boolean;
    v,y,sum:extended;
begin
assign(input,'gauss.in');
reset(input);
assign(output,'gauss.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        read(g[i][j]);
    read(b[i]);
    readln;
    end;
nosolution:=false;
unique:=true;
for i:=1 to n do
    res[i]:=-1;
i:=1; j:=1;
while (i<=n)and(j<=m) do
   begin
   num:=i;
   for k:=i+1 to n do
       if abs(g[k][j])>abs(g[num][j]) then
          num:=k;
   if g[num][j]<>0 then
      begin
      res[i]:=j;
      hash[j]:=1;
      tmp:=g[i]; g[i]:=g[num]; g[num]:=tmp;
      y:=b[i]; b[i]:=b[num]; b[num]:=y;
      for k:=i+1 to n do
          begin
          v:=g[k][j]/g[i][j];
          for u:=j to m do
              g[k][u]:=g[k][u]-v*g[i][u];
          b[k]:=b[k]-v*b[i];
          end;
      inc(i);
      end;
   inc(j);
   end;
for i:=1 to n do
    begin
    cnt:=0;
    for j:=1 to m do
        begin
        if abs(g[i][j])>eps then inc(cnt);
        if cnt=1 then break;
        end;
    if (cnt=0) then
       begin
       if b[i]<>0 then
          begin
          nosolution:=true;
          break;
          end;
       end;
    end;
for i:=1 to m do
    if hash[i]=0 then
       begin
       unique:=false;
       break;
       end;
if nosolution then writeln('no solution')
   else if not unique then writeln('not unique')
           else begin
                if n<m then
                   writeln('not unique')
                else
                   begin
                   for i:=n downto 1 do
                       begin
                       if res[i]=-1 then continue;
                       sum:=0;
                       for j:=res[i]+1 to m do
                           sum:=sum+f[j]*g[i][j];
                       sum:=b[i]-sum;
                       f[res[i]]:=sum/g[i][res[i]];
                       end;
                   for i:=1 to m do
                       writeln(i,': ',f[i]:0:10);
                   end;
                end;
close(input);
close(output);
end.