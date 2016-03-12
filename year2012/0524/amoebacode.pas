const maxn=100; maxsta=777778; inf=maxlongint;
var t,n,k,cnt,ans,i,j,tot,pow,le,ri,mid,f,u:longint;
    code:integer;
    s,ts:string;
    a,b,c:array[0..maxn]of longint;
    g:array[0..maxsta,1..7]of integer;
    h:array[0..100,0..10]of longint;
    sta,hash:array[0..100]of longint;
    can:array[0..1,0..maxsta]of longint;
    flag1,flag2:array[0..maxsta]of longint;
procedure init(x,now,depth:longint);
var i:longint;
begin
if x>depth then
   begin
   for i:=1 to k do g[now][i]:=k+1;
   for i:=1 to depth do
       if depth-i<g[now][sta[i]] then g[now][sta[i]]:=depth-i;
   exit;
   end;
for i:=1 to k do
    begin
    sta[x]:=i;
    init(x+1,now*10+i,depth);
    end;
end;
function work(x,y:longint):longint;
var le,ri,ans,mid:longint;
begin
if h[x][y]<>0 then exit(h[x][y]);
le:=1; ri:=tot; ans:=inf;
while le<=ri do
  begin
  mid:=(le+ri) div 2;
  if c[mid]>=x then ri:=mid-1
     else begin
          ans:=mid;
          le:=mid+1;
          end;
  end;
if ans=inf then begin h[x][y]:=inf; exit(inf); end;
for i:=ans downto 1 do if a[c[i]]=y then begin h[x][y]:=x-c[i]; exit(h[x][y]); end;
h[x][y]:=inf;
exit(inf);
end;
function check(mindis:longint):boolean;
var sum,tsum,xx,total,i,j,p,now,tmp,minn,tminn:longint;
begin
sum:=1; xx:=0; can[0][1]:=0;
total:=0;
for i:=1 to n do
    begin
    tsum:=0;
    if hash[i]=0 then
       begin
       minn:=work(i,a[i]);
       if minn<mindis then exit(false);
       for j:=1 to sum do
           begin
           tminn:=minn;
           now:=can[xx][j];
           if (g[now][a[i]]<>inf) then
              begin
              tmp:=total-g[now][a[i]];
              if (tmp>0)and(i-b[tmp]<tminn) then tminn:=i-b[tmp];
              end;
           if tminn>=mindis then
              begin
              if i=n then exit(true);
              if (flag1[can[xx][j]]<>ans)or((flag1[can[xx][j]]=ans)and(flag2[can[xx][j]]<>i)) then
                 begin
                 flag1[can[xx][j]]:=ans;
                 flag2[can[xx][j]]:=i;
                 inc(tsum);
                 can[xx xor 1][tsum]:=can[xx][j];
                 end;
              end;
           end;
       xx:=xx xor 1;
       sum:=tsum;
       end
    else
       begin
       for j:=1 to k do
           begin
           minn:=work(i,j);
           if minn<mindis then continue;
           for p:=1 to sum do
               begin
               tminn:=minn;
               now:=can[xx][p];
               if (g[now][j]<>inf) then
                  begin
                  tmp:=total-g[now][j];
                  if (tmp>0)and(i-b[tmp]<tminn) then tminn:=i-b[tmp];
                  end;
               if tminn>=mindis then
                  begin
                  if i=n then exit(true);
                  if (flag1[(can[xx][p]*10+j) mod pow]<>ans)or((flag1[(can[xx][p]*10+j)mod pow]=ans)and(flag2[(can[xx][p]*10+j) mod pow]<>i)) then
                     begin
                     flag1[(can[xx][p]*10+j) mod pow]:=ans;
                     flag2[(can[xx][p]*10+j) mod pow]:=i;
                     inc(tsum);
                     can[xx xor 1][tsum]:=(can[xx][p]*10+j) mod pow;
                     end;
                  end;
               end;
           end;
       xx:=xx xor 1;
       sum:=tsum;
       end;
    if hash[i]=1 then inc(total);
    if sum=0 then exit(false);
    end;
end;
begin
assign(input,'amoebacode.in');
reset(input);
assign(output,'amoebacode.out');
rewrite(output);
readln(s);
t:=pos(' ',s);
ts:=copy(s,1,t-1);
n:=length(ts);
for i:=1 to n do a[i]:=ord(ts[i])-ord('0');
delete(s,1,t);
val(s,k,code);
cnt:=0;
for i:=1 to n do if a[i]=0 then begin inc(cnt); b[cnt]:=i; hash[i]:=1; end; //zero
tot:=0;
for i:=1 to n do if a[i]<>0 then begin inc(tot); c[tot]:=i; end; //not zero
pow:=1;
for i:=1 to k-1 do pow:=pow*10;
for i:=1 to k-1 do
    init(1,0,i);
for i:=1 to k do g[0][i]:=k+1;
for i:=1 to cnt-1 do if b[i]+1=b[i+1] then begin f:=1; break; end;
ri:=n;
for i:=1 to tot-1 do
    for j:=i+1 to tot do
        begin
        if a[c[i]]=a[c[j]] then if (c[j]-c[i]<ri) then ri:=c[j]-c[i];
        end;
if f=1 then begin le:=2; ans:=1; end
   else begin le:=1; ans:=-1; end;
for ans:=k downto 1 do
    begin
    if check(ans) then
       begin
       writeln(ans);
       break;
       end;
   end;
close(input);
close(output);
end.