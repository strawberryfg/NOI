const maxn=2012; inf=maxlongint;
var n,i,j,k,len,res:longint;
    f,s:array[-5..maxn,-5..maxn]of longint;
    head1,tail1,head2,tail2:array[0..maxn]of longint;
    q1,q2:array[0..maxn,0..maxn]of longint;
    t:array[0..maxn]of longint;
procedure cmin(var x:longint; y:longint); begin if y<x then x:=y; end;
function max(x,y:longint):longint; begin if x>y then exit(x) else exit(y); end;
function conv(x,y,opt:longint):longint;
begin
if opt=1 then exit(f[x+1][y]+t[x]) else exit(f[x][y-1]+t[y]);
end;
begin
assign(input,'oil.in');
reset(input);
assign(output,'oil.out');
rewrite(output);
readln(n);
for i:=1 to n do read(t[i]);
for i:=0 to n+1 do
    begin
    f[i][i]:=t[i]; s[i][i]:=i;
    head1[i]:=1; tail1[i]:=1; q1[i][1]:=i-1;
    head2[i]:=1; tail2[i]:=1; q2[i][1]:=i+1;
    end;
for len:=1 to n+1 do
    for i:=0 to n+1-len do
        begin
        j:=i+len; f[i][j]:=inf;
        k:=max(max(s[i][j-1],s[i-1][j-1]),i);
        while (k<=j)and(f[i][k-1]<=f[k+1][j]) do inc(k);
        dec(k); s[i][j]:=k;
        while (head1[j]<=tail1[j])and(q1[j][head1[j]]>k) do inc(head1[j]);
        if head1[j]<=tail1[j] then cmin(f[i][j],conv(q1[j][head1[j]],j,1));
        while (head2[i]<=tail2[i])and(q2[i][head2[i]]<k+1) do inc(head2[i]);
        if head2[i]<=tail2[i] then cmin(f[i][j],conv(i,q2[i][head2[i]],2));
        if i<>0 then
           begin
           res:=conv(i-1,j,1);
           while (head1[j]<=tail1[j])and(res<conv(q1[j][tail1[j]],j,1)) do dec(tail1[j]);
           inc(tail1[j]); q1[j][tail1[j]]:=i-1;
           end;
        if j<>n+1 then
           begin
           res:=conv(i,j+1,2);
           while (head2[i]<=tail2[i])and(res<conv(i,q2[i][tail2[i]],2)) do dec(tail2[i]);
           inc(tail2[i]); q2[i][tail2[i]]:=j+1;
           end;
        end;
writeln(f[0][n+1]);
close(input);
close(output);
end.