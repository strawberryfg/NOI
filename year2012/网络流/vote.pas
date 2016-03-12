const maxn=400;
var n,m,i,j,t,x,y,ans,now,min,num:longint;
    g:array[0..maxn,0..maxn]of longint;
    hash,his,pre,f,h:array[0..maxn]of longint;
    flag:boolean;
begin
assign(input,'vote.in');
reset(input);
assign(output,'vote.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    read(t);
    if t=0 then g[0][i]:=1
       else g[i][n+1]:=1;
    end;
for i:=1 to m do
    begin
    readln(x,y);
    g[x][y]:=1;
    g[y][x]:=1;
    end;
for i:=0 to n+1 do f[i]:=0;
now:=maxlongint;
hash[0]:=n+2;
ans:=0;
i:=0;
while h[0]<n+1 do
  begin
  his[i]:=now;
  flag:=false;
  for j:=f[i] to n+1 do
      begin
      if (g[i][j]>0)and(h[j]+1=h[i]) then
         begin
         flag:=true;
         if g[i][j]<now then now:=g[i][j];
         pre[j]:=i;
         f[i]:=j;
         i:=j;
         if i=n+1 then
            begin
            ans:=ans+now;
            while i<>0 do
              begin
              dec(g[pre[i]][i],now);
              inc(g[i][pre[i]],now);
              i:=pre[i];
              end;
            now:=maxlongint;
            end;
         break;
         end;
      end;
  if not flag then
     begin
     min:=n+1; num:=-1;
     for j:=0 to n+1 do
         begin
         if (g[i][j]>0)and(h[j]<min) then
            begin
            min:=h[j];
            num:=j;
            end;
         end;
     f[i]:=num;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     inc(hash[h[i]]);
     if i<>0 then begin i:=pre[i]; now:=his[i]; end;
     end;
  end;
writeln(ans);
close(input);
close(output);
end.
