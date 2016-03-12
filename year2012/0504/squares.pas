const maxn=1020; base=10007;
type rec=record l,r,v,h:longint; end;
var n,i,j,ans,tmp:longint;
    a,xa,up:array[0..maxn,0..maxn]of longint;
    f:array[0..maxn,0..maxn,0..4]of longint;
    stack:array[0..maxn]of rec;
    ch:char;
procedure convert;
var i,j:longint;
begin
for i:=1 to n do for j:=1 to n do xa[j][n-i+1]:=a[i][j];
a:=xa;
end;
procedure init;
var i,j:longint;
begin
for i:=1 to n do for j:=1 to n do if a[i][j]=1 then up[i][j]:=up[i-1][j]+1 else up[i][j]:=0;
end;
procedure work(opt:longint);
var i,j,top,now,ll,tmp,sumh,next:longint;
begin
for i:=1 to n do
    begin
    top:=0; now:=0; sumh:=0;
    for j:=1 to n do
        begin
        f[i][j][opt]:=((f[i-1][j][opt]+f[i][j-1][opt]-f[i-1][j-1][opt]) mod base+base)mod base;
        if up[i][j]=0 then begin top:=0; now:=0; sumh:=0; continue; end;
        ll:=j;
        while (top>0)and(up[i][j]<=stack[top].h) do
          begin
          tmp:=(j-stack[top].l)*stack[top].v mod base;
          if top=1 then dec(tmp);
          tmp:=(tmp+base)mod base;
          now:=((now-tmp) mod base+base)mod base;
          sumh:=((sumh-stack[top].v)mod base+base)mod base;
          ll:=stack[top].l;
          dec(top);
          end;
        next:=top; inc(top); stack[top].l:=ll; stack[top].r:=j; stack[top].h:=up[i][j]; stack[top].v:=stack[top].h-stack[next].h;
        now:=(now+sumh)mod base;
        f[i][j][opt]:=(f[i][j][opt]+now)mod base;
        tmp:=((stack[top].r-stack[top].l+1)*stack[top].v) mod base;
        if next=0 then tmp:=(tmp-1)mod base;
        tmp:=(tmp+base)mod base;
        f[i][j][opt]:=(f[i][j][opt]+tmp)mod base;
        sumh:=(sumh+stack[top].v)mod base;
        now:=(now+tmp)mod base;
        end;
    end;
end;
begin
assign(input,'squares.in');
reset(input);
assign(output,'squares.out');
rewrite(output);
readln(n);
for i:=1 to n do
    begin
    for j:=1 to n do
        begin
        read(ch);
        if ch='B' then a[i][j]:=1 else a[i][j]:=0;
        end;
    readln;
    end;
for i:=1 to 4 do
    begin
    if i<>1 then convert;
    init;
    work(i);
    end;
ans:=0;
for i:=1 to n do begin ans:=(ans+(f[i][n][1]-f[i-1][n][1]) mod base*f[n-i][n][3] mod base) mod base; if ans<0 then ans:=ans+base; end;
for i:=1 to n do begin ans:=(ans+(f[i][n][2]-f[i-1][n][2]) mod base*f[n][n-i][3] mod base) mod base; if ans<0 then ans:=ans+base; end;
for i:=1 to n do
    for j:=1 to n do
        begin
        tmp:=(f[n-j+1][i][4]-f[n-j][i][4]-f[n-j+1][i-1][4]+f[n-j][i-1][4])mod base;
        ans:=((ans-tmp*f[j-1][n-i][2] mod base) mod base+base)mod base;
        end;
for i:=1 to n do
    for j:=1 to n do
        begin
        tmp:=(f[i][j][1]-f[i-1][j][1]-f[i][j-1][1]+f[i-1][j-1][1])mod base;
        ans:=((ans-tmp*f[n-i][n-j][3] mod base) mod base+base)mod base;
        end;
ans:=(ans+base)mod base;
writeln(ans mod base);
close(input);
close(output);
end.