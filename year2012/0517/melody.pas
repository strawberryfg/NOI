const maxn=120; maxlen=100200; maxq=6000020; inf=maxlongint;
var n,s,maxwrong,i,j,len,sum,k,head,tail,cnt,tot,flag,x,now,ans1,ans,le,ri:longint;
    a,g,dis,fa:array[0..maxn,0..maxn]of longint;
    b,c,from,ansc,ansfrom,col,ret,f:array[0..maxlen]of longint;
    mark:array[0..maxn]of boolean;
    q:array[0..maxq]of longint;
    ch:char;
begin
assign(input,'melody.in');
reset(input);
assign(output,'melody.out');
rewrite(output);
readln(n,s,maxwrong);
for i:=1 to n do
    begin
    for j:=1 to s do
        begin
        read(ch);
        a[i][j]:=ord(ch)-ord('0');
        end;
    readln;
    end;
readln(len);
for i:=1 to len do read(b[i]);
for i:=1 to n do
    for j:=i to n do
        begin
        sum:=0;
        for k:=1 to s do
            begin
            if a[i][k]<>a[j][k] then inc(sum);
            if sum>maxwrong then break;
            end;
        if sum<=maxwrong then begin g[i][j]:=1; g[j][i]:=1; end;
        end;
for i:=1 to n do for j:=1 to n do dis[i][j]:=inf;
for i:=1 to n do
    begin
    dis[i][i]:=0; fa[i][i]:=0;
    head:=1; tail:=1; q[1]:=i;
    fillchar(mark,sizeof(mark),false);
    mark[i]:=true;
    while head<=tail do
      begin
      for j:=1 to n do
          begin
          if (g[q[head]][j]=1)and(dis[i][q[head]]+1<dis[i][j]) then
             begin
             dis[i][j]:=dis[i][q[head]]+1;
             fa[i][j]:=q[head];
             if not mark[j] then
                begin
                mark[j]:=true;
                inc(tail);
                q[tail]:=j;
                end
             end
          end;
      mark[q[head]]:=false;
      inc(head);
      end;
    end;
cnt:=0;
for i:=1 to n do
    if col[i]=0 then
       begin
       inc(cnt);
       for j:=1 to n do
           if dis[i][j]<>inf then
              col[j]:=cnt;
       end;
ans:=-1;
for i:=1 to cnt do
    begin
    tot:=0;
    for j:=1 to len do
        begin
        if col[b[j]]=i then
           begin
           inc(tot);
           c[tot]:=j;
           end;
        end;
    flag:=0;
    for j:=1 to tot do
        begin
        f[j]:=1; from[j]:=0;
        for k:=j-1 downto 1 do
            begin
            if (f[k]+1>f[j])and(c[j]-c[k]>=dis[b[c[j]]][b[c[k]]]) then
               begin
               f[j]:=f[k]+1; from[j]:=k;
               end;
            if c[j]-c[k]>100 then break;
            end;
        if f[j]>ans then
           begin
           ans:=f[j]; ans1:=j; flag:=1;
           end;
        end;
    if flag=1 then
       begin
       ansc:=c; ansfrom:=from;
       end;
    end;
writeln(len-ans);
i:=ans1;
while i<>0 do
  begin
  if ansfrom[i]=0 then
     begin
     for j:=1 to ansc[i] do ret[j]:=b[ansc[i]];
     break;
     end;
  le:=b[ansc[ansfrom[i]]]; ri:=b[ansc[i]]; now:=ansc[i];  //1..len zhongde nayige weizhi
  x:=ri;
  while x<>0 do
    begin
    ret[now]:=x;
    x:=fa[le][x];
    dec(now);
    end;
  for j:=ansc[ansfrom[i]] to now do
      ret[j]:=ret[now+1];
  i:=ansfrom[i];
  end;
for i:=ansc[ans1]+1 to len do
    ret[i]:=ret[ansc[ans1]];
for i:=1 to len-1 do write(ret[i],' ');
write(ret[len]);
writeln;
close(input);
close(output);
end.
