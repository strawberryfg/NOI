const maxn=3020;
var n,i,j,num,cnt,x,k,flag:longint;
    g,edge:array[0..maxn,0..maxn]of longint;
    f,b,ans,res:array[0..maxn]of longint;
    nosolution:boolean;
begin
assign(input,'arc.in');
reset(input);
assign(output,'arc.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    read(num);
    edge[i][0]:=num;
    for j:=1 to num do
        begin
        read(x);
        edge[i][j]:=x;
        g[i][x]:=1;
        end;
    if num mod 2=1 then begin g[i][i]:=1; b[i]:=1; end
       else b[i]:=0;
    end;
for i:=1 to n do
    begin
    num:=-1;
    for j:=1 to n do if (g[i][j]=1) then begin num:=j; break; end;
    res[i]:=num;
    if num=-1 then continue;
    for j:=i+1 to n do
        begin
        if g[j][num]=1 then
           begin
           for k:=num to n do
               g[j][k]:=g[j][k] xor g[i][k];
           b[j]:=b[j] xor b[i];
           end;
        end;
    end;
nosolution:=false;
for i:=1 to n do
    begin
    flag:=0;
    for j:=1 to n do if g[i][j]<>0 then begin flag:=1; break; end;
    if (flag=0)and(b[i]<>0) then begin nosolution:=false; break; end;
    end;
if nosolution then writeln('Impossible')
   else begin
        for i:=n downto 1 do
            begin
            if res[i]=-1 then continue;
            f[res[i]]:=0;
            for j:=res[i]+1 to n do
                f[res[i]]:=f[res[i]] xor (g[i][j]*f[j]);
            f[res[i]]:=b[i] xor f[res[i]];
            end;
        ans[0]:=0;
        for i:=1 to n do
            begin
            if f[i]=0 then
               begin
               inc(ans[0]);
               ans[ans[0]]:=i;
               end;
            end;
        writeln(ans[0]);
        for i:=1 to ans[0]-1 do write(ans[i],' ');
        write(ans[ans[0]]);
        writeln;
        for i:=1 to n do
            begin
            cnt:=0;
            for j:=1 to edge[i][0] do
                begin
                if f[edge[i][j]]=f[i] then
                   inc(cnt);
                end;
            if cnt mod 2=1 then
               writeln(-1);
            end;
        end;
close(input);
close(output);
end.
