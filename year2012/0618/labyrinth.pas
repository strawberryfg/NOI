const maxn=300; maxm=30020;
type rec=record v,nxt:longint; end;
     arr=array[0..maxn]of extended;
var n,m,s,t,i,j,tot,tot2,x,y,pd,p,cnt,num,k:longint;
    swap:arr;
    tmp,sum,rate:extended;
    f,a:array[0..maxn]of extended;
    edge,edge2,vis,vis2,res,outer:array[0..maxn]of longint;
    map:array[0..maxn]of arr;
    g,tg:array[0..maxm]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; inc(outer[x]);
end;
procedure addedgeopp(x,y:longint);
begin
inc(tot2); tg[tot2].v:=y; tg[tot2].nxt:=edge2[x]; edge2[x]:=tot2;
end;
procedure dfss(x:longint);
var p:longint;
begin
vis[x]:=1;
p:=edge[x];
while p<>0 do
  begin
  if vis[g[p].v]=0 then dfss(g[p].v);
  p:=g[p].nxt;
  end;
end;
procedure dfst(x:longint);
var p:longint;
begin
vis2[x]:=1;
p:=edge2[x];
while p<>0 do
  begin
  if vis2[tg[p].v]=0 then dfst(tg[p].v);
  p:=tg[p].nxt;
  end;
end;
begin
assign(input,'labyrinth.in');
reset(input);
assign(output,'labyrinth.out');
rewrite(output);
readln(n,m,s,t);
for i:=1 to m do
    begin
    readln(x,y);
    addedge(x,y);
    addedgeopp(y,x);
    end;
pd:=0;
for i:=1 to n do if (vis[i]=1)and(vis2[i]=0) then begin pd:=1; break; end;
if pd=1 then writeln('INF')
   else begin
        fillchar(map,sizeof(map),0);
        dfss(s);
        dfst(t);
        f[t]:=0;
        cnt:=0;
        for i:=1 to n do
            begin
            if vis[i]=0 then continue;
            if i=t then continue;
            p:=edge[i];
            inc(cnt);
            while p<>0 do
              begin
              if vis2[g[p].v]=1 then map[cnt][g[p].v]:=map[cnt][g[p].v]-1;
              p:=g[p].nxt;
              end;
            map[cnt][i]:=outer[i];
            a[cnt]:=outer[i];  // cnt[i]*f[i]-sigma(f[v])=1;
            end;
        for i:=1 to cnt do res[i]:=-1;
        i:=1; j:=1;
        while (i<=cnt)and(j<=n) do
          begin
          num:=i;
          for k:=i+1 to cnt do
              if abs(map[k][j])>abs(map[num][j]) then
                 num:=k;
          swap:=map[i]; map[i]:=map[num]; map[num]:=swap;
          tmp:=a[i]; a[i]:=a[num]; a[num]:=tmp;
          if map[i][j]<>0 then
             begin
             res[i]:=j;
//             hash[j]:=1;
             for k:=i+1 to cnt do
                 begin
                 rate:=map[k][j]/map[i][j];
                 for p:=j to n do map[k][p]:=map[k][p]-rate*map[i][p];
                 a[k]:=a[k]-rate*a[i];
                 end;
             inc(i);
             end;
          inc(j);
          end;
        for i:=cnt downto 1 do
            begin
            if res[i]=-1 then continue;
            sum:=0;
            for j:=res[i]+1 to n do sum:=sum+map[i][j]*f[j];
            sum:=a[i]-sum;
            f[res[i]]:=sum/map[i][res[i]];
            end;
        writeln(round(f[s]*1000)/1000:0:3);
        end;
close(input);
close(output);
end.