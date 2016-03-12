const maxn=2020;
var g:array[0..maxn,0..maxn]of longint;
    b,f,res:array[0..maxn]of longint;
    ch:char;
    i,j,n,m:longint;
procedure work;
var i,j,k,num,solved,t,tmp:longint;
begin
solved:=0;
t:=-1;
for i:=1 to m do
    begin
    num:=-1;
    for j:=1 to n do
        begin
        if g[i][j]=1 then
           begin
           num:=j;
           break;
           end;
        end;
    res[i]:=num;
    if num=-1 then continue;
    inc(solved);
    for j:=i+1 to m do
        begin
        if g[j][num]=1 then
           begin
           for k:=num to n do
               g[j][k]:=g[j][k] xor g[i][k];
           b[j]:=b[j] xor b[i];
           end;
        end;
    if solved=n then begin t:=i; break; end;
    end;
if solved<n then writeln('Cannot Determine')
   else begin
        writeln(t);
        for i:=t downto 1 do
            begin
            tmp:=0;
            if res[i]=-1 then continue;
            for j:=res[i]+1 to n do
                tmp:=tmp xor (g[i][j] and f[j]);
            tmp:=tmp xor b[i];
            f[res[i]]:=tmp;
            end;
        for i:=1 to n do
            if f[i]=0 then writeln('Earth')
               else writeln('?y7M#');
        end;
end;
begin
assign(input,'insect.in');
reset(input);
assign(output,'insect.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    for j:=1 to n do
        begin
        read(ch);
        g[i][j]:=ord(ch)-48;
        end;
    read(b[i]);
    readln;
    end;
work;
close(input);
close(output);
end.
