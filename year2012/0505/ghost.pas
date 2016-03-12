const maxvertical=1020; maxh=1020; maxn=200020;
type rec=record ll,rr,h:longint; end;
var n,m,h,k,i,j,tot,ans,tans,tmp,res,idx,idy,t,tx,ty,tt:longint;
    value:array[0..maxvertical]of longint;
    edge,next,pre,hash,bel,ind:array[0..maxvertical,0..maxh]of longint;
    cnt,f:array[0..maxn,1..2]of longint;
    g:array[0..maxn]of rec;
    a,b:array[0..maxn]of longint;
procedure addedge(x,y:longint);
begin
inc(edge[x][0]); edge[x][edge[x][0]]:=y;
ind[x][edge[x][0]]:=tot;
end;
procedure sort(opt,l,r: longint);
var i,j,cmp,swap: longint;
begin
i:=l; j:=r; cmp:=edge[opt][(l+r) div 2];
repeat
while edge[opt][i]<cmp do inc(i);
while cmp<edge[opt][j] do dec(j);
if not(i>j) then begin swap:=edge[opt][i]; edge[opt][i]:=edge[opt][j]; edge[opt][j]:=swap; swap:=ind[opt][i]; ind[opt][i]:=ind[opt][j]; ind[opt][j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(opt,l,j);
if i<r then sort(opt,i,r);
end;
procedure work(opt,x,flag:longint);
begin
if f[x][opt]<>-1 then exit;
if flag=1 then inc(cnt[x][opt]);
if opt=2 then
   begin
   if next[g[x].rr][g[x].h]<>0 then
      begin
      work(hash[g[x].rr][next[g[x].rr][g[x].h]],bel[g[x].rr][next[g[x].rr][g[x].h]],flag);
      f[x][opt]:=f[bel[g[x].rr][next[g[x].rr][g[x].h]]][hash[g[x].rr][next[g[x].rr][g[x].h]]];
      end
   else f[x][opt]:=value[g[x].rr];
   end
else
   begin
   if next[g[x].ll][g[x].h]<>0 then
      begin
      work(hash[g[x].ll][next[g[x].ll][g[x].h]],bel[g[x].ll][next[g[x].ll][g[x].h]],flag);
      f[x][opt]:=f[bel[g[x].ll][next[g[x].ll][g[x].h]]][hash[g[x].ll][next[g[x].ll][g[x].h]]];
      end
   else f[x][opt]:=value[g[x].ll];
   end;
end;
begin
assign(input,'ghost.in');
reset(input);
assign(output,'ghost.out');
rewrite(output);
readln(n,m,h,k);
for i:=1 to n do readln(value[i]);
tot:=0;
for i:=1 to m do
    begin
    readln(a[i],b[i]);
    hash[a[i]][b[i]]:=2;   //->
    hash[a[i]+1][b[i]]:=1; //<-
    inc(tot); g[tot].ll:=a[i]; g[tot].rr:=a[i]+1; g[tot].h:=b[i];
    bel[a[i]][b[i]]:=tot;
    bel[a[i]+1][b[i]]:=tot;
    addedge(a[i],b[i]);
    addedge(a[i]+1,b[i]);
    end;
for i:=1 to m do
    begin
    f[i][1]:=-1;
    f[i][2]:=-1;
    end;
for i:=1 to n do
    if edge[i][0]<>0 then sort(i,1,edge[i][0]);
for i:=1 to n do
    if edge[i][0]<>0 then
       for j:=1 to edge[i][0]-1 do
           begin
           next[i][edge[i][j]]:=edge[i][j+1];
           pre[i][edge[i][j+1]]:=edge[i][j];
           end;
for i:=1 to k do
    begin
    if edge[i][0]<>0 then
       begin
       work(hash[i][edge[i][1]],ind[i][1],1);
       end;
    end;
for i:=1 to m do
    begin
    if f[i][1]=-1 then work(1,i,0);
    if f[i][2]=-1 then work(2,i,0);
    end;
ans:=0;
for i:=1 to k do
    begin
    if edge[i][0]=0 then ans:=ans+value[i]
       else begin
            if hash[i][edge[i][1]]=2 then ans:=ans+f[ind[i][1]][2]
               else ans:=ans+f[ind[i][1]][1];
            end;
    end;
tans:=ans;
for i:=1 to m do
    begin
    res:=tans;
    tmp:=pre[g[i].ll][g[i].h];
    if tmp=0 then
       begin
       tt:=0;
       if (g[i].ll<=k)and(edge[g[i].ll][1]=g[i].h) then inc(tt);
       end
    else
       begin
       if hash[g[i].ll][tmp]=1 then ty:=2 else ty:=1;
       idy:=bel[g[i].ll][tmp];
       tt:=cnt[idy][ty];
       end;
    if next[g[i].ll][g[i].h]=0 then
       begin
       if (tt<>0)and(cnt[i][2]<>0)and(f[i][2]<>-1) then
          res:=res-cnt[i][2]*f[i][2]+tt*value[g[i].ll]
       end
       else begin
            t:=next[g[i].ll][g[i].h];
            idx:=bel[g[i].ll][t];
            if hash[g[i].ll][t]=2 then tx:=2 else tx:=1;
            if (tt<>0)and(cnt[i][2]<>0)and(f[i][2]<>-1) then
               res:=res-cnt[i][2]*f[i][2]+tt*f[idx][tx]
            end;
    tmp:=pre[g[i].rr][g[i].h];
    if tmp=0 then
       begin
       tt:=0;
       if (g[i].rr<=k)and(edge[g[i].rr][1]=g[i].h) then inc(tt);
       end
    else
       begin
       if hash[g[i].rr][tmp]=1 then ty:=2 else ty:=1;
       idy:=bel[g[i].rr][tmp];
       tt:=cnt[idy][ty];
       end;
    if next[g[i].rr][g[i].h]=0 then
       begin
       if (tt<>0)and(cnt[i][1]<>0)and(f[i][1]<>-1) then
          res:=res-cnt[i][1]*f[i][1]+tt*value[g[i].rr];
       end
       else begin
            t:=next[g[i].rr][g[i].h];
            idx:=bel[g[i].rr][t];
            if hash[g[i].rr][t]=2 then tx:=2 else tx:=1;
            if (tt<>0)and(cnt[i][1]<>0)and(f[i][1]<>-1) then
               res:=res-cnt[i][1]*f[i][1]+tt*f[idx][tx]
            end;
//    writeln(g[i].ll,' ',g[i].rr,' ',g[i].h,' ',res);
    if res<ans then ans:=res;
    end;
writeln(ans);
close(input);
close(output);
end.