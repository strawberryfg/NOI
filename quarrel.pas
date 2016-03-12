const maxn=1020; maxq=1000020; maxk=1000020;
var n,m,i,x,y,tot,t,head,tail:longint;
    flag:boolean;
    q:array[0..maxq]of array[1..4]of longint;
    pre:array[0..maxq]of longint;
    a,b:array[0..maxk]of longint;
    done:array[0..maxn,0..maxn,1..2]of boolean;
    edge:array[0..maxn,0..maxn]of longint;
procedure work;
var x,y,i:longint;
begin
head:=1; tail:=1;
q[1][1]:=1; q[1][2]:=n; q[1][3]:=1; q[1][4]:=0; //step;
done[1][n][1]:=true;
while head<=tail do
  begin
  x:=q[head][1]; y:=q[head][2];
  if q[head][3]=1 then
     begin
     for i:=1 to edge[y][0] do
         begin
         if (not done[x][edge[y][i]][2]) then
            begin
            inc(tail);
            q[tail][1]:=x; q[tail][2]:=edge[y][i]; q[tail][3]:=2; q[tail][4]:=q[head][4]+1;
            done[x][edge[y][i]][2]:=true;
            pre[tail]:=head;
            end;
         end;
     end
  else
     begin
     for i:=1 to edge[x][0] do
         begin
         if (edge[x][i]<>y)and(not done[edge[x][i]][y][1]) then
            begin
            inc(tail);
            q[tail][1]:=edge[x][i]; q[tail][2]:=y; q[tail][3]:=1; q[tail][4]:=q[head][4];
            done[edge[x][i]][y][1]:=true;
            pre[tail]:=head;
            if (q[tail][1]=n)and(q[tail][2]=1) then
               begin
               flag:=true;
               exit;
               end;
            end;
         end;
     end;
  inc(head);
  end;
end;
begin
assign(input,'quarrel.in');
reset(input);
assign(output,'quarrel.out');
rewrite(output);
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    inc(edge[x][0]); edge[x][edge[x][0]]:=y;
    inc(edge[y][0]); edge[y][edge[y][0]]:=x;
    end;
flag:=false;
work;
if not flag then writeln(-1)
   else begin
        writeln(q[tail][4]);
        t:=tail;
        while t<>0 do
          begin
          if q[t][3]=1 then
             begin
             inc(tot);
             a[tot]:=q[t][1];
             b[tot]:=q[t][2];
             end;
          t:=pre[t];
          end;
        for i:=tot downto 2 do write(a[i],' ');
        write(a[1]);
        writeln;
        for i:=tot downto 2 do write(b[i],' ');
        write(b[1]);
        writeln;
        end;
close(input);
close(output);
end.
