const maxn=7020; maxm=8000020; maxa=100; maxb=3000;
type rec=record u,v,nxt:longint; end;
var avoid,tmpsum,now,test,i,j,cnta,cntb,cnt,flag1,flag2,tmp,tot,ans,m,x,y,max,suma,sumb:longint;
    a,b,edge,hash,flag,final,vis,col:array[0..maxn]of longint;
    g:array[0..maxm]of rec;
    bel:array[0..maxa,0..maxb]of longint;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function dfs(x:longint):boolean;
var p:longint;
begin
p:=edge[x];
while p<>0 do
  begin
  if (flag[g[p].v]<>-1)and(vis[g[p].v]=0) then
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
for i:=1 to suma do
    begin
    if flag[i]=-1 then continue;
    fillchar(vis,sizeof(vis),0);
    if dfs(i) then inc(ans);
    end;
end;
procedure dfs(x,lasta,lastb:longint);
var i:longint;
begin
if ((lasta<>0)and(lastb<>0))or(x>cnta) then
   begin
   if (lasta<>0) then
      for i:=1 to cntb do
          begin
          if bel[lasta][i]<>now then
             begin
             if col[i]=1 then flag[hash[i]]:=-1 else flag[hash[i]+suma]:=-1;
             end;
          end;
   if (lastb<>0) then
      for i:=1 to cntb do
          begin
          if bel[lastb][i]<>now then
             begin
             if col[i]=1 then flag[hash[i]]:=-1 else flag[hash[i]+suma]:=-1;
             end;
          end;
   avoid:=0;
   for i:=1 to cntb do if flag[i]=-1 then inc(avoid);
   tmpsum:=0;
   if lasta<>0 then inc(tmpsum);
   if lastb<>0 then inc(tmpsum);
   hungary;
   if cntb-avoid-ans+tmpsum>max then  max:=cntb-avoid-ans+tmpsum;
   if (lasta<>0) then
      for i:=1 to cntb do
          begin
          if bel[lasta][i]<>now then
             begin
             if col[i]=1 then flag[hash[i]]:=0 else flag[hash[i]+suma]:=0;
             end;
          end;
   if (lastb<>0) then
      for i:=1 to cntb do
          begin
          if bel[lastb][i]<>now then
             begin
             if col[i]=1 then flag[hash[i]]:=0 else flag[hash[i]+suma]:=0;
             end;
          end;
   exit;
   end;
for i:=0 to 1 do
    begin
    if i=0 then dfs(x+1,lasta,lastb)
       else begin
            if (lasta<>0)and((a[lasta] xor a[x])mod 2=0) then continue;
            if lasta=0 then dfs(x+1,x,lastb)
               else dfs(x+1,lasta,x);
            end;
    end;
end;
procedure init;
begin
tot:=0;
fillchar(edge,sizeof(edge),0);
fillchar(flag,sizeof(flag),0);
fillchar(hash,sizeof(hash),0);
fillchar(col,sizeof(col),0);
max:=0;
end;
begin
assign(input,'friends.in');
reset(input);
assign(output,'friends.out');
rewrite(output);
readln(test);
for now:=1 to test do
    begin
    readln(cnta,cntb,m);
    init;
    for i:=1 to cnta do read(a[i]);
    for i:=1 to cntb do read(b[i]);
    for i:=1 to m do
        begin
        read(x,y);
        bel[x][y]:=now;
        end;
    suma:=0; sumb:=0;
    for i:=1 to cntb do
        begin
        if b[i] mod 2=0 then begin inc(suma); col[i]:=1; hash[i]:=suma; end
           else begin inc(sumb); col[i]:=2; hash[i]:=sumb; end;
        end;
    for i:=1 to cntb-1 do
        for j:=i+1 to cntb do
            begin
            flag1:=0; flag2:=0;
            if (b[i] xor b[j]) mod 2=0 then flag1:=1;
            cnt:=0;
            tmp:=b[i] or b[j];
            while tmp>0 do
              begin
              if tmp mod 2=1 then inc(cnt);
              tmp:=tmp div 2;
              end;
            if cnt mod 2=1 then flag2:=1;
            if (flag1=0)and(flag2=0) then
               begin
               if b[i] mod 2=0 then addedge(hash[i],hash[j]+suma)
                  else addedge(hash[j],hash[i]+suma);
               end;
            end;
    dfs(1,0,0);
    writeln(max);
    end;
close(input);
close(output);
end.