const maxn=100; maxfish=100; maxtime=100; base=10000;
var n,m,st,en,k,i,j,x,y,cnt,p,q,t,tme,loop,res:longint;
    tg,edge:array[0..maxn,0..maxn]of qword;
    rnd:array[0..maxfish,0..maxtime]of longint;
    g,f:array[0..20,0..maxn,0..maxn]of qword;
    h,c,ans:array[0..maxn,0..maxn]of qword;
    hash:array[0..100]of longint;
procedure work1;
var u,i,j,k:longint;
begin
h:=g[0];
f[0]:=g[0];
for u:=1 to loop-1 do
    begin
    fillchar(c,sizeof(c),0);
    for i:=1 to n do
        for j:=1 to n do
            for k:=1 to n do
                begin
                c[i][j]:=(c[i][j]+h[i][k]*g[u][k][j] mod base)mod base;
                end;
    h:=c;
    f[u]:=c;
    end;
end;
procedure calc(x:longint);
var i,j,k:longint;
begin
ans:=h;
dec(x);
while x>0 do
  begin
  if x mod 2=1 then
     begin
     fillchar(c,sizeof(c),0);
     for i:=1 to n do
         for j:=1 to n do
             for k:=1 to n do
                 begin
                 c[i][j]:=(c[i][j]+ans[i][k]*h[k][j] mod base) mod base;
                 end;
     ans:=c;
     end;
  x:=x div 2;
  fillchar(c,sizeof(c),0);
  for i:=1 to n do
      for j:=1 to n do
          for k:=1 to n do
              begin
              c[i][j]:=(c[i][j]+h[i][k]*h[k][j] mod base)mod base;
              end;
  h:=c;
  end;
end;
procedure work2(x:longint);
var i,j,k,u:longint;
begin
if tme div loop<>0 then
   begin
   fillchar(c,sizeof(c),0);
   for i:=1 to n do
       for j:=1 to n do
           for k:=1 to n do
               begin
               c[i][j]:=(c[i][j]+ans[i][k]*f[x][k][j] mod base)mod base;
               end;
   ans:=c;
   end
else
   begin
   ans:=g[0];
   for u:=1 to x do
       begin
       fillchar(c,sizeof(c),0);
       for i:=1 to n do
           for j:=1 to n do
               for k:=1 to n do
                   begin
                   c[i][j]:=(c[i][j]+ans[i][k]*g[u][k][j] mod base)mod base;
                   end;
       ans:=c;
       end;
   end;
end;
begin
{assign(input,'swamp.in');
reset(input);
assign(output,'swamp.out');
rewrite(output);}
readln(n,m,st,en,tme);
inc(st); inc(en);
for i:=1 to m do
    begin
    read(x,y);
    inc(x); inc(y);
    tg[x][y]:=1;
    tg[y][x]:=1;
    inc(edge[x][0]); edge[x][edge[x][0]]:=y;
    inc(edge[y][0]); edge[y][edge[y][0]]:=x;
    end;
readln(cnt);
for i:=1 to cnt do
    begin
    read(rnd[i][0]);
    hash[rnd[i][0]]:=1;
    for j:=1 to rnd[i][0] do begin read(rnd[i][j]); inc(rnd[i][j]); end;
    end;
loop:=12;
for i:=0 to 13 do
    begin
    g[i]:=tg;
    for j:=1 to cnt do
        begin
        t:=(i+1) mod rnd[j][0]; if t=0 then t:=rnd[j][0];
        p:=rnd[j][t];
        for k:=1 to edge[p][0] do
            begin
            q:=edge[p][k];
            g[i][p][q]:=0;
            end;
        end;
    end;
work1;
if tme div loop<>0 then
   calc(tme div loop);
if tme mod loop<>0 then
   begin
   work2(tme mod loop-1);
   end;
p:=0;
for i:=1 to cnt do
    begin
    t:=(tme+1) mod rnd[i][0];
    if t=0 then t:=rnd[i][0];
    if rnd[i][t]=en then
       begin
       p:=1;
       break;
       end;
    end;
if p=1 then writeln(0)
   else writeln(ans[st][en] mod base);
{close(input);
close(output);}
end.