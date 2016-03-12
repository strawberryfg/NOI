const maxn=100; inf=100000000;
      dx:array[1..4]of longint=(1,0,-1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
var n,m,i,j,u,sum,ans,s,t,num,min,now,x,y,tx,ty,tmp,k:longint;
    spe:array[0..maxn*maxn,1..2]of longint;
    v,a:array[0..maxn,0..maxn]of longint;
    g,edge:array[0..maxn*maxn,0..maxn*maxn]of longint;
    h,hash,pre,his,f:array[0..maxn*maxn]of longint;
    flag:boolean;
begin
assign(input,'grid.in');
reset(input);
assign(output,'grid.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    for j:=1 to m do
        begin
        read(a[i][j]);
        sum:=sum+a[i][j];
        v[i][j]:=(i-1)*m+j;
        spe[(i-1)*m+j][1]:=i;
        spe[(i-1)*m+j][2]:=j;
        end;
s:=0; t:=n*m+1;
for i:=1 to n do
    for j:=1 to m do
        begin
        if (i+j)mod 2=0 then
           begin
           g[s][v[i][j]]:=a[i][j];
           x:=s; y:=v[i][j];
           end
        else
           begin
           g[v[i][j]][t]:=a[i][j];
           x:=v[i][j]; y:=t;
           end;
        inc(edge[x][0]); edge[x][edge[x][0]]:=y;
        inc(edge[y][0]); edge[y][edge[y][0]]:=x;
        for k:=1 to 2 do
            begin
            tx:=i+dx[k]; ty:=j+dy[k];
            if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m) then
               begin
               x:=v[i][j]; y:=v[tx][ty];
               inc(edge[x][0]); edge[x][edge[x][0]]:=y;
               inc(edge[y][0]); edge[y][edge[y][0]]:=x;
               if (i+j)mod 2=0 then
                  g[x][y]:=inf
               else
                  g[y][x]:=inf;
               end;
            end;
        end;
now:=maxlongint;
i:=s;
hash[0]:=n*m+2;
while h[s]<n*m+2 do
  begin
  flag:=false;
  his[i]:=now;
  x:=spe[i][1]; y:=spe[i][2];
  for u:=1 to edge[i][0] do
      begin
      j:=edge[i][u];
      if (h[j]+1=h[i])and(g[i][j]>0) then
         begin
         flag:=true;
         if g[i][j]<now then now:=g[i][j];
         pre[j]:=i;
         f[i]:=j;
         i:=j;
         if i=t then
            begin
            ans:=ans+now;
            while i<>s do
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
     min:=n*m+1; num:=-1;
     for u:=1 to edge[i][0] do
         begin
         j:=edge[i][u];
         if (g[i][j]>0)and(h[j]<min) then
            begin
            min:=h[j];
            num:=j;
            end;
         end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     f[i]:=num;
     inc(hash[h[i]]);
     if i<>s then begin i:=pre[i]; now:=his[i]; end;
     end;
  end;
writeln(sum-ans);
close(input);
close(output);
end.