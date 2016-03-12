const maxn=200000; maxm=8000000;  inf=maxlongint;
type rec=record u,v,nxt:longint; end;
var n,m,i,j,x,y,min,num,t1,t2,t,p,sum,tot:longint;
    g:array[0..maxm]of rec;
    fa,cnt,hash,ans,deg,edge,map:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=ans[(l+r) div 2];
repeat
while ans[i]<x do inc(i);
while x<ans[j] do dec(j);
if not(i>j) then begin y:=ans[i]; ans[i]:=ans[j]; ans[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
begin
assign(input,'biu.in');
reset(input);
assign(output,'biu.out');
rewrite(output);
readln(n,m);
fillchar(deg,sizeof(deg),0);
for i:=1 to m do
    begin
    readln(x,y);
    inc(deg[x]);
    inc(deg[y]);
    addedge(x,y);
    addedge(y,x);
    end;
min:=inf; num:=-1;
for i:=1 to n do
    begin
    if deg[i]<min then
       begin
       min:=deg[i];
       num:=i;
       end;
    end;
for i:=1 to n+1 do begin fa[i]:=i; cnt[i]:=1; end;
fillchar(map,sizeof(map),0);
p:=edge[num];
while p<>0 do
  begin
  if (g[p].v<>num) then
     map[g[p].v]:=1;
  p:=g[p].nxt;
  end;
fillchar(hash,sizeof(hash),0);
for i:=1 to n do
    begin
    if (i<>num)and(map[i]=0) then
       begin
       fa[i]:=n+1;
       hash[i]:=1;
       inc(cnt[n+1]);
       end;
    end;
hash[num]:=1;
fa[num]:=n+1;
for i:=1 to n do
    begin
    if hash[i]=0 then
       begin
       p:=edge[i];
       fillchar(map,sizeof(map),0);
       while p<>0 do
         begin
         if (g[p].v<>i) then
            map[g[p].v]:=1;
         p:=g[p].nxt;
         end;
       for j:=1 to n do
           begin
           if (i<>j)and(map[j]=0) then
              begin
              if hash[j]=0 then
                 begin
                 t1:=getfa(i);
                 t2:=getfa(j);
                 if t1<>t2 then
                    begin
                    cnt[t1]:=cnt[t1]+cnt[t2];
                    fa[t2]:=t1;
                    end;
                 end
              else
                 begin
                 t1:=getfa(n+1);
                 t2:=getfa(i);
                 if t1<>t2 then
                    begin
                    cnt[t1]:=cnt[t1]+cnt[t2];
                    fa[t2]:=t1;
                    end;
                 end;
              end;
           end;
       end;
    end;
sum:=0;
fillchar(hash,sizeof(hash),0);
for i:=1 to n+1 do
    begin
    t:=getfa(i);
    if hash[t]=0 then
       begin
       hash[t]:=1;
       inc(sum);
       ans[sum]:=cnt[t];
       end;
    end;
sort(1,sum);
writeln(sum);
for i:=1 to sum-1 do write(ans[i],' ');
write(ans[sum]);
writeln;
close(input);
close(output);
end.
