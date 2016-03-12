const maxn=100; maxstate=88888;
type rec=record v,num:longint; end;
var n,sum,i,j,k,le,ri,mid,ret1,ret2,tmp,ans:longint;
    a,sta:array[0..maxn]of longint;
    f,tf:array[1..2,0..maxstate]of rec;
    cnt:array[1..2]of longint;
    hash:array[0..1111111]of longint;
procedure dfs(x,maxdep,suma,sumb,state,opt:longint);
var i:longint;
begin
if x>maxdep then
   begin
   inc(cnt[opt]); f[opt][cnt[opt]].num:=state;
   if opt=1 then f[opt][cnt[opt]].v:=suma-sumb else f[opt][cnt[opt]].v:=sumb-suma;
   exit;
   end;
for i:=0 to 2 do
    begin
    sta[x]:=i;
    if i=0 then dfs(x+1,maxdep,suma,sumb,state*2+0,opt)
       else if i=1 then dfs(x+1,maxdep,suma+a[x],sumb,state*2+1,opt)
               else dfs(x+1,maxdep,suma,sumb+a[x],state*2+1,opt);
    end;
end;
procedure sort(opt,l,r: longint);
var i,j,xx,yy: longint;
    swap:rec;
begin
i:=l; j:=r; xx:=f[opt][(l+r) div 2].v; yy:=f[opt][(l+r)div 2].num;
repeat
while (f[opt][i].v<xx)or((f[opt][i].v=xx)and(f[opt][i].num<yy)) do inc(i);
while (xx<f[opt][j].v)or((xx=f[opt][j].v)and(yy<f[opt][j].num)) do dec(j);
if not(i>j) then begin swap:=f[opt][i]; f[opt][i]:=f[opt][j]; f[opt][j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(opt,l,j);
if i<r then sort(opt,i,r);
end;
begin
assign(input,'subsets.in');
reset(input);
assign(output,'subsets.out');
rewrite(output);
readln(n);
for i:=1 to n do readln(a[i]);
dfs(1,n-n div 2,0,0,0,1);     // set brown;
dfs(n-n div 2+1,n,0,0,0,2);   // set white;
for i:=1 to 2 do
    sort(i,1,cnt[i]);
for i:=1 to 2 do
    begin
    sum:=0;
    j:=1;
    while j<=cnt[i] do
      begin
      k:=j;
      while (k+1<=cnt[i])and(f[i][k+1].num=f[i][j].num)and(f[i][k+1].v=f[i][j].v) do inc(k);
      inc(sum);
      tf[i][sum].v:=f[i][j].v; tf[i][sum].num:=f[i][j].num;
      j:=k+1;
      end;
    cnt[i]:=sum;
    end;
f:=tf;
ans:=0;
for i:=1 to cnt[1] do
    begin
    le:=1; ri:=cnt[2]; ret1:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if f[2][mid].v<f[1][i].v then le:=mid+1
         else if f[2][mid].v>f[1][i].v then ri:=mid-1
                 else begin
                      ret1:=mid;
                      ri:=mid-1;
                      end;
      end;
    if ret1=-1 then continue;
    le:=1; ri:=cnt[2]; ret2:=-1;
    while le<=ri do
      begin
      mid:=(le+ri)div 2;
      if f[2][mid].v<f[1][i].v then le:=mid+1
         else if f[2][mid].v>f[1][i].v then ri:=mid-1
                 else begin
                      ret2:=mid;
                      le:=mid+1;
                      end;
      end;
    if ret2=-1 then continue;
    for j:=ret1 to ret2 do
        begin
        tmp:=f[1][i].num*(1 shl (n div 2))+f[2][j].num;
        if (hash[tmp]=0)and((f[1][i].num<>0)or(f[2][j].num<>0)) then
           begin
           hash[tmp]:=1;
           inc(ans);
           end;
        end;
    end;
writeln(ans);
close(input);
close(output);
end.