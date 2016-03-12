const maxn=20; maxans=1111111;
type rec=record c,p,l:longint; end;
var n,maxx,i,j,ans,xx,x,y,a,b,d:longint;
    sta:array[0..maxn]of rec;
    speed,dis:array[0..maxn,0..maxn]of longint;
procedure euclid(a,b:longint; var x,y:longint);
var tmp:longint;
begin
if b=0 then begin d:=a; x:=1; y:=0; exit; end;
euclid(b,a mod b,x,y);
tmp:=x; x:=y; y:=tmp-a div b*y;
end;
function check(m:longint):boolean;
var i,j:longint;
begin
for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        a:=speed[i][j]; b:=dis[i][j];
        d:=0; x:=0; y:=0;
        euclid(a,m,x,y);
        if b mod d<>0 then continue;
        xx:=x*(b div d);
        while xx<0 do xx:=xx+m div d;
        while xx-m div d>=0 do xx:=xx-m div d;
        if (xx<=sta[i].l)and(xx<=sta[j].l) then exit(false);
        end;
exit(true);
end;
begin
assign(input,'savage.in');
reset(input);
assign(output,'savage.out');
rewrite(output);
read(n);
maxx:=0;
for i:=1 to n do begin read(sta[i].c,sta[i].p,sta[i].l); if sta[i].c>maxx then maxx:=sta[i].c; end;
for i:=1 to n-1 do
    for j:=i+1 to n do
        begin
        speed[i][j]:=sta[i].p-sta[j].p; dis[i][j]:=sta[j].c-sta[i].c;
        if speed[i][j]<0 then begin speed[i][j]:=-speed[i][j]; dis[i][j]:=-dis[i][j]; end;
        end;
for ans:=maxx to maxans do if check(ans) then break;
writeln(ans);
close(input);
close(output);
end.