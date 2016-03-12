const inf=maxlongint; maxn=120; maxq=100020;
var   n,m,q,i,j,a,b,c,t,x,y,k:longint;
      s,ts:string;
      f,g,h:array[0..maxn,0..maxn]of longint;
      que:array[0..maxq,1..2]of longint;
      ans:array[0..maxq]of longint;
      hash:array[0..maxn]of longint;
      p:array[0..maxn]of boolean;
      code:integer;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
assign(input,'destroy.in');
reset(input);
assign(output,'destroy.out');
rewrite(output);
readln(n,m,q);
for i:=1 to n do
    for j:=1 to n do
        f[i][j]:=inf;
for i:=1 to m do
    begin
    readln(a,b,c);
    if c<f[a][b] then f[a][b]:=c;
    if c<f[b][a] then f[b][a]:=c;
    end;
g:=f;
for i:=1 to q do
    begin
    readln(s);
    t:=pos(' ',s);
    if t=0 then
       begin
       val(s,x,code);
       que[i][1]:=x;
       if hash[x]>0 then continue;
       hash[x]:=i;
       for j:=1 to n do
           begin
           if f[x][j]<>inf then
              begin
              f[x][j]:=inf;
              f[j][x]:=inf;
              end;
           end;
       end
    else
       begin
       ts:=copy(s,1,t-1);
       val(ts,x,code);
       delete(s,1,t);
       val(s,y,code);
       que[i][1]:=x; que[i][2]:=y;
       end;
    end;
for k:=1 to n do
    for i:=1 to n do
        for j:=1 to n do
            begin
            if (i<>j)and(i<>k)and(j<>k) then
               if (f[i][k]<>inf)and(f[k][j]<>inf)and(f[i][k]+f[k][j]<f[i][j]) then
                  f[i][j]:=f[i][k]+f[k][j];
            end;
for i:=1 to n do if hash[i]<>0 then p[i]:=false else p[i]:=true;
for i:=q downto 1 do
    begin
    if que[i][2]=0 then
       begin
       if i<>hash[que[i][1]] then continue;
       p[que[i][1]]:=true;
       for j:=1 to n do
           begin
           if j=que[i][1] then continue;
           t:=j;
           f[que[i][1]][t]:=min(f[que[i][1]][t],g[que[i][1]][t]);
           f[t][que[i][1]]:=min(f[t][que[i][1]],g[t][que[i][1]]);
           end;
       for j:=1 to n do
           for k:=1 to n do
               begin
               if (j<>k)and(j<>que[i][1])and(k<>que[i][1]) then
                  if (f[j][que[i][1]]<>inf)and(f[que[i][1]][k]<>inf)and(f[j][que[i][1]]+f[que[i][1]][k]<f[j][k]) then
                      f[j][k]:=f[j][que[i][1]]+f[que[i][1]][k];
               end;
       end
    else
       begin
       if que[i][1]=que[i][2] then ans[i]:=0
          else begin
               if f[que[i][1]][que[i][2]]=inf then ans[i]:=-1
                  else begin
                       if (p[que[i][1]])and(p[que[i][2]]) then ans[i]:=f[que[i][1]][que[i][2]]
                          else ans[i]:=-1;
                       end;
               end;
       end;
    end;
for i:=1 to q do
    begin
    if que[i][2]<>0 then
       writeln(ans[i]);
    end;
close(input);
close(output);
end.