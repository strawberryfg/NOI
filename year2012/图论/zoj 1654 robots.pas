const maxn=66; maxm=4000000;
type rec=record v,nxt:longint; end;
     rowtype=record x,ll,rr:longint; end;
     coltype=record y,ll,rr:longint; end;
var n,m,now,test,i,j,cntx,cnty,tot,k,pd,ans:longint;
    a:array[0..maxn,0..maxn]of char;
    edge,final,vis:array[0..maxn*maxn*2]of longint;
    g:array[0..maxm]of rec;
    row:array[0..maxn*maxn]of rowtype;
    col:array[0..maxn*maxn]of coltype;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function dfs(x:longint):boolean;
var p:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  if vis[g[p].v]=0 then
     begin
     vis[g[p].v]:=1;
     if (final[g[p].v]=0)or(dfs(final[g[p].v])) then
        begin
        final[g[p].v]:=x;
        exit(true);
        end;
     end;
  p:=g[p].nxt;
  end;
exit(false);
end;
procedure hungary;
var i:longint;
begin
fillchar(final,sizeof(final),0);
ans:=0;
for i:=1 to cntx do
    begin
    fillchar(vis,sizeof(vis),0);
    if dfs(i) then inc(ans);
    end;
writeln(ans);
end;
procedure init;
begin
tot:=0;
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
end;
begin
{assign(input,'robots.in');
reset(input);
assign(output,'robots.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    init;
    readln(n,m);
    for i:=1 to n do
        begin
        for j:=1 to m do
            read(a[i][j]);
        readln;
        end;
    cntx:=0;
    for i:=1 to n do
        begin
        j:=1;
        while j<=m do
          begin
          while (j<=m)and(a[i][j]='#') do inc(j);
          if j>m then break;
          k:=j;
          pd:=0;
          if a[i][j]='o' then pd:=1;
          while (k+1<=m)and(a[i][k+1]<>'#') do
            begin
            if a[i][k+1]='o' then pd:=1;
            inc(k);
            end;
          if pd=1 then
             begin
             inc(cntx); row[cntx].x:=i; row[cntx].ll:=j; row[cntx].rr:=k;
             end;
          j:=k+1;
          end;
        end;
    cnty:=0;
    for j:=1 to m do
        begin
        i:=1;
        while (i<=n) do
          begin
          while (i<=n)and(a[i][j]='#') do inc(i);
          if i>n then break;
          k:=i;
          pd:=0;
          if a[i][j]='o' then pd:=1;
          while (k+1<=n)and(a[k+1][j]<>'#') do
            begin
            if a[k+1][j]='o' then pd:=1;
            inc(k);
            end;
          if pd=1 then
             begin
             inc(cnty); col[cnty].y:=j; col[cnty].ll:=i; col[cnty].rr:=k;
             end;
          i:=k+1;
          end;
        end;
    for i:=1 to cntx do
        for j:=1 to cnty do
            if (row[i].ll<=col[j].y)and(col[j].y<=row[i].rr)and(col[j].ll<=row[i].x)and(row[i].x<=col[j].rr)and(a[row[i].x][col[j].y]='o') then
               addedge(i,j+cntx);
    writeln('Case :',now);
    hungary;
    end;
{close(input);
close(output);}
end.