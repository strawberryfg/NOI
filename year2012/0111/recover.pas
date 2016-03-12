const maxn=2020;
var n,m,i,j:longint;
    a,g:array[0..maxn,0..maxn]of char;
begin
assign(input,'recover.in');
reset(input);
assign(output,'recover.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(a[i][j]);
        end;
    readln;
    end;
for i:=0 to 2*n-1 do
    for j:=0 to 2*m-1 do
        g[i][j]:=' ';
for i:=1 to n do
    for j:=1 to m do
        begin
        g[2*i-1][2*j-1]:='o';
        if a[i][j]='S' then
           begin
           if g[2*i-2][2*j-1]='|' then
              g[2*i][2*j-1]:='|'
           else
              if g[2*i-1][2*j-2]='-' then
                 g[2*i-1][2*j]:='-';
           end
        else if a[i][j]='T' then
                begin
                if g[2*i-2][2*j-1]='|' then
                   begin
                   if g[2*i-1][2*j-2]<>'-' then
                      g[2*i-1][2*j]:='-';
                   end
                else
                   begin
                   if g[2*i-1][2*j-2]='-' then
                      g[2*i][2*j-1]:='|'
                   else begin
                        g[2*i-1][2*j]:='-';
                        g[2*i][2*j-1]:='|';
                        end;
                   end;
                end;
        end;
for i:=1 to 2*n-1 do
    begin
    for j:=1 to 2*m-1 do
        write(g[i][j]);
    writeln;
    end;
close(input);
close(output);
end.
