const maxtime=220; maxn=220; inf=maxlongint;
var n,m,sx,sy,cnt,i,j,k,ans:longint;
    stack:array[0..maxn]of longint;
    a:array[0..maxn,0..maxn]of char;
    sumh,suml:array[0..maxn,0..maxn]of longint;
    s,t,d:array[0..maxtime]of longint;
    f:array[0..maxtime,0..maxn,0..maxn]of longint;
procedure workone(num:longint);
var i,j,head,tail:longint;
begin
for j:=1 to m do
    begin
    head:=1; tail:=0;
    for i:=n downto 1 do
        begin
        if a[i][j]='x' then continue;
        while (head<=tail)and((stack[head]-i>t[num]-s[num]+1)or(suml[stack[head]][j]-suml[i][j]<>0)) do inc(head);
        if f[num-1][i][j]<>-inf then
           begin
           while (head<=tail)and(f[num-1][i][j]+i>f[num-1][stack[tail]][j]+stack[tail]) do dec(tail);
           inc(tail); stack[tail]:=i;
           end;
        if (head<=tail) then f[num][i][j]:=f[num-1][stack[head]][j]+stack[head]-i;
        end;
    end;
end;
procedure worktwo(num:longint);
var i,j,head,tail:longint;
begin
for j:=1 to m do
    begin
    head:=1; tail:=0;
    for i:=1 to n do
        begin
        if a[i][j]='x' then continue;
        while (head<=tail)and((i-stack[head]>t[num]-s[num]+1)or(suml[i][j]-suml[stack[head]][j]<>0)) do inc(head);
        if f[num-1][i][j]<>-inf then
           begin
           while (head<=tail)and(f[num-1][i][j]-i>f[num-1][stack[tail]][j]-stack[tail]) do dec(tail);
           inc(tail); stack[tail]:=i;
           end;
        if (head<=tail) then f[num][i][j]:=f[num-1][stack[head]][j]-stack[head]+i;
        end;
    end;
end;
procedure workthree(num:longint);
var i,j,head,tail:longint;
begin
for i:=1 to n do
    begin
    head:=1; tail:=0;
    for j:=m downto 1 do
        begin
        if a[i][j]='x' then continue;
        while (head<=tail)and((stack[head]-j>t[num]-s[num]+1)or(sumh[i][stack[head]]-sumh[i][j]<>0)) do inc(head);
        if f[num-1][i][j]<>-inf then
           begin
           while (head<=tail)and(f[num-1][i][j]+j>f[num-1][i][stack[tail]]+stack[tail]) do dec(tail);
           inc(tail); stack[tail]:=j;
           end;
        if (head<=tail) then f[num][i][j]:=f[num-1][i][stack[head]]+stack[head]-j;
        end;
    end;
end;
procedure workfour(num:longint);
var i,j,head,tail:longint;
begin
for i:=1 to n do
    begin
    head:=1; tail:=0;
    for j:=1 to m do
        begin
        if a[i][j]='x' then continue;
        while (head<=tail)and((j-stack[head]>t[num]-s[num]+1)or(sumh[i][j]-sumh[i][stack[head]]<>0)) do inc(head);
        if f[num-1][i][j]<>-inf then
           begin
           while (head<=tail)and(f[num-1][i][j]-j>f[num-1][i][stack[tail]]-stack[tail]) do dec(tail);
           inc(tail); stack[tail]:=j;
           end;
        if (head<=tail) then f[num][i][j]:=f[num-1][i][stack[head]]-stack[head]+j;
        end;
    end;
end;
begin
assign(input,'adv1900.in');
reset(input);
assign(output,'adv1900.out');
rewrite(output);
readln(n,m,sx,sy,cnt);
for i:=1 to n do
    begin
    for j:=1 to m do
        read(a[i][j]);
    readln;
    end;
for i:=1 to n do
    for j:=1 to m do
        begin
        sumh[i][j]:=sumh[i][j-1];
        if a[i][j]='x' then inc(sumh[i][j]);
        end;
for i:=1 to n do
    for j:=1 to m do
        begin
        suml[i][j]:=suml[i-1][j];
        if a[i][j]='x' then inc(suml[i][j]);
        end;
for i:=1 to cnt do readln(s[i],t[i],d[i]);
for i:=0 to cnt do
    for j:=1 to n do
        for k:=1 to m do
            f[i][j][k]:=-inf;
f[0][sx][sy]:=0;
for i:=1 to cnt do
    begin
    if d[i]=1 then workone(i)
       else if d[i]=2 then worktwo(i)
               else if d[i]=3 then workthree(i)
                       else workfour(i);
    end;
ans:=0;
for i:=1 to n do
    for j:=1 to m do
        if f[cnt][i][j]>ans then
           ans:=f[cnt][i][j];
writeln(ans);
close(input);
close(output);
end.