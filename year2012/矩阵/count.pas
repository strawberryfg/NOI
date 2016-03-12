//10:55;
const base=65521;
var k,i,j,p,x,tot,sum:longint;
    fans,tmp,res,n:qword;
    a,map,hash,b,tb,col,num:array[-1..10]of longint;
    sta:array[0..111]of longint;
    bel:array[0..111111]of longint;
    g,ans,c:array[0..111,0..111]of qword;
procedure dfs(dep,max,now:longint);
var i:longint;
begin
if dep>k then
   begin
   inc(tot); sta[tot]:=now; bel[now]:=tot;
   exit;
   end;
for i:=1 to max do
    begin
    a[dep]:=i;
    dfs(dep+1,max,now*10+i);
    a[dep]:=0;
    end;
if dep<>1 then
   begin
   a[dep]:=max+1;
   dfs(dep+1,max+1,now*10+max+1);
   a[dep]:=0;
   end;
end;
procedure work(last:longint);
var i,p,cnt,now:longint;
begin
p:=0;
tb:=b;
for i:=1 to k do if hash[tb[i]]=1 then tb[i]:=-1;
for i:=2 to k do if tb[1]=tb[i] then begin p:=1; break; end;
if tb[1]=-1 then p:=1;
if p=0 then exit;            //neither connected with node from i-k+1 to i-1 nor connected with node i;
fillchar(map,sizeof(map),0);
tb[k+1]:=-1;
cnt:=0;
now:=0;
for i:=2 to k+1 do
    begin
    if map[tb[i]]=0 then
       begin
       inc(cnt);
       map[tb[i]]:=cnt;
       now:=now*10+cnt;
       end
    else
       now:=now*10+map[tb[i]];
    end;
inc(g[bel[last]][bel[now]]);
end;
procedure dfs2(dep,last:longint);
begin
if dep>k then
   begin
   work(last);
   exit;
   end;
if hash[a[dep]]=0 then
   begin
   b[dep]:=a[dep];
   dfs2(dep+1,last);

   b[dep]:=-1;
   hash[a[dep]]:=1;
   dfs2(dep+1,last);

   b[dep]:=0;
   hash[a[dep]]:=0;
   end
else
   begin
   b[dep]:=-1;      // be connected with the i-th node;
   dfs2(dep+1,last);
   end;
end;
procedure calc(x:qword);
var i,j,p:longint;
begin
ans:=g;
dec(x);
while x>0 do
  begin
  if x mod 2=1 then
     begin
     fillchar(c,sizeof(c),0);
     for i:=1 to tot do
         for j:=1 to tot do
             for p:=1 to tot do
                 begin
                 c[i][j]:=(c[i][j]+ans[i][p]*g[p][j] mod base) mod base;
                 end;
     ans:=c;
     end;
  x:=x shr 1;
  fillchar(c,sizeof(c),0);
  for i:=1 to tot do
      for j:=1 to tot do
          for p:=1 to tot do
              c[i][j]:=(c[i][j]+g[i][p]*g[p][j] mod base)mod base;
  g:=c;
  end;
end;
begin
assign(input,'count.in');
reset(input);
assign(output,'count.out');
rewrite(output);
readln(k,n);
if k>n then
   begin
   fans:=1;
   for i:=1 to n-2 do fans:=fans*n mod base;
   writeln(fans mod base);
   end
else
   begin
   dfs(1,1,0);
   for i:=1 to tot do
       begin
       x:=sta[i];
       for j:=k downto 1 do
           begin
           a[j]:=x mod 10;
           x:=x div 10;
           end;
       dfs2(1,sta[i]);
       end;
   calc(n-k);
   fans:=0;
   for i:=1 to tot do
       begin
       x:=sta[i];
       fillchar(col,sizeof(col),0);
       fillchar(num,sizeof(num),0);
       sum:=0;
       for j:=1 to k do
           begin
           if col[x mod 10]=0 then
              begin
              inc(sum);
              num[sum]:=1;
              col[x mod 10]:=sum;
              end
           else
              inc(num[col[x mod 10]]);
           x:=x div 10;
           end;
       tmp:=1;
       for j:=1 to sum do
           begin
           res:=1;
           for p:=1 to num[j]-2 do res:=res*num[j] mod base;
           tmp:=tmp*res mod base;
           end;
       fans:=(fans+tmp*ans[i][1] mod base) mod base;
       end;
   writeln(fans mod base);
   end;
close(input);
close(output);
end.