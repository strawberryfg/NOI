//20:47;
const maxn=1111; maxopt=1111111; maxk=111111; inf=maxlongint;
type statype=record a,b,c:longint; end;
     quetype=record m,k,s,id:longint; end;
var n,i,maxx,opt,now,j,xx:longint;
    sta:array[0..maxn]of statype;
    que:array[0..maxopt]of quetype;
    ans:array[0..maxopt]of longint;
    f:array[0..1,0..maxk]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure sort(l,r:longint);
var i,j,cmp:longint; swap:statype;
begin
i:=l; j:=r; cmp:=sta[(l+r) div 2].a;
repeat
while sta[i].a<cmp do inc(i);
while cmp<sta[j].a do dec(j);
if not(i>j) then begin swap:=sta[i]; sta[i]:=sta[j]; sta[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure sort2(l,r:longint);
var i,j,cmp:longint; swap:quetype;
begin
i:=l; j:=r; cmp:=que[(l+r) div 2].m;
repeat
while que[i].m<cmp do inc(i);
while cmp<que[j].m do dec(j);
if not(i>j) then begin swap:=que[i]; que[i]:=que[j]; que[j]:=swap; inc(i); dec(j); end;
until i>j;
if l<j then sort2(l,j);
if i<r then sort2(i,r);
end;
begin
assign(input,'sza.in');
reset(input);
assign(output,'sza.out');
rewrite(output);
read(n);
for i:=1 to n do read(sta[i].c,sta[i].a,sta[i].b);
sort(1,n);
read(opt);
maxx:=0;
for i:=1 to opt do begin read(que[i].m,que[i].k,que[i].s); que[i].id:=i; if que[i].k>maxx then maxx:=que[i].k; end;
sort2(1,opt);
for i:=1 to maxx do f[0][i]:=-inf;
f[0][0]:=inf;
now:=0; xx:=0;
for i:=1 to opt do
    begin
    while (now+1<=n)and(sta[now+1].a<=que[i].m) do
      begin
      inc(now);
      for j:=0 to maxx do
          begin
          f[xx xor 1][j]:=f[xx][j];
          if (j-sta[now].c>=0)and(f[xx][j-sta[now].c]<>-inf) then f[xx xor 1][j]:=max(f[xx xor 1][j],min(f[xx][j-sta[now].c],sta[now].b));
          end;
      xx:=xx xor 1;
      end;
    if (sta[1].a<=que[i].m)and(f[xx][que[i].k]>que[i].m+que[i].s) then ans[que[i].id]:=1
       else ans[que[i].id]:=0;
    end;
for i:=1 to opt do if ans[i]=1 then writeln('TAK') else writeln('NIE');
close(input);
close(output);
end.