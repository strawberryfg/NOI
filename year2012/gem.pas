const max=65536;  maxn=1000020;
var n,m,i,j,t,res,x,l,r,delta,tmp,tr:longint;
    a:array[0..maxn]of longint;
    cnt:array[0..15,-1..max]of longint;
    ch,c:char;
    flag:boolean;
    ans:int64;
begin
assign(input,'gem.in');
reset(input);
assign(output,'gem.out');
rewrite(output);
readln(n,m);
for i:=1 to n do readln(a[i]);
for i:=1 to n do
    begin
    for j:=0 to 15 do
        begin
        t:=a[i] mod (1 shl (j+1));
        cnt[j][t]:=cnt[j][t]+1;
        end;
    end;
for i:=0 to 15 do
    begin
    for j:=0 to max do
        cnt[i][j]:=cnt[i][j-1]+cnt[i][j];
    end;
ans:=0;
for i:=1 to m do
    begin
    read(ch); read(c);
    if ch='C' then
       begin
       read(x);
       delta:=(delta+x)mod max;
       end
    else
       begin
       read(x);
       l:=1 shl x-delta;
       r:=1 shl (x+1)-1-delta;
       flag:=true;
       if l=r then flag:=false;
       if (l<0) then
          begin
          tmp:=(-l) div (1 shl (x+1));
          if (-l) mod (1 shl (x+1))=0 then dec(tmp);
          l:=l+tmp*(1 shl (x+1));
          res:=0;
          if r+tmp*(1 shl (x+1))<0 then
             begin
             l:=l+1 shl (x+1);
             r:=r+(tmp+1)*(1 shl (x+1));
             ans:=ans+cnt[x][r]-cnt[x][l-1];
             end
          else
             begin
             tr:=r+tmp*(1 shl (x+1));
             r:=1 shl (x+1);
             l:=l+1 shl (x+1);
             res:=cnt[x][r]-cnt[x][l-1];
             res:=res+cnt[x][tr];
             ans:=ans+res;
             end;
          end
       else
          begin
          res:=cnt[x][r]-cnt[x][l-1];
          ans:=ans+res;
          end;
       end;
    readln;
    end;
writeln(ans);
close(input);
close(output);
end.