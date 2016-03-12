const maxn=200;
type rec=record v,k,c:longint; end;
var xx,yy,zz,rr,tot,sum,ans,i,j,k,l,p,n:longint;
    f,tf:array[1..3,0..2*maxn]of rec;
    st,en,g:array[1..3,0..2*maxn]of longint;
    cnt:array[1..3]of longint;
    a:array[0..maxn,0..maxn,0..maxn]of longint;
    procedure sort(opt,l,r: longint);
      var
         i,j,x: longint;
         y:rec;
      begin
         i:=l;
         j:=r;
         x:=f[opt][(l+r) div 2].v;
         repeat
           while f[opt][i].v<x do
            inc(i);
           while x<f[opt][j].v do
            dec(j);
           if not(i>j) then
             begin
                y:=f[opt][i];
                f[opt][i]:=f[opt][j];
                f[opt][j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(opt,l,j);
         if i<r then
           sort(opt,i,r);
      end;
begin
assign(input,'cover.in');
reset(input);
assign(output,'cover.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    readln(xx,yy,zz,rr);
    inc(tot); f[1][tot].v:=xx-rr; f[2][tot].v:=yy-rr; f[3][tot].v:=zz-rr;
    for j:=1 to 3 do begin f[j][tot].k:=i; f[j][tot].c:=1; end;
    inc(tot); f[1][tot].v:=xx+rr; f[2][tot].v:=yy+rr; f[3][tot].v:=zz+rr;
    for j:=1 to 3 do begin f[j][tot].k:=i; f[j][tot].c:=-1; end;
    end;
tf:=f;
for i:=1 to 3 do
    begin
    f:=tf;
    sort(i,1,2*n);
    j:=1;
    sum:=0;
    while j<=2*n do
      begin
      p:=j;
      inc(sum);
      g[i][sum]:=f[i][j].v;
      if f[i][j].c=1 then st[i][f[i][j].k]:=sum
         else en[i][f[i][j].k]:=sum;
      while (p+1<=2*n)and(f[i][p+1].v=f[i][j].v) do
        begin
        inc(p);
        if f[i][p].c=1 then st[i][f[i][p].k]:=sum
           else en[i][f[i][p].k]:=sum;
        end;
      j:=p+1;
      end;
    cnt[i]:=sum;
    end;
for i:=1 to n do
    begin
    for j:=st[1][i]+1 to en[1][i] do
        for k:=st[2][i]+1 to en[2][i] do
            for l:=st[3][i]+1 to en[3][i] do
                a[j][k][l]:=1;
    end;
ans:=0;
for i:=1 to cnt[1] do
    for j:=1 to cnt[2] do
        for k:=1 to cnt[3] do
            if a[i][j][k]=1 then
               begin
               ans:=ans+(g[1][i]-g[1][i-1])*(g[2][j]-g[2][j-1])*(g[3][k]-g[3][k-1]);
               end;
writeln(ans);
close(input);
close(output);
end.
