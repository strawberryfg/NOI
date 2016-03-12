const maxn=200000; maxnode=677; maxq=10000000; eps=1e-4; inf=1e10;
type rec=record v,nxt:longint; w:extended; end;
var n,i,test,j,tot,maxlen:longint;
    st,en:array[0..maxn,0..2]of char;
    len:array[0..maxn]of longint;
    g:array[0..maxn]of rec;
    edge,hash,fa:array[0..maxnode]of longint;
    dis:array[0..maxnode]of extended;
    mark:array[0..maxnode]of boolean;
    q:array[0..maxq]of longint;
    la,lb,ch:char;
    le,ri,mid,ans:extended;
function cmp(x,y:extended):longint;
begin
if abs(x-y)<eps then exit(0);
if y-x>eps then exit(-1);
exit(1);
end;
procedure addedge(x,y:longint;z:extended);
begin
inc(tot); g[tot].v:=y; g[tot].w:=z; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function conv(x,y:longint):longint;
begin
conv:=(x-1)*26+y;
end;
function id(x:char):longint;
begin
id:=ord(x)-ord('a')+1;
end;
function spfa(s:longint):boolean;
var i,x,p:longint; relax:boolean;
begin
for i:=1 to maxnode do dis[i]:=0.0;
fillchar(fa,sizeof(fa),0);
fillchar(mark,sizeof(mark),false);
x:=s;
while true do
  begin
  mark[x]:=true;
  p:=edge[x];
  relax:=false;
  while p<>0 do
    begin
    if cmp(dis[x]+g[p].w,dis[g[p].v])=-1 then
       begin
       dis[g[p].v]:=dis[x]+g[p].w;
       relax:=true;
       if mark[g[p].v] then exit(false);
       fa[g[p].v]:=x;
       x:=g[p].v;
       break;
       end;
    p:=g[p].nxt;
    end;
  if relax then continue;
  mark[x]:=false; x:=fa[x];
  if x=0 then break;
  end;
exit(true);
end;
function check(x:extended):boolean;
var i,head,tail,p,j:longint;
begin
tot:=0; fillchar(edge,sizeof(edge),0);
for i:=1 to n do addedge(conv(id(st[i][1]),id(st[i][2])),conv(id(en[i][1]),id(en[i][2])),len[i]-x);
j:=1;
while (j<=676)and(spfa(j)) do
   inc(j);
if j>676 then exit(true); exit(false);
end;
procedure solve;
begin
le:=0.0; ri:=maxlen+1; ans:=inf;
while ri-le>eps do
  begin
  mid:=(le+ri)/2;
  if check(mid) then le:=mid
     else ri:=mid;
  end;
if cmp(le,maxlen)=1 then ans:=inf else ans:=le;
if cmp(ans,inf)=0 then writeln('No solution.')
   else writeln(round(ans*100)/100:0:2);
end;
begin
assign(input,'rings.in');
reset(input);
assign(output,'rings.out');
rewrite(output);
readln(n);
i:=0; test:=0;
while n<>0 do
  begin
  inc(test); maxlen:=0;
  for i:=1 to n do
      begin
      len[i]:=0;
      for j:=1 to 2 do begin st[i][j]:=char(45); en[i][j]:=char(45); end;
      la:=char(45); lb:=char(45);
      while not eoln do
        begin
        read(ch); inc(len[i]);
        if len[i]=1 then st[i][1]:=ch else if len[i]=2 then st[i][2]:=ch;
        if len[i]=1 then la:=ch else if len[i]=2 then lb:=ch else begin la:=lb; lb:=ch; end;
        end;
      if len[i]>maxlen then maxlen:=len[i];
      readln;
      en[i][1]:=la; en[i][2]:=lb;
      end;
  solve;
  readln(n);
  end;
close(input);
close(output);
end.