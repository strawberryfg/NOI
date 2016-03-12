const inf=maxlongint;
var n,max,i,num,xx,y,r,g,b,now,tmp,opt,ans:longint;
    f:array[0..1,0..5,0..5,0..5,0..5]of longint;
    map:array[0..111,0..5]of longint;
    ch:char;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure update(opt,y,r,g,b,v:longint);
begin
if v>f[opt][y][r][g][b] then f[opt][y][r][g][b]:=v;
end;
begin
assign(input,'score.in');
reset(input);
assign(output,'score.out');
rewrite(output);
readln(n);
max:=0;
for i:=1 to n do
    begin
    if i>1 then read(ch);
    read(ch); num:=0;
    while (ord(ch)>=ord('0'))and(ord(ch)<=ord('9')) do begin num:=num*10+ord(ch)-ord('0'); read(ch); end;
    if ch='y' then opt:=1 else if ch='r' then opt:=2 else if ch='g' then opt:=3 else opt:=4;
    map[num][opt]:=1;
    if num>max then max:=num;
    end;
xx:=0;
for y:=0 to 3 do
    for r:=0 to 3 do
        for g:=0 to 3 do
            for b:=0 to 3 do
                f[xx][y][r][g][b]:=-inf;
f[xx][0][0][0][0]:=0;
for now:=1 to max do
    begin
    for y:=0 to 3 do
        for r:=0 to 3 do
            for g:=0 to 3 do
                for b:=0 to 3 do
                    f[xx xor 1][y][r][g][b]:=-inf;
    for y:=0 to 3 do
        for r:=0 to 3 do
            for g:=0 to 3 do
                for b:=0 to 3 do
                    if f[xx][y][r][g][b]<>-inf then
                       begin
                       if map[now][1]+map[now][2]+map[now][3]+map[now][4]=4 then
                          begin
                          tmp:=f[xx][y][r][g][b]+3*now;
                          if y=2 then tmp:=tmp+now+now-1+now-2
                             else if y=3 then tmp:=tmp+now;
                          update(xx xor 1,min(y+1,3),0,0,0,tmp);
                          tmp:=f[xx][y][r][g][b]+3*now;
                          if r=2 then tmp:=tmp+now+now-1+now-2
                             else if r=3 then tmp:=tmp+now;
                          update(xx xor 1,0,min(r+1,3),0,0,tmp);
                          tmp:=f[xx][y][r][g][b]+3*now;
                          if g=2 then tmp:=tmp+now+now-1+now-2
                             else if g=3 then tmp:=tmp+now;
                          update(xx xor 1,0,0,min(g+1,3),0,tmp);
                          tmp:=f[xx][y][r][g][b]+3*now;
                          if b=2 then tmp:=tmp+now+now-1+now-2
                             else if b=3 then tmp:=tmp+now;
                          update(xx xor 1,0,0,0,min(b+1,3),tmp);
                          tmp:=f[xx][y][r][g][b]+4*now;
                          update(xx xor 1,0,0,0,0,tmp);
                          end
                       else if map[now][1]+map[now][2]+map[now][3]+map[now][4]=3 then
                               begin
                               tmp:=f[xx][y][r][g][b]+now*3;
                               update(xx xor 1,0,0,0,0,tmp);
                               end;
                       tmp:=f[xx][y][r][g][b];
                       if map[now][1]=1 then
                          begin
                          if y=2 then tmp:=tmp+now+now-1+now-2
                             else if y=3 then tmp:=tmp+now;
                          end;
                       if map[now][2]=1 then
                          begin
                          if r=2 then tmp:=tmp+now+now-1+now-2
                             else if r=3 then tmp:=tmp+now;
                          end;
                       if map[now][3]=1 then
                          begin
                          if g=2 then tmp:=tmp+now+now-1+now-2
                             else if g=3 then tmp:=tmp+now;
                          end;
                       if map[now][4]=1 then
                          begin
                          if b=2 then tmp:=tmp+now+now-1+now-2
                             else if b=3 then tmp:=tmp+now;
                          end;
                       update(xx xor 1,min(y+1,3)*map[now][1],min(r+1,3)*map[now][2],min(g+1,3)*map[now][3],min(b+1,3)*map[now][4],tmp);
                       end;
    xx:=xx xor 1;
    end;
ans:=-inf;
for y:=0 to 3 do
    for r:=0 to 3 do
        for g:=0 to 3 do
            for b:=0 to 3 do
                if f[xx][y][r][g][b]>ans then
                   ans:=f[xx][y][r][g][b];
writeln(ans);
close(input);
close(output);
end.
