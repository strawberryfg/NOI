const maxn=1020; maxx=10000000;
type rec=record x,y,c:longint; end;
var n,m,i,j,sx,sy,x,y,head,tail,ans,nx,ny,tot:longint;
    a,b,cover,hash:array[0..maxn,0..maxn]of longint;
    h:array[0..maxn*maxn]of rec;
    q:array[0..maxx]of rec;
procedure pre;
var i,j,t:longint;
begin
for i:=1 to 1020 do
    for j:=1 to 1020 do
        begin
        t:=(2*(j-1)-1+1)*(j-1)div 2;
        if i<j then
           begin
           if j mod 2=1 then
              begin
              t:=t+j+j-i;
              b[i][j]:=t;
              end
           else
              begin
              t:=t+i;
              b[i][j]:=t;
              end;
           end
        else
           begin
           if i=j then b[i][j]:=t+j
              else begin
                   t:=(2*(i-1)-1+1)*(i-1)div 2;
                   if i mod 2=1 then
                      begin
                      t:=t+j;
                      b[i][j]:=t;
                      end
                   else
                      begin
                      t:=t+i+i-j;
                      b[i][j]:=t;
                      end;
                   end;
           end;
        end;
end;
procedure sort(l,r: longint);
var i,j,x: longint;
    tmp:rec;
begin
i:=l; j:=r; x:=h[(l+r) div 2].c;
repeat
while h[i].c<x do inc(i);
while x<h[j].c do dec(j);
if not(i>j) then begin tmp:=h[i]; h[i]:=h[j]; h[j]:=tmp; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
begin
assign(input,'art.in');
reset(input);
assign(output,'art.out');
rewrite(output);
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(a[i][j]);  //colour;
        end;
    readln;
    end;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(cover[i][j]); //cover;
        end;
    readln;
    end;
readln(sx,sy);
pre;
head:=1; tail:=1;
q[1].x:=sx; q[1].y:=sy;
ans:=0;
while head<=tail do
  begin
  nx:=q[head].x; ny:=q[head].y;
  hash[nx][ny]:=1; // get;
  if (a[nx][ny]<>cover[nx][ny])and(a[nx][ny]<>0) then
     begin
     tot:=0;
     for i:=1 to n do
         for j:=1 to m do
             begin
             if (a[i][j]=a[nx][ny]) then
                begin
                x:=max(nx,n-nx+1); y:=max(ny,m-ny+1);
                x:=i-nx+x; y:=j-ny+y;
                inc(tot);
                h[tot].x:=i; h[tot].y:=j; h[tot].c:=b[x][y];
                end;
             end;
     sort(1,tot);
     ans:=ans+tot;
     for i:=1 to tot do
         begin
         a[h[i].x][h[i].y]:=cover[nx][ny];
         if (cover[h[i].x][h[i].y]<>-1)and(hash[h[i].x][h[i].y]=0) then
            begin
            inc(tail);
            q[tail].x:=h[i].x; q[tail].y:=h[i].y;
            end;
         end;
     end;
  inc(head);
  end;
writeln(ans);
close(input);
close(output);
end.