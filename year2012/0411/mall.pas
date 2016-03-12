const maxN1=120; maxN2=720; inf=maxlongint;
type rec=record u,v,nxt:longint; end;
     rectype=record l,r,p,q:longint; end;
     re=record x,y:longint;  end;
var n,a,b,c,d,cnt1,cnt2,tot,tot2,total,i,ans,min,num,tmp,finalans:longint;
    edge,vis,final:array[0..maxN2]of longint;
    h:array[0..maxN2]of rec;
    g:array[0..maxN2*maxN2]of rectype;
    sta:array[0..maxN2]of longint;
    flag,col:array[0..maxN1+maxN2]of longint;
    sum,w,bel,hash,cnt:array[0..maxN1,0..maxN2]of longint;
    map:array[0..maxN1,0..maxN2,0..maxN2]of re;
    f:array[0..maxN2]of re;
procedure addedge(x,y:longint);
begin
inc(total); h[total].u:=x; h[total].v:=y; h[total].nxt:=edge[x]; edge[x]:=total;
end;
function dfs(x:longint):boolean;
var p:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  if vis[h[p].v]=0 then
     begin
     vis[h[p].v]:=1;
     if (final[h[p].v]=0)or(dfs(final[h[p].v])) then
        begin
        final[h[p].v]:=x;
        exit(true);
        end;
     end;
  p:=h[p].nxt;
  end;
exit(false);
end;
function dfs2(x:longint):boolean;
var p:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  if (vis[h[p].v]=0)and(flag[h[p].v]=0) then
     begin
     vis[h[p].v]:=1;
     if (final[h[p].v]=0)or(dfs2(final[h[p].v])) then
        begin
        final[h[p].v]:=x;
        exit(true);
        end;
     end;
  p:=h[p].nxt;
  end;
exit(false);
end;
procedure checkit;
var ans,res,i,t,j,a,b:longint;
begin
fillchar(flag,sizeof(flag),0);
res:=tot2;
fillchar(col,sizeof(col),0);
for i:=1 to cnt[num][0] do
    begin
    if sta[i]=0 then
       begin
       dec(res);
       continue;
       end;
    t:=cnt[num][i];
//    res:=res-sum[num][t];
    for j:=1 to sum[num][t] do
        begin
        a:=map[num][t][j].x; b:=map[num][t][j].y;
        if col[bel[a][b]]=0 then
           begin
           col[bel[a][b]]:=1;
           dec(res);
           end;
        flag[bel[a][b]]:=1;
        end;
    end;
ans:=0;
fillchar(final,sizeof(final),0);
for i:=1 to cnt1 do
    begin
    if flag[i]=1 then continue;
    fillchar(vis,sizeof(vis),0);
    if dfs2(i) then inc(ans);
    end;
if res-ans>finalans then finalans:=res-ans;
end;
procedure work(x,maxdep:longint);
var i:longint;
begin
if x>maxdep then
   begin
   checkit;
   exit;
   end;
for i:=0 to 1 do
    begin
    sta[x]:=i;
    work(x+1,maxdep);
    end;
end;
begin
assign(input,'mall.in');
reset(input);
assign(output,'mall.out');
rewrite(output);
readln(n);
cnt1:=0; cnt2:=0;
tot:=0; tot2:=0;
while not eoln do
  begin
  read(a,b,c);
  if a=0 then break;
  d:=c+1; if d>n then d:=1;
  if hash[c][a]=0 then
     begin
     inc(tot2); f[tot2].x:=c; f[tot2].y:=a;
     hash[c][a]:=1;
     inc(cnt[c][0]); cnt[c][cnt[c][0]]:=a;
     if c mod 2=1 then begin inc(cnt1); bel[c][a]:=cnt1; end
        else begin inc(cnt2); bel[c][a]:=cnt2; end;
     end;
  if hash[d][b]=0 then
     begin
     inc(tot2); f[tot2].x:=d; f[tot2].y:=b;
     hash[d][b]:=1;
     inc(cnt[d][0]); cnt[d][cnt[d][0]]:=b;
     if d mod 2=1 then begin inc(cnt1); bel[d][b]:=cnt1; end
        else begin inc(cnt2); bel[d][b]:=cnt2; end;
     end;
  inc(tot);
  if c mod 2=1 then begin g[tot].l:=c; g[tot].r:=a; g[tot].p:=d; g[tot].q:=b; end
     else begin g[tot].l:=d; g[tot].r:=b; g[tot].p:=c; g[tot].q:=a; end;
  end;
for i:=1 to tot do addedge(bel[g[i].l,g[i].r],bel[g[i].p,g[i].q]+cnt1);
if n mod 2=0 then
   begin
   ans:=0;
   for i:=1 to cnt1 do
       begin
       fillchar(vis,sizeof(vis),0);
       if dfs(i) then inc(ans);
       end;
   writeln(cnt1+cnt2-ans);
   end
else
   begin
   min:=inf;
   for i:=1 to n do if cnt[i][0]<min then begin min:=cnt[i][0]; num:=i; end;
   fillchar(edge,sizeof(edge),0);
   cnt1:=0; cnt2:=0;
   fillchar(bel,sizeof(bel),0);
   fillchar(hash,sizeof(hash),0);
   for i:=1 to tot2 do
       begin
       a:=f[i].x; b:=f[i].y;
       if a=num then continue;     //the num floor;
       if hash[a][b]=0 then
          begin
          hash[a][b]:=1;
          if (a<num) then
             begin
             if a mod 2=1 then begin inc(cnt1); bel[a][b]:=cnt1; w[a][b]:=1; end
                else begin inc(cnt2); bel[a][b]:=cnt2; w[a][b]:=2; end;
             end
          else
             begin
             if a mod 2=0 then begin inc(cnt1); bel[a][b]:=cnt1; w[a][b]:=1; end
                else begin inc(cnt2); bel[a][b]:=cnt2; w[a][b]:=2; end;
             end;
          end;
       end;
   for i:=1 to tot do
       begin
       //num->v u->num
       if (g[i].l=num) then
           begin
           inc(sum[g[i].l][g[i].r]);
           tmp:=sum[g[i].l][g[i].r];
           map[g[i].l][g[i].r][tmp].x:=g[i].p; map[g[i].l][g[i].r][tmp].y:=g[i].q;
           end
       else if (g[i].p=num) then
               begin
               inc(sum[g[i].p][g[i].q]);
               tmp:=sum[g[i].p][g[i].q];
               map[g[i].p][g[i].q][tmp].x:=g[i].l; map[g[i].p][g[i].q][tmp].y:=g[i].r;
               end;
       if (g[i].l=num)or(g[i].p=num) then continue;
       if (g[i].l>num)and(g[i].l mod 2=1) then
          begin
          tmp:=g[i].l; g[i].l:=g[i].p; g[i].p:=tmp;
          tmp:=g[i].r; g[i].r:=g[i].q; g[i].q:=tmp;
          end;
       end;
   for i:=1 to tot2 do
       begin
       if w[f[i].x][f[i].y]=2 then bel[f[i].x][f[i].y]:=bel[f[i].x][f[i].y]+cnt1;
       end;
   for i:=1 to tot do
       begin
       if (g[i].l=num)or(g[i].p=num) then continue;     //do not insert num->v or u->num
       addedge(bel[g[i].l,g[i].r],bel[g[i].p,g[i].q]);
       end;
   work(1,cnt[num][0]);
   writeln(finalans);
   end;
close(input);
close(output);
end.