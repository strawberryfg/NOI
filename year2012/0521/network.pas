const maxn=1020; inf=maxlongint;
type rec=record u,v,w:longint; end;
var n,i,j,t1,t2,flag1,flag2,ans,cost,sum,tot,cnt,xx,yy:longint;
    g:array[0..maxn*maxn*4]of rec;
    sta,fa:array[0..maxn]of longint;
    a,hash:array[0..maxn,0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,cmp:longint; swap:rec;
begin
i:=l; j:=r; cmp:=g[(l+r) div 2].w;
repeat
while g[i].w<cmp do inc(i);
while cmp<g[j].w do dec(j);
if not(i>j) then begin swap:=g[i]; g[i]:=g[j]; g[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
getfa:=fa[x];
end;
begin
assign(input,'network.in');
reset(input);
assign(output,'network.out');
rewrite(output);
readln(n);
flag1:=0; flag2:=1;
for i:=1 to n do begin read(sta[i]); if sta[i]=1 then flag1:=1; if sta[i]=2 then flag2:=0; end;
for i:=1 to n do
    for j:=1 to n do
        read(a[i][j]);
if flag1=1 then
   begin
   ans:=0; cost:=0;
   for i:=1 to n do
       if sta[i]=1 then
          for j:=1 to n do
              if (i<>j)and(hash[i][j]=0) then
                 begin
                 inc(ans); inc(cost,a[i][j]);
                 hash[i][j]:=1; hash[j][i]:=1;
                 end;
   writeln(ans,' ',cost);
   end
else if flag2=1 then
        begin
        tot:=0;
        for i:=1 to n-1 do
            for j:=i+1 to n do
                begin
                inc(tot); g[tot].u:=i; g[tot].v:=j; g[tot].w:=a[i][j];
                end;
        sort(1,tot);
        for i:=1 to n do fa[i]:=i;
        i:=1; cnt:=0; cost:=0;
        while (i<=tot)and(cnt<n-1) do
          begin
          t1:=getfa(g[i].u); t2:=getfa(g[i].v);
          if t1<>t2 then
             begin
             fa[t2]:=t1;
             cost:=cost+g[i].w;
             inc(cnt);
             end;
          inc(i);
          end;
        writeln(n-1,' ',cost);
        end
     else begin
          cost:=inf; cnt:=0; xx:=0; yy:=0;
          for i:=1 to n do if sta[i]=2 then begin inc(cnt); if cnt=1 then xx:=i; if cnt=2 then yy:=i; end;
          for i:=1 to n do
              begin
              sum:=0;
              for j:=1 to n do
                  if (i<>j) then sum:=sum+a[i][j];
              if sum<cost then cost:=sum;
              end;
          if cnt=2 then
             begin
             sum:=a[xx][yy];
             for i:=1 to n do
                 if (i<>xx)and(i<>yy) then
                    if a[i][xx]<a[i][yy] then sum:=sum+a[i][xx]
                       else sum:=sum+a[i][yy];
             if sum<cost then cost:=sum;
             end;
          writeln(n-1,' ',cost);
          end;
close(input);
close(output);
end.
